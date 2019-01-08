From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v4 01/15] ARM: export arm_pm_restart()
Date: Tue,  8 Jan 2019 18:58:04 +0100
Message-ID: <20190108175818.705110-2-lkundrak@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Cc: James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

The OLPC XO 1.75 laptop is rebooted with a command to the Embedded
Controller. The EC driver should be a module, since most people don't nee=
d
it to be compiled in.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
Changes since v3:
- Added the patch to the set

 arch/arm/kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 3b2aa9a9fe26..71016cf19b86 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -22,6 +22,7 @@ typedef void (*phys_reset_t)(unsigned long, bool);
  * Function pointers to optional machine specific functions
  */
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
+EXPORT_SYMBOL_GPL(arm_pm_restart);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
=20
--=20
2.20.1
