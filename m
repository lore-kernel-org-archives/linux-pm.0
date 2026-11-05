Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893777;
	b=a2waeNcPzZxba2Ar7h0FTN33gJjj53wkWMTdl2xYHIOPa/FJ4PAMuOUf2CYokQBdnr4n
	 IY6FE6KlwWmxAdJGsvlliN3kMSF2ZPbJZijaKGIcHEwiV8Seff4nhXACCMFgEg7zWfmbF
	 iawyiBPR5i5l1VUOY0yXBcmKQ/lf+ldQkXyBnmFjK2wlurgCQbcmwYCqDF1UQPp9iI/iV
	 wn4wL4zSbcY02eacKqpDnSqS24WfqIjsixP1DNZT1pt8pMy2xp6D6fVTF+QfU5ZHhZ7qF
	 XUNPdRu+6Bup9TBViZ5R0pWGkdzBkWcrvfg69LoN0xDdgb76iNXk1L5ELDW6a1euhMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893777;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Blb6qWGKmW/X9meaxEA9Otfj1/W6UEvYu0OJq6479rc=;
	b=ghV3SaMw569uJDZFLdfcUCTie40uxAauT5SeuZHun643BHXDmeJv3caBXg1rT0+0Z4IM
	 H6QK6tRSGbzqwaPN3ZVSbblBOFpNancrt2tTO4FVkhiK3h4CeDC28eLZnxrVzGTWaWO9Y
	 FvDnAoF3sWENMfc+RO1wZRrdpw+nUutlBvyjUNrw2n+xHqErLudKNsk/CFCE8vJOQKVhY
	 gXmkVK1XN6fmKMum9CWekuUuHVaTTVpoCMu1be1XRspflcgV9CVvCtLfcXMg6Bcin5+Fj
	 eux6RGC2wDorV/kwzU0hjyKvrwjoXRq8xTnxcnV4DZHedMZ6dIRgihD0sqozNqrTxwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=B2B19QnZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="qUT9g/jn";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B616083635
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B616083635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=B2B19QnZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qUT9g/jn
Date: Thu, 05 Nov 2026 15:49:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Blb6qWGKmW/X9meaxEA9Otfj1/W6UEvYu0OJq6479rc=;
	b=B2B19QnZ4oeiHU7dseOiCz02H3uBnyWHZ2Mc/L84SrtgKRjJInl0PZvhOCRQ+JY7O0Qt+v
	RvUzAkkZxWTbxj5V15Rg1cFvtxJuNT2t4l8azpkA0TSD0/tlHVcEDjAaNlA55Ej5Ge8fZL
	DzmMBCE1Xv1M+dljmtBIe1bUxm5xyKKOXVuPVAs18ksixgaZjDvkOuCRDrNxFXPcaqNf0V
	yCHVrVgrY6c4V0jrZUb4A5tiz3/zqVygLyR5fcWD9CFnhrJ1vFC6Pey/Kxh9YLjCXK8lxR
	a4tVlOLby7FD7IcGOFwu2h4KfheXNCOphvsa8f9GT04i0jBB3X6NC/VMBR9BEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Blb6qWGKmW/X9meaxEA9Otfj1/W6UEvYu0OJq6479rc=;
	b=qUT9g/jnEqF6zIvZUyp988PkMu7zpdnSMS2W2gG9QGAoeJ0NocOeojEyRTyOCtCO13ktUJ
	mGu8xzPautUEIyDQ==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: Depend on PM
 for EXYNOS_ACPM_THERMAL
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-2-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-2-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179389377363.1009794.11680014190465175989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     91bd8661501baae56980c0a3406774eacf4e645a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//91bd8661501baae56980c0a3406774eacf4e645a
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:19=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:50 +01:00

thermal/drivers/samsung: Depend on PM for EXYNOS_ACPM_THERMAL

The Exynos ACPM TMU driver only prepares and enables its APB clock
(priv->clk) from its runtime PM resume callback
(acpm_tmu_runtime_resume()).

Neither ARM64 nor ARCH_EXYNOS selects CONFIG_PM. When CONFIG_PM is
disabled, pm_runtime_resume_and_get() is a stub returning 0 without
invoking acpm_tmu_runtime_resume(), leaving the APB clock gated when
acpm_tmu_thread_fn() reads the memory-mapped INTPEND registers.

Add a PM dependency to EXYNOS_ACPM_THERMAL.

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS1=
01")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-2-0637431b7268@lina=
ro.org
---
 drivers/thermal/samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index 18ab4ff..b879a63 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -15,6 +15,7 @@ config EXYNOS_ACPM_THERMAL
 	tristate "Exynos ACPM thermal management unit driver"
 	depends on THERMAL_OF
 	depends on HAS_IOMEM
+	depends on PM
 	depends on EXYNOS_ACPM_PROTOCOL
 	select REGMAP_MMIO
 	default ARCH_EXYNOS
