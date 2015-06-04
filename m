From: Todd E Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH] PM: check for complete cb before device lock in
 dpm_complete
Date: Thu, 4 Jun 2015 15:08:03 -0700
Message-ID: <20150604220802.GA20494@linux.intel.com>
References: <1432928056-25622-1-git-send-email-todd.e.brandt@linux.intel.com>
 <Pine.LNX.4.44L0.1505291657370.1404-100000@iolanthe.rowland.org>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20168 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594AbbFDWIE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Jun 2015 18:08:04 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1505291657370.1404-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net, todd.e.brandt@intel.com

On Fri, May 29, 2015 at 05:01:20PM -0400, Alan Stern wrote:
> On Fri, 29 May 2015, Todd Brandt wrote:
> 
> > In theory, if a device has no pm_ops complete callback it shouldn't have
> > to be locked in order to skip it in the dpm_complete call. This causes
> > problems when a device without a complete callback has already begun
> > operation after its resume cb is called. It can end up holding up the
> > system resume as the pm subsystem tries to get a device lock just to
> > check for a callback that isn't there.
> > 
> > This fixes an issue discovered on an Ivy Bridge laptop which has an
> > AlpsPS/2 GlidePoint touchpad connected to an i8042 serio bus. The resume
> > path ends up wasting a full second waiting for a device_lock on the psmouse
> > driver, only to then discover that it has no device_complete callback. The
> > alpa driver has already begun sending and receiving data after its resume
> > call was finished, which prevents the pm subsystem from getting the device
> > lock.
> 
> Why not simply move the device_lock() and device_unlock() calls inside
> the "if (callback) {...}" block in device_complete()?
> 
> Are you worried that the presence/absence of a callback might change 
> while the device is unlocked?  But that can happen with your patch too, 
> and there the window is much larger.

Hi Alan, I actually did that for my initial version of the patch but then
reconsidered. I was assuming someone would have an issue with reading
the callback while the device isn't locked. Below is the first version. It
has the exact same effect as the one in the top of the thread. Is this 
something that looks ok to you?

First version of the patch:

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/base/power/main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3d874ec..b6a0e20 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -897,8 +897,6 @@ static void device_complete(struct device *dev, pm_message_t state)
 	if (dev->power.syscore)
 		return;
 
-	device_lock(dev);
-
 	if (dev->pm_domain) {
 		info = "completing power domain ";
 		callback = dev->pm_domain->ops.complete;
@@ -918,12 +916,15 @@ static void device_complete(struct device *dev, pm_message_t state)
 		callback = dev->driver->pm->complete;
 	}
 
-	if (callback) {
-		pm_dev_dbg(dev, state, info);
-		trace_device_pm_callback_start(dev, info, state.event);
-		callback(dev);
-		trace_device_pm_callback_end(dev, 0);
-	}
+	if (!callback)
+		return;
+
+	device_lock(dev);
+
+	pm_dev_dbg(dev, state, info);
+	trace_device_pm_callback_start(dev, info, state.event);
+	callback(dev);
+	trace_device_pm_callback_end(dev, 0);
 
 	device_unlock(dev);
 
-- 
2.1.0

