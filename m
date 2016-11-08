From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH] coredump: fix unfreezable coredumping task
Date: Tue, 8 Nov 2016 12:36:37 +0300
Message-ID: <bb7bdfd5-03de-b902-f256-d16b1ddf08ba@virtuozzo.com>
References: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
 <20161107142608.e4fa032b2e32b623663ff2e9@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20161107142608.e4fa032b2e32b623663ff2e9@linux-foundation.org>
Sender: stable-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@redhat.com>, linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/08/2016 01:26 AM, Andrew Morton wrote:
> On Fri, 30 Sep 2016 11:50:34 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> 
>> It could be not possible to freeze coredumping task when it waits
>> for 'core_state->startup' completion, because threads are frozen
>> in get_signal() before they got a chance to complete 'core_state->startup'.
>>
>> Use freezer_do_not_count() to tell freezer to ignore coredumping
>> task while it waits for core_state->startup completion.
>>
>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: stable@vger.kernel.org
> 
> The changelog provides no reason why this patch should be merged into
> -stable.  Nor into anything else, really.
> 
> Please (as always) provide a full description of the bug's end-user
> visible effects.
> 

Sorry. Added the following paragraph:

 Inability to freeze a task during suspend will cause suspend to fail.
 Also CRIU uses cgroup freezer during dump operation. So with unfreezable
 task CRIU dump will fail because it wait for transition from 'FREEZING'
 to 'FROZEN' state which will never happen.


----
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: coredump: fix unfreezable coredumping task

It could be not possible to freeze coredumping task when it waits
for 'core_state->startup' completion, because threads are frozen
in get_signal() before they got a chance to complete 'core_state->startup'.

Inability to freeze a task during suspend will cause suspend to fail.
Also CRIU uses cgroup freezer during dump operation. So with unfreezable
task CRIU dump will fail because it wait for transition from 'FREEZING'
to 'FROZEN' state which will never happen.

Use freezer_do_not_count() to tell freezer to ignore coredumping
task while it waits for core_state->startup completion.

Link: http://lkml.kernel.org/r/1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/coredump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 281b768..eb9c92c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1,6 +1,7 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
+#include <linux/freezer.h>
 #include <linux/mm.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
@@ -423,7 +424,9 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
 
+		freezer_do_not_count();
 		wait_for_completion(&core_state->startup);
+		freezer_count();
 		/*
 		 * Wait for all the threads to become inactive, so that
 		 * all the thread context (extended register state, like
-- 
