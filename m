Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607949;
	b=b5vOpncBAQC6XeALizh1yVzohVIIw3qGBZ+kRbligMeQof/Z4rCQe4Pl//xBt2Maso8W
	 zOUrv3VLU6YOqeZPbIgtWXk6NUr6cINOx/gxTM+qziJJB7uUMPrTwK1rVtGQ9bM9zj5M3
	 w46jeHY3h8KrR2TZbI1WLdzeJWztAu2G4Kz2z8PusAzV7TG70WAFW+xzyTivWY0YoYmkW
	 qz59XBW2sVQu5dEJTXpdwT8DZw8t/t1usfr96IFCeQuasMlX+trFIQYr3J+EbCoXo4Y0j
	 ldQ+dwnpaUuQ1orNJDZNRUROgcYybpGaxAP8Y+kVTnfcyQeSlF9dGx/LruKy3x9bSWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607949;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=2XRFb6t7OZdrF27TFs9AVOlgb+VBKb3EUnX5Ldvhj3I=;
	b=olI55Jy9fqtWxTaJPnL4+zi60vVXyamVF9tyG7KDRk8JgC2aihHrAUKKWlcB/IFWKJ5n
	 haoe4lcCvrszUnDTMitr9fPELCsMuLg6Mzeucbapd9KcsSbHl4giS035e2fOFoj8sXSZS
	 3fV8jJv4DyiA91PGPBfFszWYBlVQROrdjpM3DF5WGi41dUFespEfM88Yqi/tB2d2QCT5K
	 qH1ANfcDyKeC2yPGBXB92nyHVMYlH/VWs3TKGoCIjqwrk6alcNN3M0vLM8FbuWYr7eKAH
	 Shz9lkfcSvTsRKy+B//alH465JgKZB0aAQiY13n32OZFtGX+x+9tD7ck7CkiUmAIU8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=yK3dIWP9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=sZB67plX;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C094606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C094606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=yK3dIWP9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=sZB67plX
Date: Wed, 25 Nov 2026 11:59:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607947;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XRFb6t7OZdrF27TFs9AVOlgb+VBKb3EUnX5Ldvhj3I=;
	b=yK3dIWP9J0XFtMuQzJ1zoCjYfAa/aVzee6AIEP8Z0cq0PCVVtLTUb4f6SwT12u2yys9aas
	4cfs1JzShNEIz7glIBpFfVGE9Pc1taHPYwTTZZfzGEmbOsQ8q/6fydwdg0hbaHaweX8RMh
	FOlhkk0IwGGNy6SJqlFatkagM5r43FNbTL2l5HD8dCt7owJYulHHCvpX8zUFg8Ow7npj5s
	PBBbQ2mSecK96NnICeAhSA/XcqQU92Wx8YH/qYE23K/5BC4ysybxaAPuwczVruzwSt/p9T
	aBjpBw8RchBi87DY5Mp2hiRZoDQuq2BbywKNFVuWHT4tMTPyJnpFer9WpzT18w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607947;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XRFb6t7OZdrF27TFs9AVOlgb+VBKb3EUnX5Ldvhj3I=;
	b=sZB67plXQJUK1nxSoAcjo0cIWFJ4wrgKYjqQh6BEdmX6ngRhz8eVbApe6dHjbOcpUOirO+
	t3H7rB1iJ7aNkGAQ==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu:
 Simplify pm_runtime_resume_and_get() error checks
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-15-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-15-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560794624.92412.12736806876160610771.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     d441e9d6435c9f2e4b96057f59e083af580221f2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//d441e9d6435c9f2e4b96057f59e083af580221f2
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:32=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

thermal/drivers/samsung: acpm-tmu: Simplify pm_runtime_resume_and_get() error=
 checks

Unlike pm_runtime_get_sync(), pm_runtime_resume_and_get() returns 0 on
success or a negative error code on failure. Check "if (ret)"
consistently across all pm_runtime_resume_and_get() call sites in
acpm-tmu.c.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-15-0637431b7268@lin=
aro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index bce4674..7c30401 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -161,7 +161,7 @@ static int acpm_tmu_control(struct acpm_tmu_priv *priv, b=
ool on)
 	int i, ret, err =3D 0;
=20
 	ret =3D pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	if (ret)
 		return ret;
=20
 	for (i =3D 0; i < priv->num_sensors; i++) {
@@ -205,7 +205,7 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *=
tz, int *temp)
 		return -ENODATA;
=20
 	ret =3D pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	if (ret)
 		return ret;
=20
 	scoped_guard(mutex, &sensor->lock) {
@@ -463,7 +463,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
=20
 	ret =3D pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to resume device\n");
=20
 	ret =3D acpm_handle->ops->tmu.init(acpm_handle, priv->mbox_chan_id);
