#pragma once

#include <memory>
#include <map>
#include <vector>

#include "graphics.hpp"
#include "window.hpp"

class Layer {
 public:
  Layer(unsigned int id = 0);
  unsigned int ID() const;

  Layer& SetWindow(const std::shared_ptr<Window>& window);
  std::shared_ptr<Window> GetWindow() const;
  Vector2D<int> GetPosition() const;
  Layer& SetDraggable(bool draggable);
  bool IsDraggable() const;

  Layer& Move(Vector2D<int> pos);
  Layer& MoveRelative(Vector2D<int> pos_diff);

  void DrawTo(FrameBuffer& screen, const Rectangle<int>& area) const;

 private:
  unsigned int id_;
  Vector2D<int> pos_{};
  std::shared_ptr<Window> window_{};
  bool draggable_{false};
};

class LayerManager {
 public:
  void SetWriter(FrameBuffer* screen);
  Layer& NewLayer();

  /** @brief Draw layers currently displayable. */
  void Draw(const Rectangle<int>& area) const;
  void Draw(unsigned int id) const;

  void Move(unsigned int id, Vector2D<int> new_pos);
  void MoveRelative(unsigned int id, Vector2D<int> pos_diff);
  /** @brief Change layer height.
   *
   * Negative new_height makes the layer not display.
   * Positive new_height makes the layer specified height.
   * If new_height is larger than current layer height, the layer will be foremost.
   */
  void UpDown(unsigned int id, int new_height);
  /** @brief Make a layer not display. */
  void Hide(unsigned int id);

  Layer* FindLayerByPosition(Vector2D<int> pos, unsigned int exclude_id) const;

 private:
  FrameBuffer* screen_{nullptr};
  mutable FrameBuffer back_buffer_{};
  std::vector<std::unique_ptr<Layer>> layers_{};
  std::vector<Layer*> layer_stack_{};
  unsigned int latest_id_{0};

  Layer* FindLayer(unsigned int id);
};

extern LayerManager* layer_manager;
