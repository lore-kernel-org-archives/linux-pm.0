Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607970;
	b=2xrsb30srGlOBUzvOaZpON0wdsCq+c2cap+XC9sHJJ3x5/XsOCC5m0IbQBPdOTIJdKAf
	 Y5W2NDKYOg1l8uYOfQ9bexkcLEm+b9nKQNDO0/CENz2QUwENwKZInR2ikrydOoXKHkz4j
	 PJIzfPWixsP6bGdf6+BC36wzNgqULoaXYPZ/vTzQoVaJ2ipTBAO0QIZAykdkinR77E9t6
	 NLu8DJ27ncwB7RGmFpWP7k/HWb6b5mNvX7d1vnnt+10v4ONsjy+Zbo1CiBrfldMTdouNb
	 udxt4bOck69Wdjxy59HitzGzeTeFDyu+1UVp3Z8JIX3Y/+RDBlKDjM9xZL498LkzXcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607970;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=A+JCek6lN/x3fz/TcuHUvTC8Z2HyJqc919qRTWgAMqc=;
	b=sMzWrnI1UOiaLLbDHjieOfm5Rcxm1a4f3+6rutIRyB0xABzVxcUEknEdP5WhCYp1+kyA
	 xiufknYFGYGgfxMOa25+IMVSTl4TS46WQCQOGV0y8dGDOHlpAkCBvfpgjp5wFx9UKlhbQ
	 OmxJGuNN2PahyYEA6+ruF1yfSIPpPYPUSH3FhwgWUF+8ThDmxD8Tmgokef0IClFymgUhU
	 otGSpfJoz4W8GuJts1jFcwTZAy9lUVccNE6w+Nr1aJM7/WBBSJ0HHeR4uXrDvwedB7Jcu
	 +F/3EOxa2xL8crhVihliCP91gug9SUf8C5Hz59d1/UBWIIzG7Wqt9aFn5f6NkPcU6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=uXFeD2Ob;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uYbJZKuK;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34891606A327
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34891606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=uXFeD2Ob;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uYbJZKuK
Date: Wed, 25 Nov 2026 11:59:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+JCek6lN/x3fz/TcuHUvTC8Z2HyJqc919qRTWgAMqc=;
	b=uXFeD2ObF936lkBHpHtPNuiz3UY90nOz7YTa3O4kQ3n4d3PwdrlQSQeElLvQDqvYZVsCGr
	aplTEaBrSdqfh2oVFdMpX8GbrnRjpofzyyVg3ik7fRRSweDij07BXSbWj/xts/LXi73m1e
	8ZbFcFTQzRDr4eKHtlJfdbPollmQz1JoezyabMxVbxQAXXOonmcAoZgIAifFFbK31t+xUx
	7rDt0+eAsHI4SqF8W9EZ8xioUrUuZV/W3H1MjoBMRjzVPoWIWQsqSY6SeZ9RgQG8Zpu6ih
	rOQcuRZlLOCX92QLxMoxeBMDVSsUQ1jTR33WGj60kjerBjcWNZQ+dQiwh8DrqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+JCek6lN/x3fz/TcuHUvTC8Z2HyJqc919qRTWgAMqc=;
	b=uYbJZKuKIvIPUnV6SGzugb3/FFPnAXfWsc/Wre8rC4JqoZekK0lK3u4QrNIXkDKrzwxNjx
	jw58iJrfDkRDEECw==
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
Message-ID: <179560796701.92412.5399296023008052923.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     d111bbdf55fdedb6dcc4ae3b3e1a291a64a3b78e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//d111bbdf55fdedb6dcc4ae3b3e1a291a64a3b78e
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:19=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

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
