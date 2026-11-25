Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607975;
	b=SGijw8R3b76/kOBcn6cmzSj18pSIC96KU0q4Rpw+6OScXVZEiUFsM0jIV/4bVBbLxEo2
	 ZgTnRNd+5eyQg5wUM6qBMls9OPh4II/4wX7bxxR6ShPGhi8jdZcoXb2XhsDKrZ3EB1l9T
	 GWgjUc+CZ6v/BMdYX0FbkJrEgf3EodWrLEEGGK2uR/zAfXZAlpL9gXZa6hayQK7Gm5zUW
	 jo7c9k4kNQwMmQkdeF1SD1zOlZ8Rg6ahQ4V+JOJNUQvSq1cvJhHgWkBCNyBYWDS/7R4Qe
	 xCQVa8XvX0CobRWm0HBleJsok31kZPE3zIXyxhqvjdLMp9P91wrIw3v+UlMtYGFTvWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607975;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=A3aAjl2I8UP5uY1YM0wPpR0FJ6kc+PyG1ewNLSwkoCY=;
	b=SU4wUbsbDZJypMKTkprSrvlKrlt4WEJ7v91D4oLw5Me4Lp5xI0eFboMCD4egtVOPhxEZ
	 iAVeJLfpbkKV/h6pfVoarArhKv90phu/JLHrPy9Jk3W21fxfy0Z8TE9qEH/XFFMqg8AM6
	 UGrvF52c4JQwtvWzL5qaXO4KlPrBQ5mZv2fKwFPRjgS9iuFHKo6VRzbRpXMKmdj8r/5P0
	 GtwxigTtviYHEVSMTyuwtOcUCtQBxPp8qs1G+AQhFmwpCcy0QAhyX8MCSA3HOm3CM3A68
	 hisGqn0HGCh7B0u+X57WF8vW5uLjUnR8Kk3uXs3ztWuxBWSazmW5GTsffjWqOrK4A5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3nz9B98A;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vFHbg8sH;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ECA606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91ECA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3nz9B98A;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vFHbg8sH
Date: Wed, 25 Nov 2026 11:59:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3aAjl2I8UP5uY1YM0wPpR0FJ6kc+PyG1ewNLSwkoCY=;
	b=3nz9B98ABmtX8xpl85KFv9UidOgQ1T2wK39Q/nObPsqfRn7dz0D4zHRPSXpEKwFi5OlgwL
	PMds/hWk97lCMZE8SlKplC/fyBhmo+7Nf0FXdmDd2VwyT5JuujuglY7thcP5H5/CXZbuOK
	xbWlLWttrl76txrDFO6XBwnyvHm1bwEYr5trpZW77EVXy71Uo0XpHlircegcwWUPV02Dcx
	fi61ZI43tkJzAKVz1uidpmiOG30qCKxXrzjnQc47WnOHzZMzVyjaFqqvh5pRikRxQMDcxv
	9AOg1gWG18l0rsv1x+iYWv8BaJ+fK8a1fORk+q+Xe7eQJ+juUc8oUpMQqbKnKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3aAjl2I8UP5uY1YM0wPpR0FJ6kc+PyG1ewNLSwkoCY=;
	b=vFHbg8sH5O6In4lO6O7uPv4lJKUAofr3k7T2ET3HZnoaOELwzGDg10fLocCBEzC5bX51H8
	hjfp5a9IDEejmkBQ==
From: "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/qcom/tsens: Disable
 hardware on probe failure
Cc: Amit Kucheria <amitk@kernel.org>,
 Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261021085749.3786101-3-daniel.lezcano@oss.qualcomm.com>
References: <20261021085749.3786101-3-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560797018.92412.405355632441858098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     6027ee4b58a6b416964f25c603da5b97cf50c8dd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//6027ee4b58a6b416964f25c603da5b97cf50c8dd
Author:        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
AuthorDate:    Wed, 21 Oct 2026 10:57:48 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

thermal/drivers/qcom/tsens: Disable hardware on probe failure

Hardware initialization enables TSENS interrupts before calibration and
thermal zone and IRQ registration have completed. If calibration or
registration fails, probe returns without disabling the hardware. Devres
then releases any registered IRQ handlers, leaving the interrupt source
enabled without a handler.

Factor the hardware shutdown sequence out of the remove callback and
invoke it when calibration or registration fails after successful
initialization. Disable hardware interrupts and call the optional sensor
disable callback before devres releases IRQ handlers and register maps.

Fixes: 634e11d5b450 ("drivers: thermal: tsens: Add interrupt support")
Closes: https://sashiko.dev/#/bug/linux-4b873699-7a0d-46e9-b768-169916c70d1d
Cc: Amit Kucheria <amitk@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20261021085749.3786101-3-daniel.lezcano@oss.qu=
alcomm.com
---
 drivers/thermal/qcom/tsens.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4d4997b..3e5a501 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1377,6 +1377,13 @@ static int tsens_register(struct tsens_priv *priv)
 	return ret;
 }
=20
+static void tsens_disable(struct tsens_priv *priv)
+{
+	tsens_disable_irq(priv);
+	if (priv->ops->disable)
+		priv->ops->disable(priv);
+}
+
 static int tsens_probe_common(struct platform_device *pdev)
 {
 	int ret, i;
@@ -1453,15 +1460,22 @@ static int tsens_probe_common(struct platform_device =
*pdev)
=20
 	if (priv->ops->calibrate) {
 		ret =3D priv->ops->calibrate(priv);
-		if (ret < 0)
-			return dev_err_probe(dev, ret, "%s: calibration failed\n",
-					     __func__);
+		if (ret < 0) {
+			dev_err_probe(dev, ret, "%s: calibration failed\n", __func__);
+			goto err_disable;
+		}
 	}
=20
 	ret =3D tsens_register(priv);
-	if (!ret)
-		tsens_debug_init(pdev);
+	if (ret)
+		goto err_disable;
+
+	tsens_debug_init(pdev);
+	return 0;
=20
+err_disable:
+	/* Stop hardware events before devres releases IRQs and register maps. */
+	tsens_disable(priv);
 	return ret;
 }
=20
@@ -1505,9 +1519,7 @@ static void tsens_remove(struct platform_device *pdev)
 	struct tsens_priv *priv =3D platform_get_drvdata(pdev);
=20
 	debugfs_remove_recursive(priv->debug_root);
-	tsens_disable_irq(priv);
-	if (priv->ops->disable)
-		priv->ops->disable(priv);
+	tsens_disable(priv);
 }
=20
 static struct platform_driver tsens_driver =3D {
