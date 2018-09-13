From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH RFC] kernel/hung_task.c: disable on suspend
Date: Thu, 13 Sep 2018 17:23:07 +0200
Message-ID: <20180913152307.GA31894@redhat.com>
References: <20180912161119.2692-1-vkuznets@redhat.com>
 <CAJZ5v0jeq=PoF10OZgO9ST_nuRW3Z8emPmX=nTrOSsLKYzZuww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jeq=PoF10OZgO9ST_nuRW3Z8emPmX=nTrOSsLKYzZuww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 09/13, Rafael J. Wysocki wrote:
>
> On Wed, Sep 12, 2018 at 6:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >
> > It is possible to observe hung_task complaints when system goes to
> > suspend-to-idle state:
> >
> >  PM: Syncing filesystems ... done.
> >  Freezing user space processes ... (elapsed 0.001 seconds) done.
> >  OOM killer disabled.
> >  Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> >  sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >  INFO: task bash:1569 blocked for more than 120 seconds.
> >        Not tainted 4.19.0-rc3_+ #687
> >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >  bash            D    0  1569    604 0x00000000
> >  Call Trace:
> >   ? __schedule+0x1fe/0x7e0
> >   schedule+0x28/0x80
> >   suspend_devices_and_enter+0x4ac/0x750
> >   pm_suspend+0x2c0/0x310
>
> This actually is a good catch, but the problem is related to what
> happens to the monotonic clock during suspend to idle.
>
> The clock issue needs to be addressed anyway IMO and then this problem
> will go away automatically.

I don't understand your discussion with Vitaly, but shouldn't we make
khungtaskd thread freezable anyway?

Oleg.

--- x/kernel/hung_task.c
+++ x/kernel/hung_task.c
@@ -185,7 +185,7 @@ static void check_hung_uninterruptible_t
 	hung_task_show_lock = false;
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
-		if (!max_count--)
+		if (!max_count-- || freezing(current))
 			goto unlock;
 		if (!--batch_count) {
 			batch_count = HUNG_TASK_BATCHING;
@@ -249,6 +249,7 @@ static int watchdog(void *dummy)
 {
 	unsigned long hung_last_checked = jiffies;
 
+	set_freezable();
 	set_user_nice(current, 0);
 
 	for ( ; ; ) {
@@ -266,7 +267,7 @@ static int watchdog(void *dummy)
 			hung_last_checked = jiffies;
 			continue;
 		}
-		schedule_timeout_interruptible(t);
+		freezable_schedule_timeout_interruptible(t);
 	}
 
 	return 0;
