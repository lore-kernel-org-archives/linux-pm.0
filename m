Received: from mail-qk2-f10.google.com (mail-qk2-f10.google.com [74.125.230.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7944F7CCD
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575099; cv=none; b=sb+Qbd2RgWO5Nig3d/WEZVwzxPw+mnxctJMeAjfa/k3MpFd6CpJy/hJOmX52IBI8/24zBMawcR48zmez/4YXtQjCMvzvIkdaNyMugK10Pk2px8B2YqW1OPD42ZCp/vbV1PWYDO7OoyYXrnwIqAL299TABYoIwVLAijjsnDH9EZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575099; c=relaxed/simple;
	bh=fXj+/b1tWQ4CVun24kWnp5+6QFowX8kLlyxSUkAjW7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2Y0TSmJ7VEnOK8NYOBZNPushn3kR4PMJW9Sw6+1v1dluzaNQdVzlP6UPQe3bF+gSI4Ynguw/lrFg2yJyoEZnTZ0P1cn3xQTHiV6bynpU8lM+lZoL9nR9tsCET+jrgP2Ssuba0wD0QDtoubZDBR9sKerIMX9lwSI6dkG5q5ACFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFlDRByp; arc=none smtp.client-ip=74.125.230.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFlDRByp"
Received: by mail-qk2-f10.google.com with SMTP id af79cd13be357-93e67431372so2452385a.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791575088; x=1792179888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nIRhhPwVEVzpUkFOiFr72TjAQ//RWYZjBPnhQP/2UH4=;
        b=mFlDRBypGeVG7OJrcmkI05ab09gAUbZuWnXxWIA00fsShdt2a2jbcfo5pjD6uJ2g9V
         JT1dvEL+bsypCd9IPjmJHGatXIPOnTg5GEaS5Mjl3YwJxFdKdqdkxZRCzWHMXPqJ0AX5
         JMWRvmBqxbuftnKETdI3Mud+wtYh3pFezoczxCtwlC9quXyUnRHo3iWJx9Yc7Igyzkh9
         BbfoefKrubV+QPEuvUBoqfWAXumAK0hZLPl7/jEDzMJi7dVApU0eprsVWQDx4jdyS062
         kqstlh7hTosKKL6EJAy9Vt5Gt4tTYh4hk/So9riMJv6yaQBt6k9H0NbQj02A85K20Fhb
         iWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791575088; x=1792179888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIRhhPwVEVzpUkFOiFr72TjAQ//RWYZjBPnhQP/2UH4=;
        b=qli5FOEVFxb96DH8lQYyBQksRq7B9+8ZZNk1WAKWn05hFuO90j2GeuqTlr5DkXajTr
         YclJFFRrQZij7SoVNEblkMdc5H9LoQ49zaGjgQNqPjAZSXVhGw8haYkZB/4im60H+NQg
         2ZwFQQwWZ7YKxb+HGZzdNQbxORs00kZR5K640eS3g7ZfYhkfeXanyuKOC6iekrkxbSY1
         Rodj40546wfCicQe+SVl3kGjmHRWt21cEi7ovv9oPQyNZVm96QQNscws6d2SQMuaqoan
         INVreRGXM1v2NOCyXNdoOi9UNsearhiCDMyIQq4enuOHCWnyLd7OR9OCwRQx/iGnd8qC
         5ohw==
X-Forwarded-Encrypted: i=1; AKwUvBzdZh55X94kyS5y7bU8ozuJOrL6QLObOTvwvg72fh6+46LCgkbs2XU/vDRVLfkDdxA+oFvG7ZBerA==@vger.kernel.org
X-Gm-Message-State: AFuF++k+mYfNlra7C2OHpfBB4e6xre66lhICVwjrliNIp3G8IsoC5rA5
	qNtlg3/8RnauQzxlg6bsGtG8ruGpiCJ/06VRwFGxlKYfQgstJfoi+6Ve
X-Gm-Gg: AYBFou0/edWel2khvOrlUT4mCZ4BOL4mgk9yGbJg3VOCfq3qkTVU8+XHDksHO4zihFi
	vNyWoI10m4P7ehoGALyZP7kcHhxdAEJcg+kWOQUy1DAJWRFzVAASd+JJMlREFka2r+PVx+J0Dq+
	R58y3a2BSKKnLIYh4hQvs9ydM26uTKrTR81PZW2R2VZyaeZdFZFaLXIceEjbN+YrcDv5nXSEFyC
	Qf5AqtyHcHPjuo/2OYCP6lD8u9XuUuuQvHERg7tEUbNTb0tphM+nyFMq/SGltEawhyK5wRarfi9
	LXVIbcBDaVSrbBqVn+bbtQU+0gmIoTwKda4gPDPfAQo4xwGEf5U5On87TSo1n65pO8uSO84sZ6k
	pzJR+Ljz2mxCI1twBnnccpgvzXi2vcVA0NK1Xr/HG94aWpXLnYzy/ekib2BcmXmqpCXLQF29TDH
	dB9WdZ2CM+yr6IbuZAX0zCZQehCN6pcf+gV8Nf36GEhyaSZQHb3xGCbpS4urijt3MD9s7Z5P4xs
	5khMWGw6n5CBtTh5ipJqc8QgSanQWJswnplZGsMYHTNAid+YJ7YFun+Nt7zvlGh+Q==
X-Received: by 2002:a05:620a:4081:b0:939:f27c:7433 with SMTP id af79cd13be357-93ebd2838aamr439833785a.50.1791575088641;
        Fri, 09 Oct 2026 12:44:48 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98c5633sm259293485a.35.2026.10.09.12.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:44:48 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Fri, 09 Oct 2026 14:44:43 -0500
Subject: [PATCH v2 1/2] cpufreq: mediatek: Enter system sleep at the
 suspend OPP
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v2-1-ba13f826eae1@gmail.com>
References: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v2-0-ba13f826eae1@gmail.com>
In-Reply-To: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v2-0-ba13f826eae1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Roman Vivchar <rva333@protonmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791575085; l=1498;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=fXj+/b1tWQ4CVun24kWnp5+6QFowX8kLlyxSUkAjW7I=;
 b=CqC9lqTPvdYR4kD85dq/pvqLzd1/IPalGGl65+mjFDLrpnZOKrs5SCOfPH+nkdDqRTmBh7PVZ
 jArMCG90vxuBdEJ2vJ9iJkvSIaILZcIp/Ir9MeZm/bqwB7pplwroPxV
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

cpufreq_suspend() stops the governors at the start of system suspend, and
this driver has no .suspend callback, so each cluster sleeps at whatever
OPP it was last left at. On an MT8173 tablet (Amazon Fire HD 10, 2017),
entering suspend-to-RAM with both clusters at their highest OPP measured
63.5 mA. With this change and the lowest OPP marked, the same entry
measured 52.0 mA.

Use the generic suspend-frequency support, as cpufreq-dt does. Tables
without an opp-suspend entry leave suspend_freq at 0, which makes
cpufreq_generic_suspend() a no-op, so they are unaffected.

Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 052ca7cd2f4f..f9b1eca176eb 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -603,6 +603,7 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	policy->freq_table = freq_table;
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
+	policy->suspend_freq = dev_pm_opp_get_suspend_opp_freq(info->cpu_dev) / 1000;
 
 	return 0;
 }
@@ -624,6 +625,7 @@ static struct cpufreq_driver mtk_cpufreq_driver = {
 	.init = mtk_cpufreq_init,
 	.exit = mtk_cpufreq_exit,
 	.register_em = cpufreq_register_em_with_opp,
+	.suspend = cpufreq_generic_suspend,
 	.name = "mtk-cpufreq",
 };
 

-- 
2.55.0

