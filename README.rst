.. Copyright 2016 The Cartographer Authors

.. Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

..      http://www.apache.org/licenses/LICENSE-2.0

.. Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

============================
Cartographer ROS Integration
============================

|build| |docs| |license|

Purpose
=======

`Cartographer`_ is a system that provides real-time simultaneous localization
and mapping (`SLAM`_) in 2D and 3D across multiple platforms and sensor
configurations. This project provides Cartographer's ROS integration.

.. _Cartographer: https://github.com/googlecartographer/cartographer
.. _SLAM: https://en.wikipedia.org/wiki/Simultaneous_localization_and_mapping

Getting started
===============

* Learn to use Cartographer with ROS at `our Read the Docs site`_.
* You can ask a question by `creating an issue`_.

.. _our Read the Docs site: https://google-cartographer-ros.readthedocs.io
.. _creating an issue: https://github.com/googlecartographer/cartographer_ros/issues/new?labels=question

Some useful syntax
==================

Record a  `.bag`-file
---------------------
Create Roboys own bag `like here`_.

.. _like here: https://google-cartographer-ros.readthedocs.io/en/latest/your_bag.html

Check your `.bag`-file
----------------------
[ROS Bag files](http://wiki.ros.org/Bags)::

	rosrun cartographer_ros cartographer_rosbag_validate -bag_filename your_bag.bag

Get sample `.bag`-files
-----------------------
::
	wget -P ~/Downloads https://storage.googleapis.com/cartographer-public-data/bags/backpack_2d/cartographer_paper_deutsches_museum.bag


Run Cartographer online
-----------------------
According files for Roboy are defined. To test with Roboys bag run::

	roslaunch cartographer_ros roboy_indoor_online.launch 
	rosbag play ${HOME}/Downloads/cartographer_paper_deutsches_museum.bag

Run Cartographer offline on a  `.bag`-file
------------------------------------------
According files for Roboy are defined. To test with Roboys bag run::

	roslaunch cartographer_ros roboy_indoor_offline.launch bag_filename:=${HOME}/Downloads/cartographer_paper_deutsches_museum.bag

Save a Map 
----------
Instances given for saving a map after SLAM has finished to [generate a `.pbstream`-file](https://github.com/googlecartographer/cartographer_ros/blob/master/docs/source/assets_writer.rst) and then converting it to a ROS `.yaml` map file::

	# Finish the first trajectory. No further data will be accepted on it.
	rosservice call /finish_trajectory 0

	# Ask Cartographer to serialize its current state.
	# (press tab to quickly expand the parameter syntax)
	rosservice call /write_state "{filename: '${HOME}/Downloads/b3-2016-04-05-14-14-00.bag.pbstream', include_unfinished_submaps: 'true'}"

Visualize `.pbstream`-file::

	roslaunch cartographer_ros visualize_pbstream.launch pbstream_filename:=${HOME}/Downloads/DeuMu.bag.pbstream

Convert  `.pbstream`-file to `.yaml` map file::

	rosrun cartographer_ros cartographer_pbstream_to_ros_map -pbstream_filename ${HOME}/Downloads/DeuMu.bag.pbstream

Pure Localization
-----------------
Launch cartographer_ros and provide it with the `.pbstream`-file saved from a previous offline-run with SLAM::

	roslaunch cartographer_ros roboy_localization.launch load_state_filename:=${HOME}/Downloads/DeuMu.bag.pbstream

Play a `.bag`-file faking the live location of the robot::

	rosbag play ${HOME}/Downloads/b2-2016-04-27-12-31-41.bag

options to pick from for the `.bag`-files::

	${HOME}/Downloads/cartographer_paper_deutsches_museum.bag
	${HOME}/Downloads/b2-2016-04-27-12-31-41.bag
	${HOME}/Downloads/b2-2016-04-05-14-44-52.bag


Contributing
============

You can find information about contributing to Cartographer's ROS integration
at `our Contribution page`_.

.. _our Contribution page: https://github.com/googlecartographer/cartographer_ros/blob/master/CONTRIBUTING.md

.. |build| image:: https://travis-ci.org/googlecartographer/cartographer_ros.svg?branch=master
    :alt: Build Status
    :scale: 100%
    :target: https://travis-ci.org/googlecartographer/cartographer_ros
.. |docs| image:: https://readthedocs.org/projects/google-cartographer-ros/badge/?version=latest
    :alt: Documentation Status
    :scale: 100%
    :target: https://google-cartographer-ros.readthedocs.io/en/latest/?badge=latest
.. |license| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
     :alt: Apache 2 license.
     :scale: 100%
     :target: https://github.com/googlecartographer/cartographer_ros/blob/master/LICENSE

