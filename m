From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 0/3] Hierarchical thermal zones
Date: Fri, 30 Oct 2015 16:46:08 +0000
Message-ID: <1446223571-23272-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44723 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758492AbbJ3Qqh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 Oct 2015 12:46:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rui.zang@intel.com, edubezval@gmail.com, Punit.Agrawal@arm.com, Javi Merino <javi.merino@arm.com>

This series adds the ability to create a hierarchy of thermal zones.
Thermal zones created via platform code or device tree can be set up
to calculate their temperature as the maximum of all its underlying
thermal zones.  This came up from discussions during LPC.

The first patch adds the basic support to thermal core.  Patch 2 adds
device tree support and patch 3 exports the hierarchy to sysfs.

Javi Merino (3):
  thermal: Add support for hierarchical thermal zones
  thermal: of: parse stacked thermal zones from device tree
  thermal: show the sub thermal zones in sysfs

 .../devicetree/bindings/thermal/thermal.txt        | 154 +++++++++++++++++-
 Documentation/thermal/sysfs-api.txt                |  40 +++++
 drivers/thermal/of-thermal.c                       |  98 ++++++++++++
 drivers/thermal/thermal_core.c                     | 173 ++++++++++++++++++++-
 include/linux/thermal.h                            |  19 +++
 5 files changed, 476 insertions(+), 8 deletions(-)

-- 
1.9.1

