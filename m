From: Ong Boon Leong <boon.leong.ong@intel.com>
Subject: [PATCH] Intel Quark X1000 DTS thermal driver
Date: Thu, 12 Feb 2015 00:51:48 +0800
Message-ID: <1423673509-11195-1-git-send-email-boon.leong.ong@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27602 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbbBKQxs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Feb 2015 11:53:48 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Dear maintainers,

This patch introduces DTS thermal driver for Intel Quark X1000.
The code implementation is based on intel_soc_dts_thermal.c.

Intel Quark X1000 has one on-die DTS with two configurable trip points:
critical and hot trip points. However, todate, UEFI BIOS for Quark X1000
uses only critical trip point. UEFI BIOS always lock DTS register before
hand-over to Linux kernel.

The minimalist thermal design is meant to trigger Linux distro to gracefully
power-down the system when its DTS temperature exceeds the configured critical
trip point.

In anticipation that other variant of Quark platform may come with UEFI BIOS
that does not lock DTS register during hand-over, this DTS driver is built
with logics to handle such case too.

I have tested v1 of the patch on Intel Galileo Gen v2 board and found it
satisfactory with logs below:

  root@quark:/sys/class/thermal/thermal_zone0# echo disabled > mode
  [   46.276881] intel_quark_dts_thermal: DTS is locked. Cannot disable DTS
  -sh: echo: write error: Operation not permitted
  root@quark:/sys/class/thermal/thermal_zone0#
  root@quark:/sys/class/thermal/thermal_zone0# cat temp
  53
  root@quark:/sys/class/thermal/thermal_zone0# cat trip_point_0_temp
  105
  root@quark:/sys/class/thermal/thermal_zone0# cat trip_point_0_type
  critical
  root@quark:/sys/class/thermal/thermal_zone0# cat trip_point_1_temp
  205
  root@quark:/sys/class/thermal/thermal_zone0# cat trip_point_1_type
  hot
  root@quark:/sys/class/thermal/thermal_zone0# cat type
  quark_dts

  root@quark:/sys/class/thermal/thermal_zone0# echo 105 > emul_temp
  [  179.372981] thermal thermal_zone0: critical temperature reached(0 C),shutting down
  root@quark:/sys/class/thermal/thermal_zone0#          Stopping WPA supplicant...
  [  OK  ] Stopped target Multi-User System.
           Stopping Telephony service...
           Stopping Lightning Fast Webserver With Light System Requirements...
           Stopping Target Communication Framework agent...
           Stopping Galileo Arduino Layer...
  [  OK  ] Stopped target Login Prompts.
           Stopping Getty on tty1...
           Stopping Serial Getty on ttyS1...
           Stopping Login Service...
           Stopping D-Bus System Message Bus...
           Starting Store Sound Card State...
  [  OK  ] Stopped Telephony service.
  [  OK  ] Stopped Galileo Arduino Layer.
  [  OK  ] Stopped Login Service.
  [  OK  ] Stopped D-Bus System Message Bus.
  [  OK  ] Stopped Target Communication Framework agent.
  [  OK  ] Stopped Lightning Fast Webserver With Light System Requirements.
  [  OK  ] Stopped WPA supplicant.
  [  OK  ] Stopped Getty on tty1.
  [  OK  ] Stopped Serial Getty on ttyS1.

Please kindly review the patch at your convenient time and provide me feedback
for improvement. Appreciate your time and effort.

Thank You
Ong Boon Leong
Intel Corp.

Ong Boon Leong (1):
  thermal: intel Quark SoC X1000 DTS thermal driver

 drivers/thermal/Kconfig                   |   10
 drivers/thermal/Makefile                  |    1
 drivers/thermal/intel_quark_dts_thermal.c |  408 +++++++++++++++++++++++++++++
 3 files changed, 419 insertions(+)
 create mode 100644 drivers/thermal/intel_quark_dts_thermal.c

-- 
1.7.9.5

