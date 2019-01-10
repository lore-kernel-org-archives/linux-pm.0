From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v5 09/10] ARM: export arm_pm_restart
Date: Thu, 10 Jan 2019 18:58:44 +0100
Message-ID: <20190110175845.1203986-10-lkundrak@v3.sk>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110175845.1203986-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Mark Rutland <mark.rutland@arm.com>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

The OLPC XO 1.75 laptop is rebooted with a command to the Embedded
Controller. The EC driver should be a module, since most people don't nee=
d
it to be compiled in.

The EC driver can't use register_restart_handler() because handlers
registered with it are executed in atomic context and the XO 1.75 reboot
dance needs to block: the reboot is initiated by poking a GPIO ofter
which we need to wait for the EC to initiate a SPI transfer and finish
it.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v4:
- Clarify why we need this

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
