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

Documentation
=============
PDF containing `Google Cartographer_ROS documentation`_ .

.. _Google Cartographer_ROS documentation: https://media.readthedocs.org/pdf/google-cartographer-ros/latest/google-cartographer-ros.pdf


Some useful syntax
==================

Record a  `.bag`-file
---------------------
Create Roboys own bag `like here`_.

.. _like here: https://google-cartographer-ros.readthedocs.io/en/latest/your_bag.html

Check your `.bag`-file
----------------------
`ROS Bag files`_ 

.. _ROS Bag files: http://wiki.ros.org/Bags

::

	rosrun cartographer_ros cartographer_rosbag_validate -bag_filename your_bag.bag

Get sample `.bag`-files
-----------------------
Get sample `.bag`-files::

	wget -P ~/Downloads https://storage.googleapis.com/cartographer-public-data/bags/backpack_2d/cartographer_paper_deutsches_museum.bag
	wget -P ~/Downloads https://storage.googleapis.com/cartographer-public-data/bags/backpack_2d/b2-2016-04-05-14-44-52.bag
	wget -P ~/Downloads https://storage.googleapis.com/cartographer-public-data/bags/backpack_2d/b2-2016-04-27-12-31-41.bag

Cut `.bag`-files
----------------
Cut certain timeframe from `.bag`-file: ::
	rosbag filter ${HOME}/Downloads/b-2016-04-27-12-31-41.bag ${HOME}/Downloads/DeuMuRob_1.bag "t.secs>= 1461760303 and t.secs <= 1461760503"


Run Cartographer online
-----------------------
According files for Roboy are defined. To test with Roboy's bag run::

	roslaunch cartographer_ros roboy_indoor_online.launch 
	rosbag play ${HOME}/Downloads/cartographer_paper_deutsches_museum.bag

Run Cartographer offline on a  `.bag`-file
------------------------------------------
According files for Roboy are defined. To test with Roboys bag run::

	roslaunch cartographer_ros roboy_indoor_offline.launch bag_filename:=${HOME}/Downloads/cartographer_paper_deutsches_museum.bag

Save a Map 
----------
Instances given for saving a map after SLAM has finished to `generate a .pbstream-file`_ and then converting it to a ROS `.yaml` map file  

.. _generate a .pbstream-file: https://github.com/googlecartographer/cartographer_ros/blob/master/docs/source/assets_writer.rst

::

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

	rosbag play ${HOME}/Downloads/b2-2016-04-05-14-44-52.bag

options to pick from for the `.bag`-files::

	${HOME}/Downloads/cartographer_paper_deutsches_museum.bag
	${HOME}/Downloads/b2-2016-04-27-12-31-41.bag
	${HOME}/Downloads/b2-2016-04-05-14-44-52.bag

Structure
=========
Launch Files
------------
`.launch`-files of cartographer_ros are located at `src/cartographer_ros/cartographer_ros/launch`_. Make sure you call the according `roboy` files in your launch file. Also, for the SICK LIDAR note `this github issue`_.

.. _src/cartographer_ros/cartographer_ros/launch: https://github.com/Roboy/cartographer_ros/tree/c4a82825c947e6853b1fc0132a6c53e486d7a63a/cartographer_ros/launch
.. _this github issue: https://github.com/SICKAG/sick_scan/issues/5

Configuration Files
-------------------
Configuration is stored in  `.lua`-files located at `src/cartographer_ros/cartographer_ros/configuration`_. `How to use them in cartographer.` 

.. _src/cartographer_ros/cartographer_ros/configuration: https://github.com/Roboy/cartographer_ros/tree/c4a82825c947e6853b1fc0132a6c53e486d7a63a/cartographer_ros/configuration_files
.. _How to use them in cartographer.: https://google-cartographer-ros.readthedocs.io/en/latest/configuration.html

URDF Files
----------
`urdf`-files essentially define the physical configuration of the robot such as relative positions of different sensors. More can be found in the `ROS wiki about urdf`_ .
In cartographer_ros, these are located at `src/cartographer_ros/cartographer_ros/urdf`_.

.. _ROS wiki about urdf: http://wiki.ros.org/urdf
.. _src/cartographer_ros/cartographer_ros/urdf: https://github.com/Roboy/cartographer_ros/tree/c4a82825c947e6853b1fc0132a6c53e486d7a63a/cartographer_ros/urdf

Roboy
=====

There are online, offline and localization scripts for Roboy so far.

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

