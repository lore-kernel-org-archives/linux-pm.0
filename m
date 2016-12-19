From: Markus Mayer <code@mmayer.net>
Subject: [PATCH 1/2] cpufreq: brcmstb-avs-cpufreq: extend sysfs entry brcm_avs_pmap
Date: Mon, 19 Dec 2016 12:10:27 -0800
Message-ID: <20161219201028.18885-2-code@mmayer.net>
References: <20161219201028.18885-1-code@mmayer.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-so.shaw.ca ([64.59.136.138]:54258 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbcLSUKg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 15:10:36 -0500
In-Reply-To: <20161219201028.18885-1-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

From: Markus Mayer <mmayer@broadcom.com>

We extend the brcm_avs_pmap sysfs entry (which issues the GET_PMAP
command to AVS) to include all fields from struct pmap. This means
adding mode (AVS, DVS, DVFS) and state (the P-state) to the output.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 4fda623..2c6e325 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -954,9 +954,9 @@ static ssize_t show_brcm_avs_pmap(struct cpufreq_policy *policy, char *buf)
 	brcm_avs_parse_p1(pmap.p1, &mdiv_p0, &pdiv, &ndiv);
 	brcm_avs_parse_p2(pmap.p2, &mdiv_p1, &mdiv_p2, &mdiv_p3, &mdiv_p4);
 
-	return sprintf(buf, "0x%08x 0x%08x %u %u %u %u %u %u %u\n",
+	return sprintf(buf, "0x%08x 0x%08x %u %u %u %u %u %u %u %u %u\n",
 		pmap.p1, pmap.p2, ndiv, pdiv, mdiv_p0, mdiv_p1, mdiv_p2,
-		mdiv_p3, mdiv_p4);
+		mdiv_p3, mdiv_p4, pmap.mode, pmap.state);
 }
 
 static ssize_t show_brcm_avs_voltage(struct cpufreq_policy *policy, char *buf)
-- 
2.7.4

