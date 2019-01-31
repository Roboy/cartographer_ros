include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "base_link",
  published_frame = "base_link",
  odom_frame = "odom",
  provide_odom_frame = true,
  publish_frame_projected_to_2d = false,
  use_odometry = false,
  use_nav_sat = false,
  use_landmarks = false,
  num_laser_scans = 1,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 10,
  num_point_clouds = 0,
  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

MAP_BUILDER.use_trajectory_builder_2d = true
MAP_BUILDER.num_background_threads = 28

-- -- INPUT DATA -- --
TRAJECTORY_BUILDER_2D.min_range = 0.25
TRAJECTORY_BUILDER_2D.max_range = 30

TRAJECTORY_BUILDER_2D.num_accumulated_range_data = 20

TRAJECTORY_BUILDER_2D.voxel_filter_size = 0.1
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.max_length = 10
--TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.min_num_points = 70

TRAJECTORY_BUILDER_2D.use_imu_data = true


-- -- LOCAL -- --
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.use_nonmonotonic_steps = true
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.num_threads = 28
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.max_num_iterations = 30
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight = 20
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 2000

TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.2
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.angular_search_window = math.rad(20.0)
--TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.translation_delta_cost_weight = 1e-5
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.rotation_delta_cost_weight= 1e-1

TRAJECTORY_BUILDER_2D.motion_filter.max_time_seconds = 5.
TRAJECTORY_BUILDER_2D.motion_filter.max_distance_meters = 0.05
TRAJECTORY_BUILDER_2D.motion_filter.max_angle_radians = math.rad(1.0)

TRAJECTORY_BUILDER_2D.submaps.num_range_data = 12
TRAJECTORY_BUILDER_2D.submaps.grid_options_2d.resolution = 0.1

--TRAJECTORY_BUILDER_2D.num_accumulated_range_data = 1080

-- -- GLOBAL -- --
POSE_GRAPH = {
  optimize_every_n_nodes = 100,
  constraint_builder = {
    --sampling_ratio = 0.3,
    max_constraint_distance = 10.0,
    min_score = 0.68,
    --global_localization_min_score = 0.6,
    --loop_closure_translation_weight = 1.1e4,
    --loop_closure_rotation_weight = 1e5,
    --log_matches = true,
    fast_correlative_scan_matcher = {
      linear_search_window = 100,
      angular_search_window = math.rad(90.),
      --branch_and_bound_depth = 10,
    },
    ceres_scan_matcher = {
      --occupied_space_weight = 20.,
      --translation_weight = 10.,
      --rotation_weight = 1.,
      ceres_solver_options = {
        --use_nonmonotonic_steps = true,
        --max_num_iterations = 10,
        --num_threads = 28,
      },
    },
  },
  --matcher_translation_weight = 5e2,
  --matcher_rotation_weight = 1.6e3,
  optimization_problem = {
    --huber_scale = 1e1,
    --acceleration_weight = 1e3,
    --rotation_weight = 3e5,
    --local_slam_pose_translation_weight = 1e5,
    --local_slam_pose_rotation_weight = 1e5,
    --odometry_translation_weight = 1e5,
    --odometry_rotation_weight = 1e5,
    --fixed_frame_pose_translation_weight = 1e1,
    --fixed_frame_pose_rotation_weight = 1e2,
    --log_solver_summary = false,
    ceres_solver_options = {
      --use_nonmonotonic_steps = false,
      --max_num_iterations = 50,
      num_threads = 28,
    },
  },
  max_num_final_iterations = 10,
  --global_sampling_ratio = 0.003,
  --log_residual_histograms = true,
  --global_constraint_search_after_n_seconds = 10.,
  overlapping_submaps_trimmer_2d = {
  --    fresh_submaps_count = 1,
  --    min_covered_area = 2,
  --    min_added_submaps_count = 5,
  },
}

return options



