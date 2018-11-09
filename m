From: Chanho Min <chanho.min@lge.com>
Subject: [PATCH] exec: make de_thread() freezable
Date: Fri,  9 Nov 2018 17:37:36 +0900
Message-ID: <1541752656-12857-1-git-send-email-chanho.min@lge.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Christian Brauner <christian@brauner.io>, Oleg Nesterov <oleg@redhat.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Seungho Park <seungho1.park@lge.com>, Inkyu Hwang <inkyu.hwang@lge.com>, Donghwan Jung <donghwan.jung@lge.com>, Jongsung Kim <neidhard.kim@lge.com>, Chanho Min <chanho.min@lge.com>
List-Id: linux-pm@vger.kernel.org

Suspend fails due to the exec family of functions blocking the freezer.
The casue is that de_thread() sleeps in TASK_UNINTERRUPTIBLE waiting for
all sub-threads to die, and we have the deadlock if one of them is frozen.
In our machine, it causes freeze timeout as bellows.

Freezing of tasks failed after 20.010 seconds (1 tasks refusing to freeze, wq_busy=0):
setcpushares-ls D ffffffc00008ed70     0  5817   1483 0x0040000d
 Call trace:
[<ffffffc00008ed70>] __switch_to+0x88/0xa0
[<ffffffc000d1c30c>] __schedule+0x1bc/0x720
[<ffffffc000d1ca90>] schedule+0x40/0xa8
[<ffffffc0001cd784>] flush_old_exec+0xdc/0x640
[<ffffffc000220360>] load_elf_binary+0x2a8/0x1090
[<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
[<ffffffc00021c584>] load_script+0x20c/0x228
[<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
[<ffffffc0001ce8e0>] do_execveat_common.isra.14+0x4f8/0x6e8
[<ffffffc0001cedd0>] compat_SyS_execve+0x38/0x48
[<ffffffc00008de30>] el0_svc_naked+0x24/0x28

To fix this, make de_thread() freezable. It looks safe and works fine.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 fs/exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1ebf6e5..70ccfc8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -62,6 +62,7 @@
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
+#include <linux/freezer.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1083,7 +1084,7 @@ static int de_thread(struct task_struct *tsk)
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
-		schedule();
+		freezable_schedule();
 		if (unlikely(__fatal_signal_pending(tsk)))
 			goto killed;
 		spin_lock_irq(lock);
-- 
2.1.4
