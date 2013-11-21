From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v3 12/12] arm64: add CPU power management menu/entries
Date: Thu, 21 Nov 2013 11:24:19 +0000
Message-ID: <1385033059-25896-13-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33348 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091Ab3KULZD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2013 06:25:03 -0500
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>

This patch provides a menu for CPU power management options in the
arm64 Kconfig and adds an entry to enable the generic CPU idle configuratio=
n.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0d78e92..3e2c392 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -291,6 +291,12 @@ config ARM64_CPU_SUSPEND
=20
 endmenu
=20
+menu "CPU Power Management"
+
+source "drivers/cpuidle/Kconfig"
+
+endmenu
+
 source "net/Kconfig"
=20
 source "drivers/Kconfig"
--=20
1.8.4


