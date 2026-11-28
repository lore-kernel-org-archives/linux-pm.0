Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795863748;
	b=CQgBP+YmZs22lFpFpND2o0e2ro26zurpYzmqlRHubzOgRPKCc0JNiqGIM+U5bDxCSSqf
	 Lrbz2hqWaMbAWP1SBmUUzA4b0bO6mVi2nHlFRX01gsHUQpm0Ck0W3DsPMuY1/Rc+5F0Ng
	 YjyKNAYJUIOdoqBLy73awkgv6RwSdDpYTuzTvPsiCAyU5lGs88DokeZu2WAc7kR/8zTzp
	 EdOupsAvsVbpMyrCufdcS7F2gwZPc79BH8f6MtMKHRQJqIVBBAtPoibSLGCxw4kWr1H5P
	 6HWGob76+Fi2CoJaR8vRSMZQM+1gTv+e7gl0rI675+v8tAO4zm+4D4A4cMWEuEq4aiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795863748;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=1iiyAT9AAkImriSAkCuGBq7hfmlUIBgJJjwrPdzvpWA=;
	b=MW0TQ6BcYG/V4vbB+E4aP1Gg7f8x3Y3hI462fdk1ISDSZXNW42ltKSHKMXISQkYg6C+K
	 4ptYo+o42R5OcrB2GtipA5nARordqQ82MjS8asr9KdnulYPDwEn4Ip/7XfWdPOQ4F5W3g
	 FdkbcIg4/s4+EhhFKjcgmwSRpBNt1RLtF5vXA6WggzmcLT3FA0kqhDNYsHN/FWG5IxMr2
	 YeoBIPMY9c3ve/r+9IjI0F9ImVq7RTroceJnC2DQkKHTyYReer+KxpWvIcAft5dT3ROwu
	 A84rX0gFjWGXbjh2rbAWYrLm6dPYuQNstk4TVVkkjagCPffRGTrC0bbSeRku6yjjqUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=ghwnPl3W;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0CB606A31F;
	Sat, 28 Nov 2026 11:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF0CB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=ghwnPl3W
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5656652a6;
	Sat, 28 Nov 2026 19:02:21 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: sudeep.holla@kernel.org,
	ulfh@kernel.org,
	khilman@baylibre.com,
	tixy@linaro.org
Cc: cristian.marussi@arm.com,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	liguangshuo@mail.sdu.edu.cn
Subject: [PATCH] pmdomain: arm: Unregister SCPI domains on removal
Date: Sat, 28 Nov 2026 19:02:20 +0800
Message-Id: <20261128110220.875342-1-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-HM-Tid: 0aa221d2053e03a2kunm50e636623cbc57
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHxhMVksYSx5PGU4dTEtKQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlPS0hVSktJQk
	NDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=ghwnPl3WXP8VS77kfF/XDfU3Wv8UjAX3ZoOQJQKxpCwDxM7J6G+ob2KIxJX39zASMO1KV9cySFOHfsHtmsgNSFh5WJqBZyMQ6TuA/dNX9ZPQGIPqsyzpb2ul9QD/1+D+T9kQrzCSGqrUOMh012/lBtOm+8qAcMjHAb1tOE/XY+E=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=1iiyAT9AAkImriSAkCuGBq7hfmlUIBgJJjwrPdzvpWA=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

The SCPI driver releases its domain storage on removal without
unregistering the provider or domains. Remove the provider before
freeing its domains and unwind previously initialized domains if probe
fails.

This issue was found by our static analysis tool under development.

Fixes: 8bec4337ad40 ("firmware: scpi: add device power domain support using genpd")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
 drivers/pmdomain/arm/scpi_pm_domain.c | 41 +++++++++++++++++++++------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/pmdomain/arm/scpi_pm_domain.c b/drivers/pmdomain/arm/scpi_pm_domain.c
index 1d55a9e548e0..d9fa5ef7c1ec 100644
--- a/drivers/pmdomain/arm/scpi_pm_domain.c
+++ b/drivers/pmdomain/arm/scpi_pm_domain.c
@@ -62,6 +62,21 @@ static int scpi_pd_power_off(struct generic_pm_domain *domain)
 	return scpi_pd_power(pd, false);
 }
 
+static void scpi_pm_remove_domains(struct genpd_onecell_data *data)
+{
+	int i;
+
+	for (i = data->num_domains - 1; i >= 0; i--)
+		if (data->domains[i])
+			pm_genpd_remove(data->domains[i]);
+}
+
+static void scpi_pm_domain_remove(struct platform_device *pdev)
+{
+	of_genpd_del_provider(pdev->dev.of_node);
+	scpi_pm_remove_domains(platform_get_drvdata(pdev));
+}
+
 static int scpi_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -105,9 +120,10 @@ static int scpi_pm_domain_probe(struct platform_device *pdev)
 	if (!domains)
 		return -ENOMEM;
 
-	for (i = 0; i < num_domains; i++, scpi_pd++) {
-		domains[i] = &scpi_pd->genpd;
+	scpi_pd_data->domains = domains;
+	scpi_pd_data->num_domains = num_domains;
 
+	for (i = 0; i < num_domains; i++, scpi_pd++) {
 		scpi_pd->domain = i;
 		scpi_pd->ops = scpi_ops;
 		scpi_pd->genpd.name = devm_kasprintf(dev, GFP_KERNEL,
@@ -115,7 +131,8 @@ static int scpi_pm_domain_probe(struct platform_device *pdev)
 		if (!scpi_pd->genpd.name) {
 			dev_err(dev, "Failed to allocate genpd name:%pOFn.%d\n",
 				np, i);
-			continue;
+			ret = -ENOMEM;
+			goto err_remove_domains;
 		}
 		scpi_pd->genpd.power_off = scpi_pd_power_off;
 		scpi_pd->genpd.power_on = scpi_pd_power_on;
@@ -126,15 +143,22 @@ static int scpi_pm_domain_probe(struct platform_device *pdev)
 		 * The SCP firmware itself may have switched on some domains,
 		 * but for reference counting purpose, keep it this way.
 		 */
-		pm_genpd_init(&scpi_pd->genpd, NULL, true);
+		ret = pm_genpd_init(&scpi_pd->genpd, NULL, true);
+		if (ret)
+			goto err_remove_domains;
+		domains[i] = &scpi_pd->genpd;
 	}
 
-	scpi_pd_data->domains = domains;
-	scpi_pd_data->num_domains = num_domains;
-
-	of_genpd_add_provider_onecell(np, scpi_pd_data);
+	ret = of_genpd_add_provider_onecell(np, scpi_pd_data);
+	if (ret)
+		goto err_remove_domains;
 
+	platform_set_drvdata(pdev, scpi_pd_data);
 	return 0;
+
+err_remove_domains:
+	scpi_pm_remove_domains(scpi_pd_data);
+	return ret;
 }
 
 static const struct of_device_id scpi_power_domain_ids[] = {
@@ -149,6 +173,7 @@ static struct platform_driver scpi_power_domain_driver = {
 		.of_match_table = scpi_power_domain_ids,
 	},
 	.probe = scpi_pm_domain_probe,
+	.remove = scpi_pm_domain_remove,
 };
 module_platform_driver(scpi_power_domain_driver);
 

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.43.0

