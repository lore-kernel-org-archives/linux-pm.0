From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 4/4] ARM: mvebu: Warn about the wake-up sources not taken into account in suspend
Date: Fri,  3 Jul 2015 13:55:53 +0200
Message-ID: <1435924553-22428-5-git-send-email-gregory.clement@free-electrons.com>
References: <1435924553-22428-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435924553-22428-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On the Armada 370/XP/38x/39x SoCs when the suspend to ram feature is
supported, the SoCs are shutdown and will be woken up by an external
micro-controller, so there is no possibility to setup wake-up sources
from Linux. However, in standby mode, the SoCs stay powered and it is
possible to wake-up from any interrupt sources. Since when the users
configures the enabled wake-up sources there is no way to know if the
user will be doing suspend to RAM or standby, we just allow all
wake-up sources to be enabled, and only warn when entering suspend to
RAM

The purpose of this patch is to inform the user that in suspend to ram
mode, the wake-up sources won't be taken into consideration.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index db31cbb6e2c8..14c7d9d7d973 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -233,6 +233,7 @@ static int mvebu_pm_enter(suspend_state_t state)
 		cpu_do_idle();
 		break;
 	case PM_SUSPEND_MEM:
+		pr_warn("Entering suspend to RAM. Only special wake-up sources will resume the system\n");
 		return mvebu_enter_suspend();
 	default:
 		return -EINVAL;
-- 
2.1.0
