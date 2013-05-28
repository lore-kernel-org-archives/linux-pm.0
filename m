From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [regression,bisected] restore of disks after suspend-to-disk broken in 3.9.x
Date: Tue, 28 May 2013 23:21:07 +0200
Message-ID: <2311399.dRVpqHHLQS@vostro.rjw.lan>
References: <CAPm-kmsTNz4niGXsWyhLwwBkQ48gHdq1vjPvSKKwQ0kbhHm=JQ@mail.gmail.com> <1569319.PChVOz05me@vostro.rjw.lan> <CAPm-kmu45=uqR2TXmHKjtNcvRCmOpu7cpOzi6WyWmsTdw-QPPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPm-kmu45=uqR2TXmHKjtNcvRCmOpu7cpOzi6WyWmsTdw-QPPw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Giacomo Perale <giacomo.perale@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 28, 2013 03:47:30 PM Giacomo Perale wrote:
> 2013/5/28 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Tuesday, May 28, 2013 02:59:25 PM Giacomo Perale wrote:
> >> 2013/5/28 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > On Monday, May 27, 2013 10:07:18 PM Giacomo Perale wrote:
> >> >> 2013/5/27 Zhang Rui <rui.zhang@intel.com>:
> >> >> > On Sun, 2013-05-26 at 15:51 +0200, Giacomo Perale wrote:
> >> >> >> after upgrading from 3.8.7 to 3.9.x I noticed some slightly longer
> >> >> >> delays when resuming from suspend-to-disk and a few new error messages
> >> >> >> in the logs:
> >> >> >>
> >> >> >>
> >> >> >> Not having connected the issue with the previous error messages I
> >> >> >> initially blamed the disk and replaced it with a new one thinking it
> >> >> >> was broken, but the problem persisted so I started a bisection run
> >> >> >> that pointed to this commit:
> >> >> >>
> >> >> >>
> >> >> >> b8bb6cb999858043489c1ddef08eed2127559169 is the first bad commit
> >> >> >> commit b8bb6cb999858043489c1ddef08eed2127559169
> >> >> >> Author: Zhang Rui <rui.zhang@intel.com>
> >> >> >> Date:   Thu Nov 22 15:45:02 2012 +0800
> >> >> >>
> >> >> >>     step_wise: Unify the code for both throttle and dethrottle
> >> >> >>
> >> >> >>     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >> >> >>
> >> >> > I do not see how this would affect the sata hibernation/resume.
> >> >> > but anyway, would you please try the four patches in comment #10, #11,
> >> >> > #12 and #13 in
> >> >> > https://bugzilla.kernel.org/show_bug.cgi?id=58301
> >> >> > and check if they help?
> >> >> >
> >> >> > thanks,
> >> >> > rui
> >> >> >
> >> >>
> >> >> No luck, with git head and those four patches hibernation is
> >> >> completely broken, the system doesn't even shut down, it just loses
> >> >> the disks (I'm attaching what I could get from /proc/kmsg to this
> >> >> email).
> >> >>
> >> >> With the fair_share governor or with step_wise _and_ commit
> >> >> b8bb6cb999858043489c1ddef08eed2127559169 reverted everything is ok
> >> >> again.
> >> >>
> >> >
> >> > Can you please attach the output of acpidump from your system?
> >> >
> >> > Rafael
> >> >
> >> >
> >>
> >> Sure, here it is.
> >
> > Thanks!
> >
> > Can you please also check if the patch below makes any difference?
> >
> > Rafael
> >
> >
> 
> With that patch hibernation is working again on git head and on 3.9.2.
> 
> Thank you!

Thanks for testing.  It seems to me, though, that we need to do something
more radical here.  Can you please test the one below too and report back?

Rafael


---
 drivers/thermal/step_wise.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/thermal/step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/step_wise.c
+++ linux-pm/drivers/thermal/step_wise.c
@@ -109,7 +109,6 @@ static void thermal_zone_trip_update(str
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
 	bool throttle = false;
-	int old_target;
 
 	if (trip == THERMAL_TRIPS_NONE) {
 		trip_temp = tz->forced_passive;
@@ -130,18 +129,15 @@ static void thermal_zone_trip_update(str
 		if (instance->trip != trip)
 			continue;
 
-		old_target = instance->target;
-		instance->target = get_target_state(instance, trend, throttle);
+		if (!throttle && instance->target == THERMAL_NO_TARGET)
+			continue;
 
-		/* Activate a passive thermal instance */
-		if (old_target == THERMAL_NO_TARGET &&
-			instance->target != THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip_type, 1);
-		/* Deactivate a passive thermal instance */
-		else if (old_target != THERMAL_NO_TARGET &&
-			instance->target == THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip_type, -1);
+		instance->target = get_target_state(instance, trend, throttle);
 
+		/* Activate or deactivate a passive thermal instance */
+		if (instance->target == THERMAL_NO_TARGET)
+			update_passive_instance(tz, trip_type,
+						throttle ? 1 : -1);
 
 		instance->cdev->updated = false; /* cdev needs update */
 	}

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
