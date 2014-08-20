From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v7 03/11] arm64: Support restart through restart handler call
 chain
Date: Tue, 19 Aug 2014 17:45:30 -0700
Message-ID: <1408495538-27480-4-git-send-email-linux@roeck-us.net>
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

The kernel core now supports a restart handler call chain to restart
the system. Call it if arm_pm_restart is not set.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
v7: No change.
v6: No change.
v5: Renamed restart function to do_kernel_restart
v4: No change.
v3: Use wrapper function to execute notifier call chain.
v2: Only call notifier call chain if arm_pm_restart is not set.
    Do not include linux/watchdog.h.

 arch/arm64/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 1309d64..0d3fb9f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -180,6 +180,8 @@ void machine_restart(char *cmd)
 	/* Now call the architecture specific reboot code. */
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
+	else
+		do_kernel_restart(cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
-- 
1.9.1
