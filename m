From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v7 08/11] arm/arm64: Unexport restart handlers
Date: Tue, 19 Aug 2014 17:45:35 -0700
Message-ID: <1408495538-27480-9-git-send-email-linux@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Jonas Jensen <jonas.jensen@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>
List-Id: linux-pm@vger.kernel.org

Implementing a restart handler in a module don't make sense
as there would be no guarantee that the module is loaded when
a restart is needed. Unexport arm_pm_restart to ensure that
no one gets the idea to do it anyway.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
v7: No change
v6: No change
v5: No change
v4: No change
v3: No change
v2: No change

 arch/arm/kernel/process.c   | 1 -
 arch/arm64/kernel/process.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index ea279f7..250b6f6 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -121,7 +121,6 @@ void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-EXPORT_SYMBOL_GPL(arm_pm_restart);
 
 /*
  * This is our default idle handler.
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 0d3fb9f..398ab05 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -98,7 +98,6 @@ void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
 
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-EXPORT_SYMBOL_GPL(arm_pm_restart);
 
 /*
  * This is our default idle handler.
-- 
1.9.1
