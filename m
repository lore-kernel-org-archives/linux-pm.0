Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779212;
	b=rGZi+v1ylXitsDj6o7c0s38pm51DQwfCy2aRN6jjHbIr2rjSTDV0GCaLbqEfRKbsxPkl
	 2pPSmToYN/igtWMmqgYtrOxGcf+ypipNiLWxGRARnpharsfXad7w7S05WX1VyM8W0TT8o
	 81yQNhW7I49OzOaIOnF6Mj4vtqt1mwt5JHngc3Whj7scBaZCQwno3lEDn6j+zMqxwx9Dt
	 8jFlfPrbGAP4G7TKkBhtqRp/88l9AuXRSqXkJz0rv335VzlimLKI3ko0d8hRGlESjmm3g
	 kfMVePaAo+Hf66Gc3+o1zQn99EVwBjVTkHp1yP8yZddiyp+sKJej5bSfKC1b6frbjQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779212;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=3RaGK0nA/1YoPSMRqDclzGUojIWWpEHUoUIK1TK/zVs=;
	b=epHt37FECZ02WGu1wWvzuCvdORu3/V1kaIMcO84Bc2dg+cAm1etADLKZg5QbDe2aaaWl
	 FWW6FJ/lR88eFZ/NyrHQdc7U9as+u/prhPS1IlB6dgMZD3bMm6/V10jqbSp4znRBkRgFf
	 ZRWPwMqpBunpQ5sQO23hcPAK8YDrFZYddAq8BC9z4vwe5Loq+dbaEi/cEojwABsoF9RiZ
	 PV6a1qTjWB0BRKGWd08hCRx3d5LqU6sPDsSGYdNqRRLvoZ+YEfY8ERCYreu4by0ZM8s0T
	 Z3UlQ8JSgDpeLUxtt2e9+qYKVfiLdhSqIfZXeDc/6fC5aHOnuWQGv6+bwIn8GKKqFNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=V6mRf28G;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B9606A31E
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE6B9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=V6mRf28G
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 56429982f;
	Fri, 27 Nov 2026 19:33:28 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: ulfh@kernel.org,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jianxin.pan@amlogic.com
Cc: jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 2/2] pmdomain: amlogic: Tear down secure domains and their OF provider
Date: Fri, 27 Nov 2026 19:33:26 +0800
Message-Id: <20261127113326.390398-3-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127113326.390398-1-202300460064@mail.sdu.edu.cn>
References: <20261127113326.390398-1-202300460064@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa21cc8263803a2kunm351106c8395ddb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCT01DVhkZH0JLTkpKQ0xNGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlPS0hVSktJQk
	NDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=V6mRf28GIaRbxbP+EMM1nbUnCjROossXjStzNvVbFsnFbmykIxqATP1RxV3EywKKUoO2othvuUhEUc2qfcZBKolPtQec0PJq4Ken6kIpsuaci44K1LzDrQayj+TnHz8bkQFbTtS/wzvpoc6N88xQbvq8oO/aq9NSX9HhBvRZMTs=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=3RaGK0nA/1YoPSMRqDclzGUojIWWpEHUoUIK1TK/zVs=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

The secure power driver leaves the OF provider and domain hierarchy
registered after its memory is released. Remove the provider on unbind
and unwind subdomain links before the domains they connect. Use the same
cleanup when probe fails midway.

This issue was found by our static analysis tool under development.

Fixes: b3dde5013e13 ("soc: amlogic: Add support for Secure power domains controller")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 36 ++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
index c424a1e76174..53e3fa10328e 100644
--- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
@@ -392,9 +392,26 @@ static const struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
 	SEC_PD(T7_AUDIO,	0),
 };
 
+static void meson_secure_pwrc_remove_domain(void *data)
+{
+	pm_genpd_remove(data);
+}
+
+static void meson_secure_pwrc_remove_subdomain(void *data)
+{
+	struct meson_secure_pwrc_domain *dom = data;
+
+	pm_genpd_remove_subdomain(&dom->pwrc->domains[dom->parent].base, &dom->base);
+}
+
+static void meson_secure_pwrc_remove(struct platform_device *pdev)
+{
+	of_genpd_del_provider(pdev->dev.of_node);
+}
+
 static int meson_secure_pwrc_probe(struct platform_device *pdev)
 {
-	int i;
+	int i, ret;
 	struct device_node *sm_np;
 	struct meson_secure_pwrc *pwrc;
 	const struct meson_secure_pwrc_domain_data *match;
@@ -453,7 +470,13 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
 		if (match->domains[i].is_off(dom) && (dom->base.flags & GENPD_FLAG_ALWAYS_ON))
 			meson_secure_pwrc_on(&dom->base);
 
-		pm_genpd_init(&dom->base, NULL, match->domains[i].is_off(dom));
+		ret = pm_genpd_init(&dom->base, NULL, match->domains[i].is_off(dom));
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(&pdev->dev, meson_secure_pwrc_remove_domain,
+					       &dom->base);
+		if (ret)
+			return ret;
 
 		pwrc->xlate.domains[i] = &dom->base;
 	}
@@ -464,7 +487,13 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
 		if (!match->domains[i].name || match->domains[i].parent == PWRC_NO_PARENT)
 			continue;
 
-		pm_genpd_add_subdomain(&dom[dom[i].parent].base, &dom[i].base);
+		ret = pm_genpd_add_subdomain(&dom[dom[i].parent].base, &dom[i].base);
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(&pdev->dev, meson_secure_pwrc_remove_subdomain,
+					       &dom[i]);
+		if (ret)
+			return ret;
 	}
 
 	return of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
@@ -567,6 +596,7 @@ MODULE_DEVICE_TABLE(of, meson_secure_pwrc_match_table);
 
 static struct platform_driver meson_secure_pwrc_driver = {
 	.probe = meson_secure_pwrc_probe,
+	.remove = meson_secure_pwrc_remove,
 	.driver = {
 		.name		= "meson_secure_pwrc",
 		.of_match_table	= meson_secure_pwrc_match_table,
-- 
2.43.0

