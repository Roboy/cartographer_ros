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
TRAJECTORY_BUILDER_2D = {
  use_imu_data = true,
  min_range = 0.25,
  max_range = 30.,
  --min_z = -0.8,
  --max_z = 2.,
  --missing_data_ray_length = 5., --5,
  num_accumulated_range_data = 20,
  --voxel_filter_size = 0.1, --0.025,
  adaptive_voxel_filter = {
    max_length = 10, --0.5, 
    --min_num_points = 70 --200,
    --max_range = 50.,
  },
  motion_filter = {
    --max_time_seconds = 5.,
    max_distance_meters = 0.05, --0.2, 
    --max_angle_radians = math.rad(1.),
  },
}

-- -- LOCAL -- --
TRAJECTORY_BUILDER_2D = {
  loop_closure_adaptive_voxel_filter = {
    --max_length = 0.1,
    --min_num_points = 100,
    --max_range = 50.,
  },
  use_online_correlative_scan_matching = true,
  real_time_correlative_scan_matcher = {
    linear_search_window = 0.2, --0.1,
    angular_search_window = math.rad(20.),
    --translation_delta_cost_weight = 1e-1,
    --rotation_delta_cost_weight = 1e-1,
  },
  ceres_scan_matcher = {
    --occupied_space_weight = 1.,
    translation_weight = 20, --10.,
    rotation_weight = 2e3, --40.,
    ceres_solver_options = {
      use_nonmonotonic_steps = true,
      --max_num_iterations = 20,
      num_threads = 28,
    },
  },
  --imu_gravity_time_constant = 10.,
  submaps = {
    num_range_data = 12, --90,
    grid_options_2d = {
      --grid_type = "PROBABILITY_GRID",
      resolution = 0.1, --0.05,
    },
    range_data_inserter = {
      --range_data_inserter_type = "PROBABILITY_GRID_INSERTER_2D",
      probability_grid_range_data_inserter = {
        --insert_free_space = true,
        --hit_probability = 0.55,
        --miss_probability = 0.49,
      },
      tsdf_range_data_inserter = {
        --truncation_distance = 0.3,
        --maximum_weight = 10.,
        --update_free_space = false,
        normal_estimation_options = {
          --num_normal_samples = 4,
          --sample_radius = 0.5,
        },
        --project_sdf_distance_to_scan_normal = true,
        --update_weight_range_exponent = 0,
        --update_weight_angle_scan_normal_to_ray_kernel_bandwidth = 0.5,
        --update_weight_distance_cell_to_hit_kernel_bandwidth = 0.5,
      },
    },
  },
}

-- -- GLOBAL -- --
POSE_GRAPH = {
  optimize_every_n_nodes = 0,
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
    acceleration_weight = 1e5,
    rotation_weight = 3e7,
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
