From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] PM / OPP: Make OPP invisible to users in Kconfig
Date: Fri,  9 May 2014 19:18:08 +0100
Message-ID: <1399659488-13974-1-git-send-email-broonie@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39538 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135AbaEISSW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 14:18:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, menon.nishanth@gmail.com
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

The OPP code is an in kernel library selected by its users, there is no
no architecture code required to implement it and enabling it without a
user just increases the kernel size. Since the users select rather than
depend on it just remove the ability to directly set the option from
Kconfig.

Signed-off-by: Mark Brown <broonie@linaro.org>
---

This leaves the ARCH_HAS_OPP symbol since removing that requires
updating the relevant architectures, if this is OK I can sumbit a
followup patch cleaning that up.

 kernel/power/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 2fac9cc79b3d..9a83d780facd 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -257,8 +257,7 @@ config ARCH_HAS_OPP
 	bool
 
 config PM_OPP
-	bool "Operating Performance Point (OPP) Layer library"
-	depends on ARCH_HAS_OPP
+	bool
 	---help---
 	  SOCs have a standard set of tuples consisting of frequency and
 	  voltage pairs that the device will support per voltage domain. This
-- 
2.0.0.rc2

