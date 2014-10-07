From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 2/3] power: core: Add variables related temperature to
 power_supply_info.
Date: Tue, 07 Oct 2014 19:58:37 +0900
Message-ID: <1412679518-21499-3-git-send-email-jonghwa3.lee@samsung.com>
References: <1412679518-21499-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:14259 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbaJGK6v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Oct 2014 06:58:51 -0400
In-reply-to: <1412679518-21499-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, jenny.tc@intel.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

To represent thermal limitation of power_supply, it adds 'temperature_max,
temperature_min' to power_supply_info structure.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 include/linux/power_supply.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 99306aa..0c8588c 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -241,6 +241,8 @@ struct power_supply_info {
 	int charge_empty_design;
 	int energy_full_design;
 	int energy_empty_design;
+	int temperature_max;
+	int temperature_min;
 	int use_for_apm;
 };
 
-- 
1.7.9.5

