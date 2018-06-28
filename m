From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2 0/4] Add devicetree functionality to w1 busses
Date: Thu, 28 Jun 2018 09:55:36 +0200
Message-ID: <20180628075540.1757-1-daniel@zonque.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu
Cc: sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

This patch set contains four small patches that bring devicetree
functionality to w1 bus masters and slaves in general. As an example,
the DS2760 driver is made aware of devicetree nodes as an example.
Other drivers can easily be ported later.

W1 masters scan their bus in order to discover slave devices. Once
one is found, a driver matching the family of the device is instanciated
which handles it.

All that's needed for now is a call to of_find_matching_node() when
a slave device is attached, so the corresponding of_node pointer is
set. For devices such as the DS2760, another driver is probed which
can access the w1 slave through dev->parent.

Patch #1 adds some DT bindings documentation
Patch #2 adds the call to of_find_matching_node()
Patch #3 implements the match table for the DS2760 w1 slave
Patch #4 makes the DS2760 supply driver aware of DT environments

This works fine on a PXA3xx based board with a battery attached to
the w1-gpio bus master controller.

Daniel Mack (4):
  dt-bindings: w1: document sub-node bindings for DS2760
  w1: core: match sub-nodes of bus masters in devicetree
  w1: ds2760: add devicetree matching glue
  power: ds2760_battery: add device tree glue

 .../devicetree/bindings/w1/maxim,ds2760.txt    | 15 +++++++++++++++
 .../devicetree/bindings/w1/w1-gpio.txt         |  6 ++++++
 Documentation/devicetree/bindings/w1/w1.txt    | 18 ++++++++++++++++++
 drivers/power/supply/ds2760_battery.c          |  6 +++++-
 drivers/w1/slaves/w1_ds2760.c                  |  9 +++++++++
 drivers/w1/w1.c                                |  3 +++
 include/linux/w1.h                             |  2 ++
 7 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/w1/maxim,ds2760.txt
 create mode 100644 Documentation/devicetree/bindings/w1/w1.txt

-- 
2.17.1
