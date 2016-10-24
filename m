From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 2/9] PM / Domain: Add residency property to genpd states
Date: Mon, 24 Oct 2016 15:21:01 -0700
Message-ID: <1477347668-41901-3-git-send-email-lina.iyer@linaro.org>
References: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33253 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965674AbcJXWVS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 18:21:18 -0400
Received: by mail-pf0-f170.google.com with SMTP id 128so106323474pfz.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2016 15:21:18 -0700 (PDT)
In-Reply-To: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>

Residency of a domain's idle state indicates that the minimum idle time
for the domain's idle state to be beneficial for power. Add the
parameter to the state node. Future patches, will use the residency
value in the genpd governor to determine if it is worth while to enter
an idle state.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_domain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index de1d8f3..f4492eb 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -38,6 +38,7 @@ struct gpd_dev_ops {
 struct genpd_power_state {
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
+	s64 residency_ns;
 };
 
 struct generic_pm_domain {
-- 
2.7.4

