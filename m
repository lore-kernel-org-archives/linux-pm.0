Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607951;
	b=CPJKuvzIcqZZ+D56HZZcQmgdiEAEI7cD8GYzy350FKa4La/uleSz6NZdCzgWXA/a30yc
	 nN08LV6RjP0UYRQLjzrxdtfFxIpvBUB81KX0HrIzRJKagko9WssfgP2iSoU4jIbTSXZme
	 /VXRnrM+ykWH+hi3OBQ92kgLrPuqM1LvmmTBRoV/hJ88dWdOAWV4C1PPBdZjKE7NBT2X5
	 eeMsI9kABJUYsrET+L4gw9nyUpGSUMDByzRf+Wz43oUAVzVQ0Mbi8aHdanGnrbJnekPd+
	 J6bXJgmOnDpK8OqFRQbrQinG8Q8ytC3mk0aEOI0r4bIMlpGirtQ2d2lgRgnI0J/OsNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607951;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=u2TpdDxYejOFNDx9vNR0apRsPCGg6FDYxFhgJVrIUXM=;
	b=c51UOf1d02V4BnkcI9fCSRovZSOePzXqfpCtRGxbFjCiinvmkMaQ2X7Qh9Vi57OxsoCt
	 xQ1wjiKZBFA0P49/1RG99/eUgH1Cij2HWy/fE+b3G1vtJgvlN9JzJxf2lo1jDKmLZB9vD
	 1n326p8PwIhHcZzqlPNDinXnftPWeIzHEHKi+YyCKkLShAvhJOQz1H/IEAfg/HxSUAe7S
	 kJAGpNYvY21SMBgPf0+l8526Ng8LdzhSkSkbtrqVnA3wUNZGBIqYM/ihZ2r6EmHQeNgkV
	 cq9+ChxguazYaxr30qllpzj1SIoopux78hkX6njzFlmezqVf92HX3q0pkb5dobNWChQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rEZRBHsd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="7/eKuvB8";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADB606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8ADB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rEZRBHsd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7/eKuvB8
Date: Wed, 25 Nov 2026 11:59:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2TpdDxYejOFNDx9vNR0apRsPCGg6FDYxFhgJVrIUXM=;
	b=rEZRBHsd08X7wiobguPkeZPHqnLjIoxyzevlaH3TwCfGnljAiWXlWD2KGOISw08h9TIoKN
	7YB/L9d1XBjABBHAcjnfERjKu0k50BDIWYd20yTjlsxk7XgSBiYGg51UpbhcQkOon30OaB
	z6bxEWpt4BdHbYAIh1Bta5Z0kjx4D3ZKZpCOEM/QRlYvFTo5rHpZOX1HcUpLw43RuOaqLp
	szk28YhXZVL/R4I52v18jkO0tuktWYDFAJfwQ7uJfqYXLDLkLO7rkdDo+B/Rjk8QESfAhl
	3KoftS+c7Rm4f14QA1xkNDAzW438aIbBOpGana9cmRKjf2DehAG6rQcTt9dJww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2TpdDxYejOFNDx9vNR0apRsPCGg6FDYxFhgJVrIUXM=;
	b=7/eKuvB8hWHFBXHR8EushVJf7xf8U1HLwhUV1e/I0fWHSmvdHpKXpzmijML8exJsmCFpOS
	bbMihw8C4ciaOLCg==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu:
 Clean up probe error logging
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-14-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-14-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560794779.92412.13474674405606539984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     6fb0469d15ee1a23a2f55e1b349af3bc18a1cd8b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//6fb0469d15ee1a23a2f55e1b349af3bc18a1cd8b
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:31=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

thermal/drivers/samsung: acpm-tmu: Clean up probe error logging

platform_get_irq(), devm_thermal_add_hwmon_sysfs(), and
devm_request_threaded_irq() already log an error or warning message
internally on failure, so drop the duplicate call-site messages in
acpm_tmu_probe(). Also update the copy-pasted "Unable to map syscon
registers" message on devm_regmap_field_bulk_alloc() failure to "Failed
to allocate regmap fields".

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-14-0637431b7268@lin=
aro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index fd491b4..bce4674 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -444,7 +444,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 					   data->reg_fields, REG_INTPEND_COUNT);
 	if (ret)
 		return dev_err_probe(dev, ret,
-				     "Unable to map syscon registers\n");
+				     "Failed to allocate regmap fields\n");
=20
 	priv->clk =3D devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk))
@@ -453,7 +453,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
=20
 	priv->irq =3D platform_get_irq(pdev, 0);
 	if (priv->irq < 0)
-		return dev_err_probe(dev, priv->irq, "Failed to get irq\n");
+		return priv->irq;
=20
 	pm_runtime_set_autosuspend_delay(dev, 100);
 	pm_runtime_use_autosuspend(dev);
@@ -494,16 +494,12 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 		}
 		sensor->tzd =3D tzd;
=20
-		ret =3D devm_thermal_add_hwmon_sysfs(dev, sensor->tzd);
-		if (ret)
-			dev_warn(dev, "Failed to add hwmon sysfs!\n");
+		devm_thermal_add_hwmon_sysfs(dev, sensor->tzd);
 	}
=20
 	ret =3D devm_request_threaded_irq(dev, priv->irq, NULL,
 					acpm_tmu_thread_fn, IRQF_ONESHOT,
 					dev_name(dev), priv);
-	if (ret)
-		ret =3D dev_err_probe(dev, ret, "Failed to request irq\n");
=20
 out_pm_put:
 	pm_runtime_put_autosuspend(dev);
