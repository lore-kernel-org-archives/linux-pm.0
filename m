Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510249;
	b=NemAGrH1LTGJi5dSttiDov99cIsPIq4G+4LNzO3QPA2UJYpsp2e0ts4Kk/kWqaDiQ4d9
	 sNFD68q7HJ0DMLh+gkgjJFxAgevZN+C59Cg/9QkadiJFfWxRMX1ePbeuKrI5JMyQWLTUu
	 hAC07wdelHW0+6R3u5o8c6WI6TAYDuXyRRTvwQt/4YQNWB4lPxTvsNsPyHWLaeQFzBPVI
	 U8bjOvtyHQRjYpDHakOsiAFuXkrYeHOGHcyXr6SaATmIPQeD95RjNF/8kAQ9V1fgID7lP
	 DJnJxNea/qTLDe8MVlYgPI6YJoRxwXindF+x6G4MGwQuOJ/tGJ1ZOC6W0EAWIibA2pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510249;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:To:
	 Content-Language:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=8FUjrlp8DFnqvbeuktq9OdqLZ8OjRBLAv8DgXJswiD8=;
	b=QPlgpjLN7/qYzIYx8zftZ82nCBtjytOXl72nWix/KXj1dpKlisDLD7zDwiK3CzCnMZZu
	 ZltCH6+GOZLA2V/jtmULzYWMwtExYdSJTOwGUwuHH2gpElqj1Ir+0WGtXS7v554Fcn9JU
	 zYNbzS4QYXGFJj279j6KU+0z2nKoKttVZhL/GMkdurngfJ8qde8xzo3WfW4nuIkwsCKkw
	 Rp6qijywipWTUYdk0c9cVkt5mjyl6xvo63zMoH57z+AJp/c/eFf77Tmcs/9YXULic2MKx
	 Uuuysa1SMnFdq3LGFSE4GbQwjXp/WM7kw93hFCxDOmK2Havsd+N1/Ky9ToRRA9GTbyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Q1lGulrP;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161E606A338
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 08:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3161E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Q1lGulrP
DKIM2-Signature:  i=1; m=1; t=1795510246;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
 d=web.de;
 s=s29768273:rsa-sha256:Aus3zXci4vztbcATDYVFdab2qs7Z
   X3zwf9fMLTwKVDVuzr8oPc3ymOpVmdHWdP+ZVdZrPw60XtaD6pQG25Zap3UFgLK892sOu89W55d
   y2z7y15cyTt3BqiXkdl5+C5aUtIYLyZgkMSTfFjrrjklf1aDDvU4g+pn/Tpwyel/EURcLKkMDiA
   CNO46/AsajUA5xNBROxXwQY2WWonLsjP2002lo0BqUORRM+TNt55blPCN6WYeDEvPiCLn6C3qOo
   6ZBI8tNTh9xXqcr2EvmukBUy83ji/SL1g0udrAlshxiP6Yq+J+OQbWHAeoNSxzbUI8nNMAmjBKR
   a+Zvjj8x+TiWmw==;
Message-Instance:  m=1;
 h=sha256:
   nXGs1zQsJJwgkdled81yj9qqtmd5cno+mSGErXddBqY=:
   xGcNkp1X4+UKP+X1hw4V/NvPLrgZ/zlkILAoya5XiMc=,
  sha512:
   fx5udn1NW2Man9Q5VLL6McAlheU9voLykmgV3eLQplc2aMdfu3R0htxqu+onmsa0DgpGQXRq4N+Y/UbHsVd5eQ==:
   O8Hs5/G8xTiFKeuO2du6ttZFdf8wgOS1wEMK1QNhPP7ClwAorx4ULRmCn0b9F21HGfPyNB5VfMnIV0uoPzP/wg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795510215; x=1796115015; i=markus.elfring@web.de;
	bh=8FUjrlp8DFnqvbeuktq9OdqLZ8OjRBLAv8DgXJswiD8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q1lGulrPo5ot5LRDXpCtTLR2YiAxN81I7ykY/YvlJVuuhElwvD9LavU7rc+fzXHO
	 UDKb0D5W8K8dFzqOKBV0quYqfOJfNYMHf/Y3gHb7FtOeePisyoKXcTIXiZK+qs0mz
	 L71IlLNtc5c7nWIVuhhx5F+2EPtwLRoTDgPHYqpUbFA0ESXOuFF2GAXlJnZKW2etg
	 wZv0MZWigCaDrdJcEm1EdnKhpszyb9ApH+lMNJxxyVWFj652wKnWikF646Y1wzuxj
	 516ww2+vFr0tNHjTmtb7ebmmuuDl64ofrVsfHiW62SY/MipPg26+cUcnHijU2QKv3
	 90v+72PNruhbaO4S5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Tu-1xzSAk2caq-00WfUs; Tue, 24
 Nov 2026 09:50:14 +0100
Message-ID: <de6c1040-c4d1-4703-9932-b3b668801c72@web.de>
Date: Tue, 24 Nov 2026 09:50:11 +0100
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
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Sebastian Reichel <sre@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Florian Fainelli <f.fainelli@gmail.com>, Frank Li <Frank.Li@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] power: reset: at91: Use devm_clk_get_enabled() in three probe
 functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8jfZFG8Qt71bmrU3G0lLnAGH8HQ2x4GTqqjfWrY4amw+KI3OIXE
 4uM23s8/9J6jlSRqPa6vjU0I9q/gAe5JmeP9gxBjD74l5TYAIK2pvdvMMz++QTjE2BKYET6
 hHG8mZ6uZVh1zhoQyjURLZDG8TulFQMn/n9m0TRMzvd4r+0jLAAu7bbdg3She2rcJIah8Ct
 eyPLyfLtKTfF2aYnc6VHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5qpJgtpu8Kw=;Eaaog7QxJmjVnGmhnhhUZkGjlNX
 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
 X4rKBBIlSmFx5SSYamiUqNeWJpw2cA=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Nov 2026 09:23:44 +0100

* Reuse existing functionality from devm_clk_get_enabled() instead of
  keeping duplicate source code.

* Delete a clk_disable_unprepare() call on error handling paths
  and in the implementation of three remove functions.

* Omit the label =E2=80=9Cclk_disable=E2=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/power/reset/at91-poweroff.c      | 20 +++----------------
 drivers/power/reset/at91-reset.c         | 17 +++-------------
 drivers/power/reset/at91-sama5d2_shdwc.c | 25 +++++-------------------
 3 files changed, 11 insertions(+), 51 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at9=
1-poweroff.c
index 7bc779055cf3..ffbaba309917 100644
=2D-- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -159,16 +159,10 @@ static int at91_poweroff_probe(struct platform_devic=
e *pdev)
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
@@ -179,10 +173,8 @@ static int at91_poweroff_probe(struct platform_device=
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
@@ -196,10 +188,6 @@ static int at91_poweroff_probe(struct platform_device=
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
@@ -209,8 +197,6 @@ static void at91_poweroff_remove(struct platform_devic=
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

