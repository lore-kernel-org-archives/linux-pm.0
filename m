From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] drivers: cpuidle: add driver/device checks in cpuidle_enter_freeze()
Date: Thu, 26 Feb 2015 01:35:50 +0100
Message-ID: <15834207.00hEZkbSPy@vostro.rjw.lan>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com> <20150225144737.GD20214@red-moon> <2987982.3bDckoN2hb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62124 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752714AbbBZAMZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 19:12:25 -0500
In-Reply-To: <2987982.3bDckoN2hb@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Thursday, February 26, 2015 12:50:58 AM Rafael J. Wysocki wrote:
> On Wednesday, February 25, 2015 02:47:37 PM Lorenzo Pieralisi wrote:
> > On Wed, Feb 25, 2015 at 02:30:49PM +0000, Daniel Lezcano wrote:
> > > On 02/24/2015 06:58 PM, Lorenzo Pieralisi wrote:
> > > > The changes in commit:
> > > >
> > > > 381063133246 ("PM / sleep: Re-implement suspend-to-idle handling")
> > > >
> > > > let suspend-to-idle code bypass the cpuidle_select() function to
> > > > enter the deepest idle state. The sanity checks carried out in
> > > > cpuidle_select() are bypassed too and this can cause breakage
> > > > on systems that try to suspend-to-idle with no registered cpuidle
> > > > driver.
> > > >
> > > > This patch factors out a function cpuidle_device_disabled() that
> > > > is used to carry out sanity checks (ie CPUidle is disabled on the
> > > > cpu executing the code) in both cpuidle_select() and cpuidle_enter_freeze()
> > > > so that the checks are unified and carried out in both control paths.
> > > >
> > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > ---
> > > >   drivers/cpuidle/cpuidle.c | 18 +++++++++++++-----
> > > >   1 file changed, 13 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > > > index f47edc6c..344fe6c 100644
> > > > --- a/drivers/cpuidle/cpuidle.c
> > > > +++ b/drivers/cpuidle/cpuidle.c
> > > > @@ -44,6 +44,12 @@ void disable_cpuidle(void)
> > > >   	off = 1;
> > > >   }
> > > >
> > > > +static bool cpuidle_device_disabled(struct cpuidle_driver *drv,
> > > > +				    struct cpuidle_device *dev)
> > > > +{
> > > > +	return (off || !initialized || !drv || !dev || !dev->enabled);
> > > > +}
> > > 
> > > This is getting a bit fuzzy IMO. What means disabled ? :)
> > 
> > Well, that's just the current checks in cpuidle_select() (that by
> > the way is supposed to return an index) merged together with a function
> > name, to reuse the same checks in cpuidle_enter_freeze().
> > I have no problem leaving the checks as they are at the moment and
> > replicate them in cpuidle_enter_freeze() but given your remark below,
> > we should do something different in there.
> 
> Maybe something like the patch below (untested)?

That's slightly inefficient for things that don't support ->enter_freeze
and, moreover, all negative return values of cpuidle_select() are equivalent,
so I ended up with something similar to the original Lorenzo's patch (on
top of https://patchwork.kernel.org/patch/5885171/ (still untested).

Rafael


---
 drivers/cpuidle/cpuidle.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -44,6 +44,12 @@ void disable_cpuidle(void)
 	off = 1;
 }
 
+static bool cpuidle_not_available(struct cpuidle_driver *drv,
+				  struct cpuidle_device *dev)
+{
+	return off || !initialized || !drv || !dev || !dev->enabled;
+}
+
 /**
  * cpuidle_play_dead - cpu off-lining
  *
@@ -124,6 +130,9 @@ void cpuidle_enter_freeze(void)
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int index;
 
+	if (cpuidle_not_available(drv, dev))
+		goto fallback;
+
 	/*
 	 * Find the deepest state with ->enter_freeze present, which guarantees
 	 * that interrupts won't be enabled when it exits and allows the tick to
@@ -141,11 +150,14 @@ void cpuidle_enter_freeze(void)
 	 * at all and try to enter it normally.
 	 */
 	index = cpuidle_find_deepest_state(drv, dev, false);
-	if (index >= 0)
+	if (index >= 0) {
 		cpuidle_enter(drv, dev, index);
-	else
-		arch_cpu_idle();
+		/* Interrupts are enabled again here. */
+		return;
+	}
 
+ fallback:
+	arch_cpu_idle();
 	/* Interrupts are enabled again here. */
 }
 
@@ -205,12 +217,9 @@ int cpuidle_enter_state(struct cpuidle_d
  */
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	if (off || !initialized)
+	if (cpuidle_not_available(drv, dev))
 		return -ENODEV;
 
-	if (!drv || !dev || !dev->enabled)
-		return -EBUSY;
-
 	return cpuidle_curr_governor->select(drv, dev);
 }
 

