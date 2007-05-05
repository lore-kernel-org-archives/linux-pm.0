From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sun, 6 May 2007 00:36:43 +0200
Message-ID: <200705060036.44550.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705051743560.27516-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705051743560.27516-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Berg <johannes@sipsolutions.net>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Saturday, 5 May 2007 23:44, Alan Stern wrote:
> On Sat, 5 May 2007, Rafael J. Wysocki wrote:
> 
> > > In addition we may want to have early/late variations on these (for use 
> > > after interrupts have been disabled), which would lead to:
> > > 
> > > 	pre_snapshot()
> > > 	pre_snapshot_late()
> > > 	post_snapshot_early()
> > > 	post_snapshot()
> > > 	pre_restore()
> > > 	pre_restore_late()
> > > 	post_restore_early()
> > > 	post_restore()
> > > 
> > > Yes, it's a large list...  But it seems to be necessary for providing all 
> > > the information drivers will need.
> > 
> > I think we may need yet another callback, executed before pre_snapshot()
> > and before we shrink memory during the hibernation, to be used by drivers
> > that need a lot of additional memory in pre_snapshot().
> 
> 	pre_snapshot_early()

OK

So, I think the hibernation code ordering should be like this (let's forget
about ACPI for now):

1) tasks are frozen
2) pre_snapshot_early()
3) memory is freed for the snapshot image
4) pre_snapshod()
5) nonboot CPUs are offlined
6) IRQs are disabled
7) pre_snapshot_late()
8) sysdev_pre_snapshot()
9) snapshot image is created
10) sysdev_post_snapshot()
11) post_snapshot_early()
12) IRQs are enabled
13) nonboot CPUs are enabled
14) post_snapshot()
15) snapshot image is saved
16) device_shutdown()
17) system is powered off

Apart from this, we may need notifiers for subsystems that should do something
before the freezing and after the thawing of tasks (like FUSE etc.).

Also, if there's an error, we have to be able to thaw tasks after
post_snapshot() and continue running.

The restore code, IMO, should be like this (again, let's ignore ACPI for now):

1) boot kernel is started, initrd is loaded etc.
2) tasks are frozen
3) snapshot image is loaded
4) pre_restore()
5) nonboot CPUs are offlined
6) IRQs are disabled
7) pre_restore_late()
8) sysdev_pre_restore()
9) boot kernel is replaced with the 'hibernated' kernel
10) sysdev_post_restore()
11) post_restore_early()
12) IRQs are enabled
13) nonboot CPUs are enabled
14) post_restore()
15) tasks are thawed
16) system is running

and we may need a notifier for subsystems that should do something after
tasks have been thawed.

Greetings,
Rafael
