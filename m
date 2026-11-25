Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607972;
	b=h6ckHerHhZXvCiRSU2Eu8QSN4TrvJWgLuMbb6h3ALAKj6e3NLQt2FSHVv0yZ2rbCwC9m
	 /6kOkF2j9PIhhlnwPD7tTWG5hK0SCHdv47yIJ8heY4YO0m+PaS7rJGkoyvS354mK4aNt3
	 0yYvx1Dw7mB6r+QnfEg3oRh1b7a4aycbIeHaZmBCIS08qCUwH9wpfcPFug07OT2W4++Am
	 8tgzyq7Nf2WF/ZU8sNwZdsCKglJhwWbkc4OC6EvHh4PtNdpsaOjWzx5qF0xVBI8GefVXd
	 IVMu1/HZmVe8Gnq5WuM3cimzdFQfn3xTciELu7RhyinhsIhNXrsa2lXSQE1P/+6BGSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607972;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=XArzqNYWyCzDDJ0FbhBqtA4Hq42RWGVItHQvWdaZ848=;
	b=plJ4hDASEObbdsWIfDegP9lE7vxwF5d1FhLk3MBpNMlZWlmQuleMf2qpdOk1bZoNxn5n
	 ke2wbOUxm4r6Jk0FLUBZ1uddIF6w84hWn7UsUiJWpCtUmGkwSwOLDTMYQJSf6YnfQAfp2
	 lYGqdT7kBrWSZJ9y2D8sJNKiqbLM4mqf0+EgpgtF+c5zd+uVAziBO52oKEsCJVEQorIsP
	 Os17RpqUCGPJs7gU+wcIz8La6sOjylBPsNuL4ChsG9TNkwDyfUwIfG27e1a2odfdkOfht
	 bWe7lYnLU2jqSMA8cBLbyXkG2+KEZFwqdTG/K8YSa9kl4Cj07Dpdx+3oQHugGwae8oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dpX8wznG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="YMkHC/F2";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157DC606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 157DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dpX8wznG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=YMkHC/F2
Date: Wed, 25 Nov 2026 11:59:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XArzqNYWyCzDDJ0FbhBqtA4Hq42RWGVItHQvWdaZ848=;
	b=dpX8wznGIc4ya2SnipHlfDtfd5UvMiOieFLkN8S3BSdvswN0C1c9Hhvd0S9CgqyVK4eafP
	IlWeuTEqCh0NdppIzrubVBgiPM52qQHBIrln67xtLUqgUS3dPRZ8+O40c2KxZ9PdriEkv3
	IwRJl1M2o/L2Nj16nTL/9CUrg49EUXIrGGWi+IyvXOVXSJnBgCNBapGOCcFV4x/SjQeanY
	EnDEgPcN7wyt2B4+ZcioEVlHAxj1O8hTVGh+fs6b3cnmeSezP+NzJCQ7jXJDPpAJV6ru88
	eJYkUm2WGrviKEREBka2ACUSmHipJlwJMJGgX4u1OE56JSShKb37QHQuPq8LVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XArzqNYWyCzDDJ0FbhBqtA4Hq42RWGVItHQvWdaZ848=;
	b=YMkHC/F2TtZnEhH5Hyux6XTo+DK5ZZWKrMCb4nkbVOAPGWpGvH4XX2oCFWmUrAZR8UOVEZ
	s33L6hQsQD9/YDBg==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: Select
 REGMAP_MMIO for EXYNOS_ACPM_THERMAL
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-1-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-1-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560796857.92412.15664207112528348188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     97445e9f995c7ae2d8c4dd97221deb3e2292a75b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//97445e9f995c7ae2d8c4dd97221deb3e2292a75b
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:18=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

thermal/drivers/samsung: Select REGMAP_MMIO for EXYNOS_ACPM_THERMAL

The Exynos ACPM TMU driver calls devm_regmap_init_mmio() in
acpm_tmu_probe(), which requires CONFIG_REGMAP_MMIO.

When ARCH_EXYNOS is enabled, REGMAP_MMIO is selected transitively via
EXYNOS_PMU. However, both the Samsung thermal menu and
EXYNOS_ACPM_PROTOCOL allow COMPILE_TEST builds with ARCH_EXYNOS disabled
(COMPILE_TEST && !ARCH_EXYNOS), where nothing in EXYNOS_ACPM_THERMAL's
dependency chain selects REGMAP_MMIO, resulting in build failures when
REGMAP_MMIO is not enabled by another driver.

Select REGMAP_MMIO under config EXYNOS_ACPM_THERMAL.

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS1=
01")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-1-0637431b7268@lina=
ro.org
---
 drivers/thermal/samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index f63eeae..18ab4ff 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -16,6 +16,7 @@ config EXYNOS_ACPM_THERMAL
 	depends on THERMAL_OF
 	depends on HAS_IOMEM
 	depends on EXYNOS_ACPM_PROTOCOL
+	select REGMAP_MMIO
 	default ARCH_EXYNOS
 	help
 	  Support for the Thermal Management Unit (TMU) on Samsung Exynos SoCs
