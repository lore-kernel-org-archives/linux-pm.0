Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699684;
	b=fXLYCPUvg3uFw/kskHSHZq5e0IIEtfx71u5REAe2ZrJKbiJtpjpX1fBcm9f8UYHVbrxg
	 ODlke4ZxlzdsHM0cj2JRM4yzia3HJdUpgQn98e5Gh87F5Ho25lTD+Sd7nC5h1GifWmr4B
	 zRKO1Mi2pzn4LvKzgSX7nuwhejAWCohktPN/f2FW7dX7ymnImYiHoMfwpSMKEGXqV4AOK
	 smpePZDIeR3r5evnrcAgSypWb1F7m9hagjmEVvR1yvKio+B+BhLRSOnhHiCBJGVpSxK1Y
	 0V97TU2TPLKQmLmKRX1VASbKzdcqCAFxVHXl5nGOY2NR/HyHSF4wwCC8mJMJ3fnJI6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699684;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Gu4aUQoQJYGL5Solf3pB4Gz6kyovk61cFjsbj8bFV78=;
	b=UnQw1P4QNNBoa+dB1kWcgRjUETXXe1hZZThgQlDgzD6XPTchplr7H3f7u9LuLkCofw9Z
	 GSbMmTqTeHC2XFxuuXHGhjhBwRSNDz6KQItltMH1AH2VVFfm4Es/5YsWJMitedvasCjKZ
	 fbZgRKAVmMLDvM/fYCClAkWnqUDnlW0tHwLDGu82/ZqzGsEruktCzSE0xNgy7B/LDAOAh
	 vN7d2ASG/+SjILF6VVJPtBtcPqLuEf751nchbQElanZzyi63zKSAZmT2mbMNCng+tYnRi
	 Wy/FgzvHLyjGZ2k1d3h0hV9uxDrUBRhjt+VVlYqEhZu1ubCvbrVWjpu+sBpX5LsB5Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=dQ+0v2ik;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E29606A31E;
	Thu, 26 Nov 2026 13:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59E29606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=dQ+0v2ik
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 561f6fcad;
	Thu, 26 Nov 2026 21:27:58 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: rafal@milecki.pl,
	florian.fainelli@broadcom.com,
	ulfh@kernel.org,
	noltari@gmail.com,
	alex.aring@gmail.com,
	eric@anholt.net,
	khilman@linaro.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	liguangshuo@mail.sdu.edu.cn
Subject: [PATCH 2/3] pmdomain: bcm: Unregister BCM63xx power domains on unbind
Date: Thu, 26 Nov 2026 21:27:54 +0800
Message-Id: <20261126132755.4091008-3-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126132755.4091008-1-202300460064@mail.sdu.edu.cn>
References: <20261126132755.4091008-1-202300460064@mail.sdu.edu.cn>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa2180a9bc103a2kunm345e734035d93d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHx4eVkMYSxhNGE1OGBlMSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlLVUtVS1VLWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=dQ+0v2ikUXqbhbBhQwawQoIfMG4iv5qzCkaTssJ+4NxFfKRj5p+SV7uKqEmBZrNX+QYdkyWhSLKFVl21ra1+OPluxiam0O6c7X+UqtWXTbjVmjzypoJemElWhdZUviMFundAfdHn2vQr3tFnktf9M4JfV64JXPEt1cAJY4asp3c=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=Gu4aUQoQJYGL5Solf3pB4Gz6kyovk61cFjsbj8bFV78=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

The BCM63xx provider and its domains remain registered after their
managed storage is freed. Delete the provider and remove initialized
domains on unbind, and unwind initialization when probe fails.

This issue was found by our static analysis tool under development.

Fixes: 6c41106f177e ("soc: bcm: add BCM63xx power domain driver")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
 drivers/pmdomain/bcm/bcm63xx-power.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/bcm/bcm63xx-power.c b/drivers/pmdomain/bcm/bcm63xx-power.c
index 9454f9066709..51ab8c5abca1 100644
--- a/drivers/pmdomain/bcm/bcm63xx-power.c
+++ b/drivers/pmdomain/bcm/bcm63xx-power.c
@@ -86,6 +86,21 @@ static int bcm63xx_power_off(struct generic_pm_domain *genpd)
 	return bcm63xx_power_set_state(pmd, false);
 }
 
+static void bcm63xx_power_remove_domains(struct bcm63xx_power *power)
+{
+	int i;
+
+	for (i = power->genpd_data.num_domains - 1; i >= 0; i--)
+		if (power->genpd[i])
+			pm_genpd_remove(power->genpd[i]);
+}
+
+static void bcm63xx_power_remove(struct platform_device *pdev)
+{
+	of_genpd_del_provider(pdev->dev.of_node);
+	bcm63xx_power_remove_domains(platform_get_drvdata(pdev));
+}
+
 static int bcm63xx_power_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -150,7 +165,9 @@ static int bcm63xx_power_probe(struct platform_device *pdev)
 		pmd->genpd.power_on = bcm63xx_power_on;
 		pmd->genpd.power_off = bcm63xx_power_off;
 
-		pm_genpd_init(&pmd->genpd, NULL, !is_on);
+		ret = pm_genpd_init(&pmd->genpd, NULL, !is_on);
+		if (ret)
+			goto err_remove_domains;
 		power->genpd[entry->bit] = &pmd->genpd;
 
 		ndom++;
@@ -161,12 +178,17 @@ static int bcm63xx_power_probe(struct platform_device *pdev)
 	ret = of_genpd_add_provider_onecell(np, &power->genpd_data);
 	if (ret) {
 		dev_err(dev, "failed to register genpd driver: %d\n", ret);
-		return ret;
+		goto err_remove_domains;
 	}
 
+	platform_set_drvdata(pdev, power);
 	dev_info(dev, "registered %u power domains\n", ndom);
 
 	return 0;
+
+err_remove_domains:
+	bcm63xx_power_remove_domains(power);
+	return ret;
 }
 
 static const struct bcm63xx_power_data bcm6318_power_domains[] = {
@@ -369,5 +391,6 @@ static struct platform_driver bcm63xx_power_driver = {
 		.of_match_table = bcm63xx_power_of_match,
 	},
 	.probe  = bcm63xx_power_probe,
+	.remove = bcm63xx_power_remove,
 };
 builtin_platform_driver(bcm63xx_power_driver);
-- 
2.43.0

