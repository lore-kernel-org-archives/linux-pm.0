Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B033C07A;
	Mon, 20 Jul 2026 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532361; cv=none; b=l+tYR/WhLo9gkqeArqlrrH/hMC1qMpZGb1w2vLa+op9c0dAWfPh2MmhW8o2i5zNNy0VLHKC4L2YzzCLAKnzsY2QebAhHhjCs/zSja+pNZ0nGbrx4jsNrSpIi/68HI/4JCwSrnPvgBA1GpTAUop6hhGoklDBcxus43e4w9pr6ZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532361; c=relaxed/simple;
	bh=tZhM/iGRRI+oZD5fXQ5GSzTaLhc9y+lLypS7IUaOEQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mhp63TtK3PdPS1nWbIycGpUS7Qdp5bs7+8LTG1f6/AC11k3vLl1pNdvotuk8V/9U74XenN3+0EhPZwLw/h+gmCKzDrzaWFMzzl0rDm2/7E3Qa+Us/0GCR70XCSgKBwTEeZAnGWaRLpY3Kv0ssESJ8yxXW6jHBbGm9JL47g66k7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=WZLAR6na; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="WZLAR6na"
Received: by chaosmail.tech (Postfix) id 3AE4A1C8676;
	Mon, 20 Jul 2026 07:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1784532357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZU8H4o4KTkb6BEX2VrLFhnIWaFZnnK8taJBxY5eb+bI=;
	b=WZLAR6na6wI7D9oror3TOoNxolFu58n2FIqQpLaY3PSIGomx6kX0seBrLulwSys8LDwSsX
	MgAjnD1PWjv/S3A0hFFxYQu9yE8T/CrjyOL3qPf/nf2YQPp+gJXd/I2/ymdqdM1+1UIPvH
	rJVGA/V/b9Kibo4xZP49fI8ZO8Gk+Ic=
From: Sasha Finkelstein <k@chaosmail.tech>
Date: Mon, 20 Jul 2026 09:25:10 +0200
Subject: [PATCH v2] cpufreq: apple-soc: Calculate frequency as a 64-bit
 value
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-cpufreq-64-v2-1-72bd9b4e5ca0@chaosmail.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Oyw6CMBREf4XctTV9YBtc8R+GRS0XuUYBW2g0h
 H+3xa3Lk8ycmRUCesIA52IFj5ECjUMCeSjA9Xa4IaM2MUguNTdcMTctnccX0yWTVqrWSC2QV5A
 Kk8eO3rvs0vw4LNc7ujkbcqKnMI/+s69FkXN/xVEwwVzJtTP8pERl6/RlDE9Lj+OMrodm27Yvc
 l/rhrsAAAA=
X-Change-ID: 20260703-cpufreq-64-2a23d7261e09
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <k@chaosmail.tech>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784532357; l=1448;
 i=k@chaosmail.tech; s=20241124; h=from:subject:message-id;
 bh=tZhM/iGRRI+oZD5fXQ5GSzTaLhc9y+lLypS7IUaOEQk=;
 b=8SXwAKh7TXuOgyGGdO2AwRp/Tzz/IEEkfMgzHejSJrJTksw4kmQHgHd+K6CsujzN5ORVt2YwL
 QJRRTKA3HnlA/lOU8JsMyRsR0MBdClhN6lno4cT+7mq8Gv//EBIaApK
X-Developer-Key: i=k@chaosmail.tech; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=

The current frequency calculation is done in 32 bit, causing problems
if run on a future SoC that can boost higher than 4.2GHz. Ideally, we
should use a true u64 instead of unsigned long and "knowning" that this
only runs on 64 bit machines, but the core code uses ulong everywhere,
so this should be good enough.

Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
---
Changes in v2:
- Minor style fixes
- Link to v1: https://patch.msgid.link/20260703-cpufreq-64-v1-1-c406c705319a@chaosmail.tech
---
 drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 638e5bf72185..5ad274a1e6ae 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -288,7 +288,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 
 	/* Get OPP levels (p-state indexes) and stash them in driver_data */
 	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		unsigned long rate = freq_table[i].frequency * 1000 + 999;
+		unsigned long rate = freq_table[i].frequency * 1000UL + 999;
 		struct dev_pm_opp *opp = dev_pm_opp_find_freq_floor(cpu_dev, &rate);
 
 		if (IS_ERR(opp)) {

---
base-commit: 4a50a141f05a8d1737661b19ee22ff8455b94409
change-id: 20260703-cpufreq-64-2a23d7261e09

Best regards,
--  
Sasha Finkelstein <k@chaosmail.tech>

