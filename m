From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v3 0/4] Hierarchical thermal zones
Date: Wed, 25 Nov 2015 15:09:42 +0000
Message-ID: <1448464186-26289-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40271 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbbKYPKB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Nov 2015 10:10:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rui.zang@intel.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>

This series adds the ability to create a hierarchy of thermal zones.
Thermal zones created via platform code or device tree can be set up
to calculate their temperature as the maximum or weighted average of
all its underlying thermal zones.  This came up from discussions
during LPC.

The first patch adds the basic support to thermal core.  Patch 2
extends the devicetree bindings to cope with a hierarchy of thermal
zones.  Patch 3 adds device tree support.  The last patch exports the
hierarchy to sysfs, adding knobs to change the aggregation function
and adjust the weights of thermal zones.

Changes since v2:
  - The aggregation function can be maximum or weighted average
  - Separated the update of the devicetree binding and the of-thermal
    into two separate patches

Javi Merino (4):
  thermal: Add support for hierarchical thermal zones
  devicetree: bindings: let thermal-sensor point to other thermal zones
  thermal: of: parse stacked thermal zones from device tree
  thermal: show the sub thermal zones in sysfs

 .../devicetree/bindings/thermal/thermal.txt        | 154 +++++++++-
 Documentation/thermal/sysfs-api.txt                |  72 +++++
 drivers/thermal/of-thermal.c                       | 100 ++++++
 drivers/thermal/thermal_core.c                     | 335 ++++++++++++++++++++-
 include/linux/thermal.h                            |  44 ++-
 5 files changed, 696 insertions(+), 9 deletions(-)

-- 
1.9.1

