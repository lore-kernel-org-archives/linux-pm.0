From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH RESEND 4/4] thermal: check for invalid trip setup when registering thermal device
Date: Wed, 2 Jan 2013 17:29:42 +0200
Message-ID: <1357140582-8151-5-git-send-email-eduardo.valentin@ti.com>
References: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39987 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab3ABPbO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jan 2013 10:31:14 -0500
In-Reply-To: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: durgadoss.r@intel.com, linux-pm@lists.linux-foundation.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

This patch adds an extra check in the data structure while registering
a thermal device. The check is to avoid registering zones with a number
of trips greater than zero, but with no .get_trip_temp nor .get_trip_type
callbacks. Receiving such data structure may end in wrong data access.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/thermal_sys.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index fba27c3..0a1bf6b 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1530,6 +1530,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (!ops || !ops->get_temp)
 		return ERR_PTR(-EINVAL);
 
+	if (trips > 0 && !ops->get_trip_type)
+		return ERR_PTR(-EINVAL);
+
 	tz = kzalloc(sizeof(struct thermal_zone_device), GFP_KERNEL);
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
-- 
1.7.7.1.488.ge8e1c

