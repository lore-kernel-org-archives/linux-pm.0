From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] drivers: cpuidle: add driver/device checks in cpuidle_enter_freeze()
Date: Thu, 26 Feb 2015 00:50:58 +0100
Message-ID: <2987982.3bDckoN2hb@vostro.rjw.lan>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com> <54EDDC99.40208@linaro.org> <20150225144737.GD20214@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150225144737.GD20214@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, February 25, 2015 02:47:37 PM Lorenzo Pieralisi wrote:
> On Wed, Feb 25, 2015 at 02:30:49PM +0000, Daniel Lezcano wrote:
> > On 02/24/2015 06:58 PM, Lorenzo Pieralisi wrote:
> > > The changes in commit:
> > >
> > > 381063133246 ("PM / sleep: Re-implement suspend-to-idle handling")
> > >
> > > let suspend-to-idle code bypass the cpuidle_select() function to
> > > enter the deepest idle state. The sanity checks carried out in
> > > cpuidle_select() are bypassed too and this can cause breakage
> > > on systems that try to suspend-to-idle with no registered cpuidle
> > > driver.
> > >
> > > This patch factors out a function cpuidle_device_disabled() that
> > > is used to carry out sanity checks (ie CPUidle is disabled on the
> > > cpu executing the code) in both cpuidle_select() and cpuidle_enter_freeze()
> > > so that the checks are unified and carried out in both control paths.
> > >
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > ---
> > >   drivers/cpuidle/cpuidle.c | 18 +++++++++++++-----
> > >   1 file changed, 13 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > > index f47edc6c..344fe6c 100644
> > > --- a/drivers/cpuidle/cpuidle.c
> > > +++ b/drivers/cpuidle/cpuidle.c
> > > @@ -44,6 +44,12 @@ void disable_cpuidle(void)
> > >   	off = 1;
> > >   }
> > >
> > > +static bool cpuidle_device_disabled(struct cpuidle_driver *drv,
> > > +				    struct cpuidle_device *dev)
> > > +{
> > > +	return (off || !initialized || !drv || !dev || !dev->enabled);
> > > +}
> > 
> > This is getting a bit fuzzy IMO. What means disabled ? :)
> 
> Well, that's just the current checks in cpuidle_select() (that by
> the way is supposed to return an index) merged together with a function
> name, to reuse the same checks in cpuidle_enter_freeze().
> I have no problem leaving the checks as they are at the moment and
> replicate them in cpuidle_enter_freeze() but given your remark below,
> we should do something different in there.

Maybe something like the patch below (untested)?

Rafael


---
 drivers/cpuidle/cpuidle.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -44,6 +44,18 @@ void disable_cpuidle(void)
 	off = 1;
 }
 
+int cpuidle_check_availability(struct cpuidle_driver *drv,
+			       struct cpuidle_device *dev)
+{
+	if (off || !initialized)
+		return -ENODEV;
+
+	if (!drv || !dev || !dev->enabled)
+		return -EBUSY;
+
+	return 0;
+}
+
 /**
  * cpuidle_play_dead - cpu off-lining
  *
@@ -76,8 +88,13 @@ static int cpuidle_find_deepest_state(st
 				      struct cpuidle_device *dev, bool freeze)
 {
 	unsigned int latency_req = 0;
-	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
+	int i, ret;
+
+	ret = cpuidle_check_availability(drv, dev);
+	if (ret)
+		return ret;
 
+	ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
 	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
@@ -205,13 +222,8 @@ int cpuidle_enter_state(struct cpuidle_d
  */
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	if (off || !initialized)
-		return -ENODEV;
-
-	if (!drv || !dev || !dev->enabled)
-		return -EBUSY;
-
-	return cpuidle_curr_governor->select(drv, dev);
+	int ret = cpuidle_check_availability(drv, dev);
+	return ret ? ret : cpuidle_curr_governor->select(drv, dev);
 }
 
 /**
