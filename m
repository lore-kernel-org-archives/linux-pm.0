From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] PM: Use pm_wakeup_pending() in
	device_suspend()
Date: Fri, 3 Dec 2010 22:54:55 +0100
Message-ID: <201012032254.55542.rjw__37503.7621045069$1291413417$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1012031024020.1682-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1012031024020.1682-100000@iolanthe.rowland.org>
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

On Friday, December 03, 2010, Alan Stern wrote:
> On Fri, 3 Dec 2010, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Before starting to suspend a device in device_suspend() check if
> > there's a request to abort the power transition and return -EBUSY
> > in that case.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/base/power/main.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > Index: linux-2.6/drivers/base/power/main.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/base/power/main.c
> > +++ linux-2.6/drivers/base/power/main.c
> > @@ -935,6 +935,11 @@ static void async_suspend(void *data, as
> >  
> >  static int device_suspend(struct device *dev)
> >  {
> > +	if (pm_wakeup_pending()) {
> > +		async_error = -EBUSY;
> > +		return async_error;
> > +	}
> > +
> >  	INIT_COMPLETION(dev->power.completion);
> >  
> >  	if (pm_async_enabled && dev->power.async_suspend) {
> 
> Is a similar test needed in async_suspend()?  What happens if 
> dpm_suspend() runs through the entire device list okay, but a wakeup 
> event occurs in the middle of the async_synchronize_full() delay?

The devices will be suspended and the suspend will progress until it's
finally aborted before putting the system into the sleep state.  But I agree
it's better to check pm_wakeup_pending() in async_suspend() too,
so I think we can simply put it into __device_suspend() instead, like in the
patch below.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM: Use pm_wakeup_pending() in __device_suspend()

Before starting to suspend a device in __device_suspend() check if
there's a request to abort the power transition and return -EBUSY
in that case.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -877,6 +877,11 @@ static int __device_suspend(struct devic
 	if (async_error)
 		goto End;
 
+	if (pm_wakeup_pending()) {
+		async_error = -EBUSY;
+		goto End;
+	}
+
 	if (dev->class) {
 		if (dev->class->pm) {
 			pm_dev_dbg(dev, state, "class ");
