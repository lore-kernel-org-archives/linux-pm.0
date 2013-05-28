From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [regression,bisected] restore of disks after suspend-to-disk broken in 3.9.x
Date: Tue, 28 May 2013 15:20:35 +0200
Message-ID: <1569319.PChVOz05me@vostro.rjw.lan>
References: <CAPm-kmsTNz4niGXsWyhLwwBkQ48gHdq1vjPvSKKwQ0kbhHm=JQ@mail.gmail.com> <2552290.9fhTfGPlAk@vostro.rjw.lan> <CAPm-kmsCKB8w2ud8UEdnBP1EFuc-jQ5QWNUOFTqtF3mLjmriHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPm-kmsCKB8w2ud8UEdnBP1EFuc-jQ5QWNUOFTqtF3mLjmriHg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Giacomo Perale <giacomo.perale@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 28, 2013 02:59:25 PM Giacomo Perale wrote:
> 2013/5/28 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Monday, May 27, 2013 10:07:18 PM Giacomo Perale wrote:
> >> 2013/5/27 Zhang Rui <rui.zhang@intel.com>:
> >> > On Sun, 2013-05-26 at 15:51 +0200, Giacomo Perale wrote:
> >> >> Hello,
> >> >>
> >> >> after upgrading from 3.8.7 to 3.9.x I noticed some slightly longer
> >> >> delays when resuming from suspend-to-disk and a few new error messages
> >> >> in the logs:
> >> >>
> >> >>
> >> >> Not having connected the issue with the previous error messages I
> >> >> initially blamed the disk and replaced it with a new one thinking it
> >> >> was broken, but the problem persisted so I started a bisection run
> >> >> that pointed to this commit:
> >> >>
> >> >>
> >> >> b8bb6cb999858043489c1ddef08eed2127559169 is the first bad commit
> >> >> commit b8bb6cb999858043489c1ddef08eed2127559169
> >> >> Author: Zhang Rui <rui.zhang@intel.com>
> >> >> Date:   Thu Nov 22 15:45:02 2012 +0800
> >> >>
> >> >>     step_wise: Unify the code for both throttle and dethrottle
> >> >>
> >> >>     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >> >>
> >> > I do not see how this would affect the sata hibernation/resume.
> >> > but anyway, would you please try the four patches in comment #10, #11,
> >> > #12 and #13 in
> >> > https://bugzilla.kernel.org/show_bug.cgi?id=58301
> >> > and check if they help?
> >> >
> >> > thanks,
> >> > rui
> >> >
> >>
> >> No luck, with git head and those four patches hibernation is
> >> completely broken, the system doesn't even shut down, it just loses
> >> the disks (I'm attaching what I could get from /proc/kmsg to this
> >> email).
> >>
> >> With the fair_share governor or with step_wise _and_ commit
> >> b8bb6cb999858043489c1ddef08eed2127559169 reverted everything is ok
> >> again.
> >>
> >> I think there's something wrong in the commit logic (for example, why
> >> are you checking for "instance->target != THERMAL_NO_TARGET" when
> >> update_instance_for_throttle checked for "instance->target ==
> >> THERMAL_NO_TARGET"?) but my attempts to fix it failed, probably
> >> because I'm not sure of what 'continue;' does inside a
> >> list_for_each_entry macro.
> >
> > Can you please attach the output of acpidump from your system?
> >
> > Rafael
> >
> >
> 
> Sure, here it is.

Thanks!

Can you please also check if the patch below makes any difference?

Rafael


---
 drivers/thermal/step_wise.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/thermal/step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/step_wise.c
+++ linux-pm/drivers/thermal/step_wise.c
@@ -131,6 +131,9 @@ static void thermal_zone_trip_update(str
 			continue;
 
 		old_target = instance->target;
+		if (!throttle && old_target == THERMAL_NO_TARGET)
+			continue;
+
 		instance->target = get_target_state(instance, trend, throttle);
 
 		/* Activate a passive thermal instance */


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
