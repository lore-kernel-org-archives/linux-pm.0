From: Markus Mayer <code@mmayer.net>
Subject: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: properly retrieve P-state upon suspend
Date: Mon, 19 Dec 2016 12:10:28 -0800
Message-ID: <20161219201028.18885-3-code@mmayer.net>
References: <20161219201028.18885-1-code@mmayer.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-so.shaw.ca ([64.59.136.138]:54258 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755190AbcLSUKs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 15:10:48 -0500
In-Reply-To: <20161219201028.18885-1-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

From: Markus Mayer <mmayer@broadcom.com>

The AVS GET_PMAP command does return a P-state along with the P-map
information. However, that P-state is the initial P-state when the
P-map was first downloaded to AVS. It is *not* the current P-state.

Therefore, we explicitly retrieve the P-state using the GET_PSTATE
command.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 2c6e325..c943606 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -784,8 +784,19 @@ static int brcm_avs_target_index(struct cpufreq_policy *policy,
 static int brcm_avs_suspend(struct cpufreq_policy *policy)
 {
 	struct private_data *priv = policy->driver_data;
+	int ret;
+
+	ret = brcm_avs_get_pmap(priv, &priv->pmap);
+	if (ret)
+		return ret;
 
-	return brcm_avs_get_pmap(priv, &priv->pmap);
+	/*
+	 * We can't use the P-state returned by brcm_avs_get_pmap(), since
+	 * that's the initial P-state from when the P-map was downloaded to the
+	 * AVS co-processor, not necessarily the P-state we are running at now.
+	 * So, we get the current P-state explicitly.
+	 */
+	return brcm_avs_get_pstate(priv, &priv->pmap.state);
 }
 
 static int brcm_avs_resume(struct cpufreq_policy *policy)
-- 
2.7.4

