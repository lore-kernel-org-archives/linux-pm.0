Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893779;
	b=EVUb37mSWR/VIJd7yhopTGID/yc80ooiesDUvQwmjdkENIrrG7LYWxzuroOhkA8H9q+d
	 WXZ0vNX4o/qAI0NBvulBvKuy7ymraJsxmCoBhEnj5OsHQ/ZJqu247BiOsdorR4Z2uH0Na
	 mw3Sp8JMR3ovwuK4AMQI3j2dLgXgMUQnzeqZ/4hnzEh6NHUvaIWHeC3CvPE11Wu6o+erm
	 fnAAFy6Ly/kPLbQjT4jS0dRBYK7Rx6V1basUiB5GS4f4Ygc4LZ2rC9dSSDpeHSpgb/gTH
	 5TXeWU0Q3bqZjI5sLE9sikFBpNLQNi76mrHHLDvoNNam+r3v2MgU98ggq/BXGmzFplw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893779;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=LL+Q7ftmNR6tRTeaQ9O+DFfKsQht8nI87ZVMc5kakjM=;
	b=HtaNn/HukL65tYFtkw8+G9i8Hf+tt9Yf4Bnmdp0s73wWlmPBnLDFc3f75VoHI6TGYmwr
	 RDw86M5obQrNdkodNA/REHe2AhC1+szhrReoR69fgBo2KCz0cgJNfa8OQZEP5jOXmTx1Q
	 K7ugtJ6Sfu7o/brm4B7QdgKaLKIaQvpbP/DYZTOLPFw4uKcRtaxQmR9dl45GwTyYL8RvT
	 +xGKhTKk4+3IE38mriQ580IneOILjowlIuPM02CjMDkiG4J8mAVJe6kpP2Insrf5qyor5
	 +SrCoVUCUmNCtfkTYtqTEZZMDoj1vxj0LGfG5RP30LwlhcI3SKQ/pe3iJ1vJUBa5ENA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=KljvfkGA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Fzu595vM;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38B606D83E
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE38B606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=KljvfkGA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Fzu595vM
Date: Thu, 05 Nov 2026 15:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LL+Q7ftmNR6tRTeaQ9O+DFfKsQht8nI87ZVMc5kakjM=;
	b=KljvfkGAxacyonk24EvGudVHmDk8IMISwy7j/28+zSH0iKIzwAv7cKrF0AS03mZZsgkQhx
	2OZzKh+26Hq7Usv7h81BF3p1pDZEAFGYptFFfzaceA4RxEI7dGa61cz4+gLffBnEtBuaec
	+OuQ0ui/dG0mJe3k5H5QcOpUBKFJO0CKH0laiNuj1y115UDRkglBGv65qQriSXXC3IAuKZ
	B0MP6lKuQeHtRavWpwU5IMFV8womBsJ2HbM/QJGfNqSlNVYb1R/vSWakv4rIuowLyUqZTR
	tB1RUnfAOVkyW3RljmQ6fwcfysVnpWRcw8gK+Df3bSDiutSg7xLg1gNj3FSV5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LL+Q7ftmNR6tRTeaQ9O+DFfKsQht8nI87ZVMc5kakjM=;
	b=Fzu595vMicYVEjS9n0l3Z1OrcO3UFy4na4zbw9lFCF6oO20eltQqhvzvI79+iKcrDr1g6d
	eC0TtG+qRc5G5ACw==
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
Message-ID: <179389377540.1009794.14789197477393277680.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     e7c21e12c48e95865c85bdf4431e595359d8abf4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//e7c21e12c48e95865c85bdf4431e595359d8abf4
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:18=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:50 +01:00

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
