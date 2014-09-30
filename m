From: Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 05/16] arm64: support poweroff through poweroff handler call chain
Date: Tue, 30 Sep 2014 11:00:45 -0700
Message-ID: <1412100056-15517-6-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-pm@vger.kernel.org

The kernel core now supports a poweroff handler call chain
to remove power from the system. Call it if pm_power_off
is set to NULL.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 398ab05..cc0c63e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -157,6 +157,8 @@ void machine_power_off(void)
 	smp_send_stop();
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 }
 
 /*
-- 
1.9.1
