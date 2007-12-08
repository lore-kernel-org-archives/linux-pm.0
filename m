From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Sun, 09 Dec 2007 00:12:52 +0100
Message-ID: <475B24F4.3090904__32113.8900043026$1197155664$gmane$org@gmail.com>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
	<47595A0A.5000502@gmail.com> <20071207151150.GB24254@elte.hu>
	<20071207175134.GA18916@elte.hu> <475A5188.6070809@gmail.com>
	<20071208083939.GD30997@elte.hu> <475A629C.7010408@gmail.com>
	<20071208152447.GA30270@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071208152447.GA30270@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 12/08/2007 04:24 PM, Ingo Molnar wrote:
> i'm wondering why it had no effect now

diff --git a/kernel/cpu.c b/kernel/cpu.c
index e0d3a4f..a46c252 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -47,15 +47,21 @@ void __init cpu_hotplug_init(void)
 }

 #ifdef CONFIG_HOTPLUG_CPU
-
+#include <asm/io.h>
 void get_online_cpus(void)
 {
+       outb(0x20, 0x80);
        might_sleep();
+       outb(0x21, 0x80);
        if (cpu_hotplug.active_writer == current)
                return;
+       outb(0x22, 0x80);
        mutex_lock(&cpu_hotplug.lock);
+       outb(0x23, 0x80);
        cpu_hotplug.refcount++;
+       outb(0x24, 0x80);
        mutex_unlock(&cpu_hotplug.lock);
+       outb(0x25, 0x80);

 }
 EXPORT_SYMBOL_GPL(get_online_cpus);

produces 0x22 on the LCD (called from watchdog kthread).

Going to catch some sleep,
--js
