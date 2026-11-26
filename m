Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699684;
	b=hQY9XR+CuWz9Y2KBv40hIOwdhQbqNnVgaC23zRkwY6TG0EiTgpdSWJjDMTKWVds4kVxa
	 S0UeBesP9MMpmUxHKU2pK1H0FjTYcXgQUe9b2RMZTaHptGs2qAKg1HZluMAklWKmNP0xE
	 l+vibf0yPXGPXOc5z0fXtDnMnoSOZY2k10uBY7Kibd7lT6rlWlMynikQfAv1CHl/qYzVo
	 Pzjbcjh8/E0Ql+2lHt/lJ5HQ38Cf3Xf1D9bKHkKlJ4xGwMvNuC71on9r7EuVZbdQy2w5M
	 qhZalxk00rs8TsWur7CoF0yFJ0S5yzFtQWsNbC+ETa0uvrZnsA4OqLDl05EJjV/vH1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699684;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=yrEpmd16eXyPHlsy7lDseSg22Hh4/cD9dxPjUlL+k0Y=;
	b=fWWcPzq5xru0NvnGury2HsFue+G8Omxx1Tb5bUviwQ+IClfv9a23b677bgJzOc/5Nzeb
	 DtfxHiRW2ZcEgubHgI8o426c5C7/rmh52tvDkcVG6kO7l2iZQe04o6v7lvulH6g8d6sfA
	 CVrgBq2HQZH8gIxSnjQtqXyREXbqm2d0gJ8kwCjOa9rCGc1po7Z2vGLzqYXUfhYXjpARa
	 UWkkknsBBGegwV+X5AuWXTkFAAQKd8D6ZPpHSiDV2El4uwiMxwZCkrk22MXqLbiXP0I12
	 46scbpMhkkoXVFbh4hhtNhkHzpbVu0J2ZI1V5gBew6p8lrdP4vrGKRnqmJ3dqTp7TcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=brXuDX7A;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFE8606A31C;
	Thu, 26 Nov 2026 13:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEFE8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=brXuDX7A
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 561f6fcaf;
	Thu, 26 Nov 2026 21:27:59 +0800 (GMT+08:00)
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
Subject: [PATCH 3/3] pmdomain: bcm: Unregister Raspberry Pi power domains on unbind
Date: Thu, 26 Nov 2026 21:27:55 +0800
Message-Id: <20261126132755.4091008-4-202300460064@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa2180aa00503a2kunm345e734035d940
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSRpJVk8dS0geGUJDGUsfH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlLVUtVS1VLWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=brXuDX7AEF/rvQZtXlo5zq4CImvQlokRWNxqJa4iaQffb/C3rg7mLb8xbN1Qc17ljF7vzJjTo5W4Lc6XyIfWaP9LIIFZWBhY5OWPNhuEqALB2rUvWy57SdmCDwlVLHTy/T2UIhlFN2ETw+J74/5DjkIohnXmZZBjS/AEMnm1MD8=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=yrEpmd16eXyPHlsy7lDseSg22Hh4/cD9dxPjUlL+k0Y=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

The Raspberry Pi firmware power driver leaves registered domains and an
OF provider referring to freed storage on unbind. Initialize the
available domains together so probe can unwind partial initialization.
Remove the provider before its domains on unbind.

This issue was found by our static analysis tool under development.

The unbind cleanup overlaps an earlier proposal to add a remove
callback. This patch also handles partial initialization on probe
failure.

Link: https://lore.kernel.org/r/20260715-rpi-pm-remove-v1-1-e4eed226e08a@linutronix.de
Fixes: a09cd356586d ("ARM: bcm2835: add rpi power domain driver")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
 drivers/pmdomain/bcm/raspberrypi-power.c | 59 +++++++++++++++++++-----
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/pmdomain/bcm/raspberrypi-power.c b/drivers/pmdomain/bcm/raspberrypi-power.c
index 1304c5545f36..816458637663 100644
--- a/drivers/pmdomain/bcm/raspberrypi-power.c
+++ b/drivers/pmdomain/bcm/raspberrypi-power.c
@@ -95,16 +95,6 @@ static void rpi_common_init_power_domain(struct rpi_power_domains *rpi_domains,
 	dom->base.power_on = rpi_domain_on;
 	dom->base.power_off = rpi_domain_off;
 
-	/*
-	 * Treat all power domains as off at boot.
-	 *
-	 * The firmware itself may be keeping some domains on, but
-	 * from Linux's perspective all we control is the refcounts
-	 * that we give to the firmware, and we can't ask the firmware
-	 * to turn off something that we haven't ourselves turned on.
-	 */
-	pm_genpd_init(&dom->base, NULL, true);
-
 	rpi_domains->xlate.domains[xlate_index] = &dom->base;
 }
 
@@ -158,11 +148,32 @@ rpi_has_new_domain_support(struct rpi_power_domains *rpi_domains)
 	return ret == 0 && packet.state != ~0;
 }
 
+static void rpi_power_remove_domains(struct rpi_power_domains *rpi_domains,
+				     unsigned int count)
+{
+	while (count--) {
+		struct generic_pm_domain *pd = rpi_domains->xlate.domains[count];
+
+		if (pd)
+			pm_genpd_remove(pd);
+	}
+}
+
+static void rpi_power_remove(struct platform_device *pdev)
+{
+	struct rpi_power_domains *rpi_domains = platform_get_drvdata(pdev);
+
+	of_genpd_del_provider(pdev->dev.of_node);
+	rpi_power_remove_domains(rpi_domains, rpi_domains->xlate.num_domains);
+}
+
 static int rpi_power_probe(struct platform_device *pdev)
 {
 	struct device_node *fw_np;
 	struct device *dev = &pdev->dev;
 	struct rpi_power_domains *rpi_domains;
+	unsigned int i;
+	int ret;
 
 	rpi_domains = devm_kzalloc_obj(dev, *rpi_domains);
 	if (!rpi_domains)
@@ -223,11 +234,34 @@ static int rpi_power_probe(struct platform_device *pdev)
 	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_CDP, "CDP");
 	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_ARM, "ARM");
 
-	of_genpd_add_provider_onecell(dev->of_node, &rpi_domains->xlate);
+	/*
+	 * Treat all power domains as off at boot.
+	 *
+	 * The firmware itself may be keeping some domains on, but
+	 * from Linux's perspective all we control is the refcounts
+	 * that we give to the firmware, and we can't ask the firmware
+	 * to turn off something that we haven't ourselves turned on.
+	 */
+	for (i = 0; i < rpi_domains->xlate.num_domains; i++) {
+		struct generic_pm_domain *pd = rpi_domains->xlate.domains[i];
+
+		if (!pd)
+			continue;
+		ret = pm_genpd_init(pd, NULL, true);
+		if (ret)
+			goto err_remove_domains;
+	}
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, &rpi_domains->xlate);
+	if (ret)
+		goto err_remove_domains;
 
 	platform_set_drvdata(pdev, rpi_domains);
-
 	return 0;
+
+err_remove_domains:
+	rpi_power_remove_domains(rpi_domains, i);
+	return ret;
 }
 
 static const struct of_device_id rpi_power_of_match[] = {
@@ -242,6 +276,7 @@ static struct platform_driver rpi_power_driver = {
 		.of_match_table = rpi_power_of_match,
 	},
 	.probe		= rpi_power_probe,
+	.remove		= rpi_power_remove,
 };
 builtin_platform_driver(rpi_power_driver);
 
-- 
2.43.0

