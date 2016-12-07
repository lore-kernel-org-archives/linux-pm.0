From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 02/10] PM / OPP: Remove useless TODO
Date: Wed,  7 Dec 2016 10:11:58 +0530
Message-ID: <71055c2e44b02e54bad9f420e3f7edcf3092d263.1481085478.git.viresh.kumar@linaro.org>
References: <cover.1481085478.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35390 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbcLGEmU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 23:42:20 -0500
Received: by mail-pg0-f52.google.com with SMTP id p66so157299477pga.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2016 20:42:19 -0800 (PST)
In-Reply-To: <cover.1481085478.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481085478.git.viresh.kumar@linaro.org>
References: <cover.1481085478.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

This TODO doesn't make sense anymore as we have all the information in a
single OPP table. Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/of.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 356c75edd656..996ca3b42f47 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -246,8 +246,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 static struct device_node *_of_get_opp_desc_node(struct device *dev)
 {
 	/*
-	 * TODO: Support for multiple OPP tables.
-	 *
 	 * There should be only ONE phandle present in "operating-points-v2"
 	 * property.
 	 */
-- 
2.7.1.410.g6faf27b

