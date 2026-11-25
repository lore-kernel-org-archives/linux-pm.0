Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603059;
	b=4sFwMe8Sxc+aHD1+cK+UF573yQ3tJXsKF6yarI3zkE9ugtzyDa+0CHS4dpVlyrYiMv8T
	 V/sZ6VZU5XaOR0LQDyqIAPs3482VEg9dgAiMFqzR/s5HfrBOtzfha5OlqIjZq86EN7B6k
	 Pw623GEwltrOsHTl9QMFAoTNuv9e/3zixd7n9GPhu0GYD89ANOxV9LAFpKDGa6/Hs3imd
	 N0smyfq9dWXDi8VNJr3cqSoWS5tJlRDNBzQXlAcp8yKP5/DyBzTBHc85wNEW/LaGlm4ex
	 ZJ9QQq6AA9VolUzz/7GE71Fu/Id7qR4AYPZmbAh3QcwqXT85GBkDw3GvceVDmDUVcAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603059;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=CdQgP19CT4EnDuDavQQhD6ZWHaIP0W2c1E9Boxywdoc=;
	b=CowIyiqP8muG47y1qZUNlrwOjRc+V5ssgbEizEO/bChMdrpnRnh0wOqxUcgKX6qxQS9J
	 URG0wLFqjg/1Af8DYFdsRyT0+RKSnnwUleTs1wVOaS/WSEFU5roRst0aPaDmF/cV4bY0x
	 mqzS6XZwmI0/Lqyc2DaFfbn0PYsc5LYhbUMMs8i0bEIZljxOpcOePGm5FzV5/AV6vI7wu
	 7zPpKEatU+C780uehCHQVVR2+h2OT4HKxktCcQBuKUwraQUojZWRYCbMuT9wPifq/b7eH
	 tagE+vfT1gOgpEkwt6jm9R5QYeenC68VXHeOfYpZr9bjlMFuNeK+8nGNN14RlK1+Jcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ExTsfq58;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBAC606A334
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABBAC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ExTsfq58
DKIM2-Signature:  i=1; m=1; t=1795603056;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
 d=web.de;
 s=s29768273:rsa-sha256:cViKKrI+2cC9OEplhkaSOu4ELSyR
   31gaj5qcK7y52YpRNg+GWUslE+FZfbG+kKN2zww8Lovsk9e74AHt5zGX1XfsqXT0dWeEC+64M9x
   84fMFwGVoIJwkHF6uw68/1EVKuRTCCtn5s6mVm45kJgb8ftPtj7pnBoCHyXOvrU9YBDXC82LNTd
   ebqIX0k2ggPtr64XMRQXpBfwA7a0XRBqvjL0ngVjVL+Q/AcxHpOt1Q8fErnUeXKwlb+I+pYmr/5
   RhEmMvQi44XNQadMoYV+8Lf42k6KMWONBzlJd09s0+CfZKkFRsZxxP6y890rU/J/DJptWq3sppd
   Uf9Oh9Jbdpi0Hg==;
Message-Instance:  m=1;
 h=sha256:
   4Co0LDXR16dkOn6OZ7Ly0OTrlBN8XsQ8sH/6BAS4xss=:
   /3lqfk6+oqRDpYeJBcxz9c83na5F6aSYQUSC1lFs9Tw=,
  sha512:
   I4YxKK5kXOEdfgNZZ6eG6H3Aqo5xDthMwhUh2ob7LYR4HU2H5tolde5idPgBNX5UUX4+y1qZxqdX8MtuXSp9nA==:
   sxh32TvJQSTh/LLMJaESG1rewcrxChAcyBlGqrkS7rrZOsqKG0eAXgo5HXIVpm2GHi1eqIbAKd7VCU4eUTi5/Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795602995; x=1796207795; i=markus.elfring@web.de;
	bh=CdQgP19CT4EnDuDavQQhD6ZWHaIP0W2c1E9Boxywdoc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ExTsfq58hRwlu0x+JPW0lMlov65CySC/XxoqyL/lXi6o/uwe2AIosEe3DGIyItyU
	 ymd0HFOaGm6rGWAfsBHYwJqAyKF1isFiS5890td8JxqPrjzjdJbm+Hg70zV5op9uV
	 guPz5tU7xUD2Ci4u9yjyCNAJP2VJEXClXW+e3wq9lBLg7C4pbOhDg4sBhX+pnlJFW
	 oJBEW6eWTW/PTOvQJi4A9QgdoXHd1nRjfbxU5nc4ewMeTby2yGZyO2H6wsXWLSfMX
	 FWHZRLsaux8fFqE/3gHm9H743iXZwAzmD137PJU78v07EFjg/I6pb1Ufk68wGBPBX
	 ypWsrOo9gq4YTyVpgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3Ez1-1xXXPb38Sz-0005hB; Wed, 25
 Nov 2026 11:36:35 +0100
Message-ID: <ac17f1db-e8db-41d7-922b-6cb32c7096ec@web.de>
Date: Wed, 25 Nov 2026 11:36:12 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: lkp@intel.com, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Florian Fainelli <f.fainelli@gmail.com>, Frank Li <Frank.Li@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v2] power: reset: at91: Use devm_clk_get_enabled() in three
 probe functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HfKZLDLWB2+T/E6T/B9h6zMqk8j8sEwES4fQaiFf2SDmjV+yCjp
 c4J97Jc36FMJHjpeQ5R5FurVCM9jIDTMvEVdolUxtMJjGEMuVyRHvJfz3M2qi7k0c+Y2tat
 72kDgFit9dChrgApyHs6XRtWABD9pvOoiqEsfgeaBMfwEt1nd+2OFSikHrKvmXzov6j8kcd
 8oi1IPhm/9v6al5diClpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jVVsm4bonQU=;enlWMJG0+7Spj/qDHxDPQCFjMfM
 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
 kA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Nov 2026 11:18:49 +0100

* Reuse existing functionality from devm_clk_get_enabled() instead of
  keeping duplicate source code.

* Delete a clk_disable_unprepare() call on error handling paths
  and in the implementation of three remove functions.

* Omit the label =E2=80=9Cclk_disable=E2=80=9D.

This issue was detected by using the Coccinelle software.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/de6c1040-c4d1-4703-9932-b3b668801c7=
2%40web.de
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/20261124222203.k0pVspdI-lkp@=
intel.com/
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V2:
Omit the variable =E2=80=9Cret=E2=80=9D in the implementation of the funct=
ion =E2=80=9Cat91_poweroff_probe=E2=80=9D
finally because it is not needed any more after the proposed source code a=
djustment.


 drivers/power/reset/at91-poweroff.c      | 21 +++-----------------
 drivers/power/reset/at91-reset.c         | 17 +++-------------
 drivers/power/reset/at91-sama5d2_shdwc.c | 25 +++++-------------------
 3 files changed, 11 insertions(+), 52 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at9=
1-poweroff.c
index 7bc779055cf3..a043e5642efe 100644
=2D-- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -153,22 +153,15 @@ static int at91_poweroff_probe(struct platform_devic=
e *pdev)
 {
 	struct device_node *np;
 	u32 ddr_type;
-	int ret;
=20
 	at91_shdwc.shdwc_base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(at91_shdwc.shdwc_base))
 		return PTR_ERR(at91_shdwc.shdwc_base);
=20
-	at91_shdwc.sclk =3D devm_clk_get(&pdev->dev, NULL);
+	at91_shdwc.sclk =3D devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(at91_shdwc.sclk))
 		return PTR_ERR(at91_shdwc.sclk);
=20
-	ret =3D clk_prepare_enable(at91_shdwc.sclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Could not enable slow clock\n");
-		return ret;
-	}
-
 	at91_wakeup_status(pdev);
=20
 	if (pdev->dev.of_node)
@@ -179,10 +172,8 @@ static int at91_poweroff_probe(struct platform_device=
 *pdev)
 		at91_shdwc.mpddrc_base =3D of_iomap(np, 0);
 		of_node_put(np);
=20
-		if (!at91_shdwc.mpddrc_base) {
-			ret =3D -ENOMEM;
-			goto clk_disable;
-		}
+		if (!at91_shdwc.mpddrc_base)
+			return -ENOMEM;
=20
 		ddr_type =3D readl(at91_shdwc.mpddrc_base + AT91_DDRSDRC_MDR) &
 				 AT91_DDRSDRC_MD;
@@ -196,10 +187,6 @@ static int at91_poweroff_probe(struct platform_device=
 *pdev)
 	pm_power_off =3D at91_poweroff;
=20
 	return 0;
-
-clk_disable:
-	clk_disable_unprepare(at91_shdwc.sclk);
-	return ret;
 }
=20
 static void at91_poweroff_remove(struct platform_device *pdev)
@@ -209,8 +196,6 @@ static void at91_poweroff_remove(struct platform_devic=
e *pdev)
=20
 	if (at91_shdwc.mpddrc_base)
 		iounmap(at91_shdwc.mpddrc_base);
-
-	clk_disable_unprepare(at91_shdwc.sclk);
 }
=20
 static const struct of_device_id at91_poweroff_of_match[] =3D {
diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-r=
eset.c
index a9ad43217f48..bcf77a5162f1 100644
=2D-- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -374,21 +374,15 @@ static int at91_reset_probe(struct platform_device *=
pdev)
 	reset->nb.notifier_call =3D at91_reset;
 	reset->nb.priority =3D 192;
=20
-	reset->sclk =3D devm_clk_get(&pdev->dev, NULL);
+	reset->sclk =3D devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(reset->sclk))
 		return PTR_ERR(reset->sclk);
=20
-	ret =3D clk_prepare_enable(reset->sclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Could not enable slow clock\n");
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, reset);
=20
 	ret =3D at91_rcdev_init(reset, pdev);
 	if (ret)
-		goto disable_clk;
+		return ret;
=20
 	if (of_device_is_compatible(pdev->dev.of_node, "microchip,sam9x60-rstc")=
) {
 		u32 val =3D readl(reset->rstc_base + AT91_RSTC_MR);
@@ -399,7 +393,7 @@ static int at91_reset_probe(struct platform_device *pd=
ev)
=20
 	ret =3D register_restart_handler(&reset->nb);
 	if (ret)
-		goto disable_clk;
+		return ret;
=20
 	ret =3D device_create_file(&pdev->dev, &dev_attr_power_on_reason);
 	if (ret) {
@@ -410,10 +404,6 @@ static int at91_reset_probe(struct platform_device *p=
dev)
 	dev_info(&pdev->dev, "Starting after %s\n", at91_reset_reason(reset));
=20
 	return 0;
-
-disable_clk:
-	clk_disable_unprepare(reset->sclk);
-	return ret;
 }
=20
 static void at91_reset_remove(struct platform_device *pdev)
@@ -421,7 +411,6 @@ static void at91_reset_remove(struct platform_device *=
pdev)
 	struct at91_reset *reset =3D platform_get_drvdata(pdev);
=20
 	unregister_restart_handler(&reset->nb);
-	clk_disable_unprepare(reset->sclk);
 }
=20
 static struct platform_driver at91_reset_driver =3D {
diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/rese=
t/at91-sama5d2_shdwc.c
index 589599cca076..cab94ef5a8a0 100644
=2D-- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -357,33 +357,23 @@ static int at91_shdwc_probe(struct platform_device *=
pdev)
 	match =3D of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
 	at91_shdwc->rcfg =3D match->data;
=20
-	at91_shdwc->sclk =3D devm_clk_get(&pdev->dev, NULL);
+	at91_shdwc->sclk =3D devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(at91_shdwc->sclk))
 		return PTR_ERR(at91_shdwc->sclk);
=20
-	ret =3D clk_prepare_enable(at91_shdwc->sclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Could not enable slow clock\n");
-		return ret;
-	}
-
 	at91_wakeup_status(pdev);
=20
 	at91_shdwc_dt_configure(pdev);
=20
 	np =3D of_find_matching_node(NULL, at91_pmc_ids);
-	if (!np) {
-		ret =3D -ENODEV;
-		goto clk_disable;
-	}
+	if (!np)
+		return -ENODEV;
=20
 	at91_shdwc->pmc_base =3D of_iomap(np, 0);
 	of_node_put(np);
=20
-	if (!at91_shdwc->pmc_base) {
-		ret =3D -ENOMEM;
-		goto clk_disable;
-	}
+	if (!at91_shdwc->pmc_base)
+		return -ENOMEM;
=20
 	if (at91_shdwc->rcfg->ddrc.type_mask) {
 		np =3D of_find_compatible_node(NULL, NULL,
@@ -417,9 +407,6 @@ static int at91_shdwc_probe(struct platform_device *pd=
ev)
=20
 unmap:
 	iounmap(at91_shdwc->pmc_base);
-clk_disable:
-	clk_disable_unprepare(at91_shdwc->sclk);
-
 	return ret;
 }
=20
@@ -437,8 +424,6 @@ static void at91_shdwc_remove(struct platform_device *=
pdev)
 	if (shdw->mpddrc_base)
 		iounmap(shdw->mpddrc_base);
 	iounmap(shdw->pmc_base);
-
-	clk_disable_unprepare(shdw->sclk);
 }
=20
 static struct platform_driver at91_shdwc_driver =3D {
=2D-=20
2.56.1

