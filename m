From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] arm64: Enable OPP
Date: Fri,  9 May 2014 17:40:29 +0100
Message-ID: <1399653631-4938-1-git-send-email-broonie@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39430 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbaEIQlG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 12:41:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

Some of the generic drivers used on ARM class systems use OPP so allow it
to be selected in Kconfig. No code is required for this, it is not clear
to me why there is config for this option.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8ccdd2646ae3..8256d6d09d33 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_HAS_OPP
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_WANT_OPTIONAL_GPIOLIB
-- 
2.0.0.rc2

