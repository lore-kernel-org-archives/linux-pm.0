From: Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v1 4/4] of: Remove of_system_has_poweroff_source helper function
Date: Wed, 29 Oct 2014 07:35:35 +0000
Message-ID: <1414568135-8311-5-git-send-email-romain.perier@gmail.com>
References: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:43399 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbaJ2Hc3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 03:32:29 -0400
In-Reply-To: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de
Cc: grant.likely@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, johan@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org

It was only used as backward compatibility to avoid broken
bisections, until all dependent drivers use the new helper
function.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 include/linux/of.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index e7177b3..229798b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -912,9 +912,5 @@ extern int of_resolve_phandles(struct device_node *tree);
 
 bool of_is_system_power_controller(const struct device_node *np);
 
-static inline bool of_system_has_poweroff_source(const struct device_node *np)
-{
-	return of_is_system_power_controller(np);
-}
 
 #endif /* _LINUX_OF_H */
-- 
1.9.1

