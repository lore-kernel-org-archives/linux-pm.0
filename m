From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] PM / OPP: Add missing doc comments
Date: Mon, 16 Nov 2015 16:07:26 +0530
Message-ID: <d08ce7e01f31f9c8423b76f6bdf32dfbf93a6927.1447669859.git.viresh.kumar@linaro.org>
References: <cover.1447669859.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32918 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbKPKiG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 05:38:06 -0500
Received: by pabfh17 with SMTP id fh17so174044590pab.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2015 02:38:06 -0800 (PST)
In-Reply-To: <cover.1447669859.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1447669859.git.viresh.kumar@linaro.org>
References: <cover.1447669859.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

Few doc-style comments were missing, add them. Rearrange another one to
match the sequence within the structure.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/opp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index a6bd8d2c2b47..b8880c7f8be1 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -51,8 +51,8 @@ extern struct mutex dev_opp_list_lock;
  *		are protected by the dev_opp_list_lock for integrity.
  *		IMPORTANT: the opp nodes should be maintained in increasing
  *		order.
- * @dynamic:	not-created from static DT entries.
  * @available:	true/false - marks if this OPP as available or not
+ * @dynamic:	not-created from static DT entries.
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
  * @rate:	Frequency in hertz
@@ -126,7 +126,9 @@ struct device_list_opp {
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	list of opps
  * @np:		struct device_node pointer for opp's DT node.
+ * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
+ * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
-- 
2.6.2.198.g614a2ac

