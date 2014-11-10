From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 36/48] arm64: psci: Register with kernel power-off handler
Date: Sun,  9 Nov 2014 17:42:53 -0800
Message-ID: <1415583785-6980-37-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- This patch: No change.
  Global: Replaced priority defines with enum.
v5:
- Rebase to v3.18-rc3
v4:
- No change
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority

 arch/arm64/kernel/psci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 866c1c8..5cab066 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -359,7 +359,8 @@ static int __init psci_0_2_init(struct device_node *np)
 
 	arm_pm_restart = psci_sys_reset;
 
-	pm_power_off = psci_sys_poweroff;
+	register_power_off_handler_simple(psci_sys_poweroff,
+					  POWER_OFF_PRIORITY_DEFAULT);
 
 out_put_node:
 	of_node_put(np);
-- 
1.9.1
