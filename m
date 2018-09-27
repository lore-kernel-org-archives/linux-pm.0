From: Douglas Anderson <dianders@chromium.org>
Subject: [RFC PATCH] PM / core: skip suspend next time if resume returns an error
Date: Thu, 27 Sep 2018 13:35:23 -0700
Message-ID: <20180927203523.60856-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Dilip Kota <dkota@codeaurora.org>, dtor@chromium.org, swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

In general Linux doesn't behave super great if you get an error while
executing a device's resume handler.  Nothing will come along later
and and try again to resume the device (and all devices that depend on
it), so pretty much you're left with a non-functioning device and
that's not good.

However, even though you'll end up with a non-functioning device we
still don't consider resume failures to be fatal to the system.  We'll
keep chugging along and just hope that the device that failed to
resume wasn't too critical.  This establishes the precedent that we
should at least try our best not to fully bork the system after a
resume failure.

I will argue that the best way to keep the system in the best shape is
to assume that if a resume callback failed that it did as close to
no-op as possible.  Because of this we should consider the device
still suspended and shouldn't try to suspend the device again next
time around.  Today that's not what happens.  AKA if you have a device
that fails resume every other time then you'll see these calls:
1. suspend
2. resume (no error)
3. suspend
4. resume (fails!)
5. suspend
6. resume (no error)

I believe that a more correct thing to do is to remove step #5 from
the above.  To understand why, let's imagine a hypothetical device.
In such a device let's say we have a regulator and clock to turn off.

We'll say:
  hypothetical_suspend(...) {
    ret = regulator_disable(...);
    if (ret)
      return ret;
    ret = clk_disable(...);
    if (ret)
      regulator_enable(...);
    return ret;

  hypothetical_resume(...) {
    ret = clk_enable(...);
    if (ret)
      return ret;
    ret = regulator_enable(...);
    if (ret)
      clk_disable(...);
    return ret;

Let's imagine that the regulator_enable() at resume fails sometimes.
You'll see that on the next call to hypothetical_suspend() we'll try
to disable a regulator that was never enabled.

...but if we change things to skip the next suspend callback then
actually we might get the device functioning again after another
suspend/resume cycle (especially if the resume failure was
intermittent for some reason).

Obviously this patch is pretty simplistic and certainly doesn't fix
the world, but perhaps it moves us in the right direction?

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/power/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3f68e2919dc5..27c7d1f76cee 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -999,7 +999,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 
  End:
 	error = dpm_run_callback(callback, dev, state, info);
-	dev->power.is_suspended = false;
+	dev->power.is_suspended = error;
 
  Unlock:
 	device_unlock(dev);
@@ -1750,6 +1750,9 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 
+	if (dev->power.is_suspended)
+		goto End;
+
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
-- 
2.19.0.605.g01d371f741-goog
