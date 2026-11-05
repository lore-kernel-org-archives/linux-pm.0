Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893781;
	b=FGClYBPQRdApSrQd7ZZwBZ5tvjvbmhN6Z7IPBRhzIoPgHrkIzKL3SYCRsWPuZbeLce5q
	 KruavHz3vPvfHWgnbqY9VLvYGRMa6nKVG0NhLT4OjujOhxLsdB/2Uo9grfdPqI6GAP9vX
	 +MmZNbtevZGquGI+7PaKmU9IW7SVv/Szc8RjcLyWpcZm4XciC+qFGedYuDcGOOFoj5oXX
	 IGS3PpDcyGsZ7Q6bW1RW3+9krwPa2eO9OuBJSAgeFjuLbQmAd5sjmMPf/YAGnwlxsTFU5
	 bA276qyWZtHjcdtOvByv208Jy2Xeg3VUB/9NFjS4hsJk+t+xG3zJ1OpPPcVYaRQBHew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893781;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=oZiDjfQVho76hT7NzUE1u26+ZWrayBBsHNzdZcklnfQ=;
	b=rHsusemo3vWKn4UxHKybzplWS65j72IP6YQbrQZC2do3AFppmHv91rrC11hTHaUg7D2c
	 GlDQcW+ezFjlVoIN53S71SJnBjX1XCCAxk2+eYm5Qg3T+ty2LY676dT1PW/wOU7ip0/l1
	 bNBk2e6GU/pLElSg1XDB7dcMW3fa94l++KPyJdzINT8157Q7tDKW2jmUeSrowmfzA86DI
	 S1oY/0GBfAXMKXHLaIsGW8IJEPd7ShKCPSlwQf9iT6sd7xF53KApWX9tis7FctpXTysTp
	 17jLnXbRyIJ6yPqoOxuGw07aXdtUZY+MW/qr+hy9gH5GRcAWK4alDdIBJGlfeLM2Yhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MfZOQxga;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="PZYC/lrJ";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189060A6F5A
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7189060A6F5A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MfZOQxga;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PZYC/lrJ
Date: Thu, 05 Nov 2026 15:49:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893779;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZiDjfQVho76hT7NzUE1u26+ZWrayBBsHNzdZcklnfQ=;
	b=MfZOQxgaN1xWK/pwiqtmAa1iUWgSmbLvAJP9KBI/Uod8hgMXc4UK080G3Gkw/WYt95QY88
	2ImhWGZl2TWfXWI0bLaAMQ7sgfNd0SSNKjlVSoHi6DtPhoAgCpY/WsJbVZ7t7czF7h/xXR
	isgTuqFhNUHD2PBAdYzsHqDFknTeNjrEYO3i1kF2Y6oC+zgPe+qm28CRCsN6WgjSxrKQSr
	9OqMODR/t8fBvadWze+fEEdkX2cjKUgel3YMWumDn3/CnuNG6kOUQ/+4eBaWGYJfdZ4Gjt
	Ghf270wsVrMxRdYgh18y438Iks2AtrgKQZSDjcwO5MgOP4gRGiDoXw+oCBaCcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893779;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZiDjfQVho76hT7NzUE1u26+ZWrayBBsHNzdZcklnfQ=;
	b=PZYC/lrJkFJ2aT0WhaIIMMX2dyAYVoEgezvnbiV+xL893yfxHyEjdpvKfpBh64Raz7tgIa
	yyvwizH9iY29fwCw==
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
Message-ID: <179389377715.1009794.14331845769133443383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     d7292b66872c7bb820ce64e27f60ff7cca6925b3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//d7292b66872c7bb820ce64e27f60ff7cca6925b3
Author:        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
AuthorDate:    Wed, 21 Oct 2026 10:57:48 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:48:33 +01:00

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
