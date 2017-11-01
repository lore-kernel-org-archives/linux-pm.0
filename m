From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/3] thermal: Support for Coffee Lake and Cannon Lake
Date: Wed,  1 Nov 2017 09:39:48 -0700
Message-ID: <20171101163951.27332-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Added support for PCH and processor thermal device.

v2:
	Fixed the issue for CFL PCI id.


Srinivas Pandruvada (3):
  thermal: int340x: processor_thermal: Add Cannon Lake support
  thermal: int340x: processor_thermal: Add Coffee Lake support
  thermal: pch: Add Cannon Lake support

 drivers/thermal/int340x_thermal/processor_thermal_device.c |  6 ++++++
 drivers/thermal/intel_pch_thermal.c                        | 11 +++++++++++
 2 files changed, 17 insertions(+)

-- 
2.13.6
