From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v2 0/3] Hierarchical thermal zones
Date: Wed,  4 Nov 2015 17:37:39 +0000
Message-ID: <1446658662-19582-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33244 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756033AbbKDRh4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Nov 2015 12:37:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rui.zang@intel.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>

This series adds the ability to create a hierarchy of thermal zones.
Thermal zones created via platform code or device tree can be set up
to calculate their temperature as the maximum of all its underlying
thermal zones.  This came up from discussions during LPC.

The first patch adds the basic support to thermal core.  Patch 2 adds
device tree support and patch 3 exports the hierarchy to sysfs.

Changes since v1:
  - Fix the prototype of thermal_zone_{add,del}_subtz() for
    !CONFIG_THERMAL as reported by the kbuild test robot

Javi Merino (3):
  thermal: Add support for hierarchical thermal zones
  thermal: of: parse stacked thermal zones from device tree
  thermal: show the sub thermal zones in sysfs

 .../devicetree/bindings/thermal/thermal.txt        | 154 +++++++++++++++++-
 Documentation/thermal/sysfs-api.txt                |  40 +++++
 drivers/thermal/of-thermal.c                       |  99 ++++++++++++
 drivers/thermal/thermal_core.c                     | 173 ++++++++++++++++++++-
 include/linux/thermal.h                            |  17 ++
 5 files changed, 475 insertions(+), 8 deletions(-)

-- 
1.9.1

