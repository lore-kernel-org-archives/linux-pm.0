Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01523016F7;
	Fri,  3 Jul 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104782; cv=none; b=dRG7tgJuKKanyuCgFwiDiPInPwX6J5jBTP6pxvGwug53PYn1SVBf5L+eWoUcFdnvOAeC8nX8YOpVm7L4UWK0/nEAqedCYOhWsssAZHVEExLP8Md19hLBFadhgpL4Iy+WQDXNgwBSdOsHIKzLY1pnITvDP+/lWuDs7rwA1tydeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104782; c=relaxed/simple;
	bh=pKYXT+BZ+wJ3YBFYOlgjpxbv7tZC2s26tw/M0N6OYfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HFlJqz/gYgHEn/Gs6wBsDnobv7yUsIMy2D5d4fmmTUDOou7EiEFIfx0+1TfGxYhbMmHBNotk+pJHyDiD7T2B5/DOxd1a5CadSa+jmlEO4bAATDBJoPEb5WxVNBnwHmMVQHWEQNCtSK+Q8jDKlnpWSIjC1OsgXQk9gFOGOfe+7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=U+ydAsT3; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="U+ydAsT3"
Received: by chaosmail.tech (Postfix) id 61D561CC21E;
	Fri, 03 Jul 2026 18:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1783104776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5yh6tx0rcTXUg+w8H4oTXcRUK8TzdWacjEqbGEhyWGI=;
	b=U+ydAsT3oX7qKlEr/7lwYq9PYT+vx84UTPKteCxy8BvzQLGk0vqE2t6kQhoPW+tJngcZJ4
	NBagcVBkm8QrO6P+1r4SN2cUpG1CRZ5ztoTTZCfInyjtmBtW2Wm7HxdJP9S68eEkJ/pF2I
	WDD+eSj/SBTSiin62q2v/KiCBE63dqo=
From: Sasha Finkelstein <k@chaosmail.tech>
Date: Fri, 03 Jul 2026 20:52:48 +0200
Subject: [PATCH] cpufreq: apple-soc: Calculate frequency as a 64-bit value
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-cpufreq-64-v1-1-c406c705319a@chaosmail.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDWpIRWuIha0g7Hw06pIpHdXL
 L/Fezc4skwO6uQGSyc7XpeILE1AT90ykmATDShRyVLmQm9+sLQLVQjsMDclqoxkBTHYLA18fbO
 m/e18P5M+3gOE8AD6xnmUbgAAAA==
X-Change-ID: 20260703-cpufreq-64-2a23d7261e09
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <k@chaosmail.tech>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783104776; l=1126;
 i=k@chaosmail.tech; s=20241124; h=from:subject:message-id;
 bh=pKYXT+BZ+wJ3YBFYOlgjpxbv7tZC2s26tw/M0N6OYfM=;
 b=rV8RlNcoGB9fGgWZo6PqV81pKfRxc4rz0NcyYGjLsMbudvptfAgphE8sUtztRKBGcLRxKfjhX
 Qj6W+EKtlWKCbSUsLjU5ijhZi4+d6qBuvEjtREm7Vtlu9RHYd1caEeB
X-Developer-Key: i=k@chaosmail.tech; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=

The current frequency calculation is done in 32 bit, causing problems
if run on a future SoC that can boost higher than 4.2GHz.

Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 638e5bf72185..6a0f1d36578f 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -288,7 +288,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 
 	/* Get OPP levels (p-state indexes) and stash them in driver_data */
 	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		unsigned long rate = freq_table[i].frequency * 1000 + 999;
+		unsigned long rate = freq_table[i].frequency * 1000UL + 999UL;
 		struct dev_pm_opp *opp = dev_pm_opp_find_freq_floor(cpu_dev, &rate);
 
 		if (IS_ERR(opp)) {

---
base-commit: 4a50a141f05a8d1737661b19ee22ff8455b94409
change-id: 20260703-cpufreq-64-2a23d7261e09

Best regards,
--  
Sasha Finkelstein <k@chaosmail.tech>

