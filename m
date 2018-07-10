From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 0/2] Minor thermal_hwmon cleanups
Date: Tue, 10 Jul 2018 16:40:33 +0100
Message-ID: <20180710154035.26828-1-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

These two patches address a couple of minor issues I noticed while
hacking on a Chromebook (Google kevin platform).

The first one converts the device name passed to hwmon to containing
'_' instead of '-' (which hwmon barfs at).

The second one passes the thermal zone device to the hwmon subsystem,
making sure that messages from hwmon are not completely misleading,
and placing the related hwmon device at the correct spot in the
hierarchy.

Thanks,

	M.

Marc Zyngier (2):
  thermal_hwmon: Sanitize attribute name passed to hwmon
  thermal_hwmon: Pass the originating device down to
    hwmon_device_register_with_info

 drivers/thermal/thermal_hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.18.0
