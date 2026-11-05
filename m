Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893763;
	b=nilGt+ZFgns073EnQrWZrYc04CAWaocCNrHLKo16r931AIDC3QhZQi2JVo3EXnL1fCZu
	 EyBx1OXqL4ZDYi2dyvBxSGacmi89klwGyZzi77YcuC9Be13NRUXOTH4jL1VkOzFa16OuT
	 HeBuxQ0uyz6q71LZZM3cSEThkiTeD0qZ0X7HcA7188Wah1QRg0SUtRNs+O7NlUc9s5USE
	 7sYcW9FsSoicjUBPYLFvkAGwTXspE3WMxDsZJQT2XN361p1NK39q4p56em9HVD2nAdFoa
	 5iJQ17bMXP2GVgnn0mjjMUOIowHwG05+i159TfzYwH4qMW5x8P/leLo2nO/SU50Cm9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893763;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=EypG+4Cc2jP6UiSvB7D9gOkF/vEE2iZ8kj3Os3j8HV0=;
	b=hw8C9h8HEPhwJV47IyJPj9AteuaCuxEQB/LHqL3QWZ6e9HO63LIGkBSZr2naU4jQcRCK
	 tDkoUq6RkT3R2OsE1ozBBlhQHYmG6dMNGnRRAwvGR9zdHjtdZDGKfduiPhHq+KuaWuc+6
	 LkAFLrAQs7H9/Ylt+8ooLLHXGlJ3bvGW9N3JTHrAQd/1EI9dW6QKrmaZvZpyCliJzvzVN
	 9x1wZF61CUQJmYjjWe6pNxR1mnkkfxiwgIHCIg6/D8bJDPByfBBxmY5AwLn/AuZL1rgk2
	 AQqPZRDCZWQKXeFIh2BwOU8hkucJ00DgdEFuygNCeDgAfRZ7VztpBDzYOA20Dg+u78A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=uDVwgHUK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=P2J+Qfdp;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B095608361D
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B095608361D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=uDVwgHUK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=P2J+Qfdp
Date: Thu, 05 Nov 2026 15:49:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EypG+4Cc2jP6UiSvB7D9gOkF/vEE2iZ8kj3Os3j8HV0=;
	b=uDVwgHUKPia2V6dWQoNmPf6mB66829nmMX3OD9qrf8d5frI+GSx+y8mC6ZKeQDIgv655xt
	RmCJGQrEs4ONenN3kHBjQUDX8E4GSaFTikI9L7Hvk/ZNcxCsWZ7W67SBeVyvsWWFptW98Y
	1zNqdrUF+JBmiML1fFsUScIwI1bIE6UmrHZAtUXeHRokjZ1O0Yf0UY4uzLqA5wRWGWEkZN
	CNpsFDTLe97YfxKrWRYs0bHhzR6SG81FREHqeb+bQHSDTuZ1xYPe+fYXTgtN/H+Lhvajfa
	Ie6J/CZ0mXWw878ELO37nkZNqcTk+hNBNr6FY016I9o82MzhO3VuHgObynis6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EypG+4Cc2jP6UiSvB7D9gOkF/vEE2iZ8kj3Os3j8HV0=;
	b=P2J+QfdpaJp2HtZrw29tVcxIR0pxLL3jVVIRRJF9yTa32DOCXSPXacP2fHIRSIBDq3dgPP
	VhRuOVtpfaVq2RCg==
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
Message-ID: <179389375376.1009794.11135664432821362176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     f316fea84421e3ca569d861ebc7e17632ac54cc2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//f316fea84421e3ca569d861ebc7e17632ac54cc2
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:31=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:51 +01:00

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
