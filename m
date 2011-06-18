From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] PM: fix async resume following suspend
	failure
Date: Sat, 18 Jun 2011 22:42:27 +0200
Message-ID: <201106182242.27814.rjw__18140.5823132538$1308429777$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106181521090.32242-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106181521090.32242-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, June 18, 2011, Alan Stern wrote:
> On Sat, 18 Jun 2011, Rafael J. Wysocki wrote:
> 
> > > @@ -596,7 +597,7 @@ void dpm_resume(pm_message_t state)
> > >  
> > >  	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
> > >  		INIT_COMPLETION(dev->power.completion);
> > > -		if (is_async(dev)) {
> > > +		if (is_async(dev) && dev->power.is_suspended) {
> > 
> > If we check dev->power.is_suspended here, we won't complete the
> > device's power.completion, which is necessary if the device is someone's
> > parent.  Moreover, I think we should clear the device's is_prepared
> > flage at this point.
> 
> Yes.  I was trying to avoid starting up unnecessary threads, but 
> clearly that is less important than being correct.
> 
> > > @@ -881,6 +882,7 @@ static int __device_suspend(struct devic
> > >  	}
> > >  
> > >   End:
> > > +	dev->power.is_suspended = !error;
> > >  	device_unlock(dev);
> > >  	complete_all(&dev->power.completion);
> > 
> > This change doesn't seem to be correct too, because error is 0 if
> > async_error is true, but the device won't be suspended in that case
> > too.
> 
> Okay; I should have been more careful.  Thanks for fixing this up.

No problem. :-)

Appended is what I'm going to push to Linus.

Thanks,
Rafael

---
From: Alan Stern <stern@rowland.harvard.edu>
Subject: PM: Fix async resume following suspend failure

The PM core doesn't handle suspend failures correctly when it comes to
asynchronously suspended devices.  These devices are moved onto the
dpm_suspended_list as soon as the corresponding async thread is
started up, and they remain on the list even if they fail to suspend
or the sleep transition is cancelled before they get suspended.  As a
result, when the PM core unwinds the transition, it tries to resume
the devices even though they were never suspended.

This patch (as1474) fixes the problem by adding a new "is_suspended"
flag to dev_pm_info.  Devices are resumed only if the flag is set.

[rjw:
 * Moved the dev->power.is_suspended check into device_resume(),
   because we need to complete dev->power.completion and clear
   dev->power.is_prepared too for devices whose
   dev->power.is_suspended flags are unset.
 * Fixed __device_suspend() to avoid setting dev->power.is_suspended
   if async_error is different from zero.]

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: stable@kernel.org
---
 drivers/base/power/main.c |   14 ++++++++++++--
 include/linux/pm.h        |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -426,6 +426,7 @@ struct dev_pm_info {
 	unsigned int		can_wakeup:1;
 	unsigned int		async_suspend:1;
 	bool			is_prepared:1;	/* Owned by the PM core */
+	bool			is_suspended:1;	/* Ditto */
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;
Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -58,6 +58,7 @@ static int async_error;
 void device_pm_init(struct device *dev)
 {
 	dev->power.is_prepared = false;
+	dev->power.is_suspended = false;
 	init_completion(&dev->power.completion);
 	complete_all(&dev->power.completion);
 	dev->power.wakeup = NULL;
@@ -517,6 +518,9 @@ static int device_resume(struct device *
 	 */
 	dev->power.is_prepared = false;
 
+	if (!dev->power.is_suspended)
+		goto Unlock;
+
 	if (dev->pwr_domain) {
 		pm_dev_dbg(dev, state, "power domain ");
 		error = pm_op(dev, &dev->pwr_domain->ops, state);
@@ -552,6 +556,9 @@ static int device_resume(struct device *
 	}
 
  End:
+	dev->power.is_suspended = false;
+
+ Unlock:
 	device_unlock(dev);
 	complete_all(&dev->power.completion);
 
@@ -839,11 +846,11 @@ static int __device_suspend(struct devic
 	device_lock(dev);
 
 	if (async_error)
-		goto End;
+		goto Unlock;
 
 	if (pm_wakeup_pending()) {
 		async_error = -EBUSY;
-		goto End;
+		goto Unlock;
 	}
 
 	if (dev->pwr_domain) {
@@ -881,6 +888,9 @@ static int __device_suspend(struct devic
 	}
 
  End:
+	dev->power.is_suspended = !error;
+
+ Unlock:
 	device_unlock(dev);
 	complete_all(&dev->power.completion);
 
