From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH] coredump: fix unfreezable coredumping task
Date: Fri, 30 Sep 2016 12:01:52 +0300
Message-ID: <cf7d86b9-7a84-9a39-301b-b2fa7427baab@virtuozzo.com>
References: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 09/30/2016 11:50 AM, Andrey Ryabinin wrote:
> It could be not possible to freeze coredumping task when it waits
> for 'core_state->startup' completion, because threads are frozen
> in get_signal() before they got a chance to complete 'core_state->startup'.
> 
> Use freezer_do_not_count() to tell freezer to ignore coredumping
> task while it waits for core_state->startup completion.
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/coredump.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 281b768..eb9c92c 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1,6 +1,7 @@
>  #include <linux/slab.h>
>  #include <linux/file.h>
>  #include <linux/fdtable.h>
> +#include <linux/freezer.h>
>  #include <linux/mm.h>
>  #include <linux/stat.h>
>  #include <linux/fcntl.h>
> @@ -423,7 +424,9 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
>  	if (core_waiters > 0) {
>  		struct core_thread *ptr;
>  
> +		freezer_do_not_count();
>  		wait_for_completion(&core_state->startup);
> +		freezer_count();


As alternative to this we could introduce and use wait_for_completion_freezable():


---
 fs/coredump.c              | 2 +-
 include/linux/completion.h | 1 +
 kernel/sched/completion.c  | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 281b768..c145233 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -423,7 +423,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
 
-		wait_for_completion(&core_state->startup);
+		wait_for_completion_freezable(&core_state->startup);
 		/*
 		 * Wait for all the threads to become inactive, so that
 		 * all the thread context (extended register state, like
diff --git a/include/linux/completion.h b/include/linux/completion.h
index 5d5aaae..8c2626f 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -89,6 +89,7 @@ static inline void reinit_completion(struct completion *x)
 }
 
 extern void wait_for_completion(struct completion *);
+extern void wait_for_completion_freezable(struct completion *);
 extern void wait_for_completion_io(struct completion *);
 extern int wait_for_completion_interruptible(struct completion *x);
 extern int wait_for_completion_killable(struct completion *x);
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 8d0f35d..0b9d1e3 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -11,6 +11,7 @@
  * Waiting for completion is a typically sync point, but not an exclusion point.
  */
 
+#include <linux/freezer.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
 
@@ -123,6 +124,12 @@ void __sched wait_for_completion(struct completion *x)
 }
 EXPORT_SYMBOL(wait_for_completion);
 
+void __sched wait_for_completion_freezable(struct completion *x)
+{
+	__wait_for_common(x, freezable_schedule_timeout,
+			MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
+}
+
 /**
  * wait_for_completion_timeout: - waits for completion of a task (w/timeout)
  * @x:  holds the state of this particular completion
-- 
