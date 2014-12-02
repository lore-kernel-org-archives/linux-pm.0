From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RFC] PM / Runtime: Better support for nested irq_safe drivers
Date: Wed, 03 Dec 2014 00:11:40 +0100
Message-ID: <3160452.2AXUHE51NB@vostro.rjw.lan>
References: <1417551543-15009-1-git-send-email-jsarha@ti.com> <2710424.RMSWoOIU7o@vostro.rjw.lan> <547E332D.3060405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64466 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933086AbaLBWuQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 17:50:16 -0500
In-Reply-To: <547E332D.3060405@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-pm@vger.kernel.org, pavel@ucw.cz, t-kristo@ti.com, tomi.valkeinen@ti.com

On Tuesday, December 02, 2014 11:46:21 PM Jyri Sarha wrote:
> On 12/02/2014 11:54 PM, Rafael J. Wysocki wrote:
> > On Tuesday, December 02, 2014 10:19:03 PM Jyri Sarha wrote:
> >> Do not lock parent of irq safe device to enabled state if the parent
> >> is also irq safe.
> >>
> >> Before this patch the pm_runtime_irq_safe() always called
> >> pm_runtime_get_sync() for the parent, locking the parent to enabled
> >> state and for sure making any parent irq_safe. This is hardly optimal
> >> if the parent device PM code is also irq_safe.
> >>
> >> After this patch the PM runtime core synchronously enables any
> >> irq_safe parents of an irq_safe device when pm_runtime_get_sync() is
> >> called. The parents are checked asyncronously after pm_runtime_put()
> >> call.
> >>
> >> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> >> ---
> >>   drivers/base/power/runtime.c |   11 ++++++-----
> >>   1 file changed, 6 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> >> index 67c7938..800ca1e 100644
> >> --- a/drivers/base/power/runtime.c
> >> +++ b/drivers/base/power/runtime.c
> >> @@ -541,7 +541,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> >>   	}
> >>
> >>   	/* Maybe the parent is now able to suspend. */
> >> -	if (parent && !parent->power.ignore_children && !dev->power.irq_safe) {
> >> +	if (parent && !parent->power.ignore_children &&
> >> +	    (!dev->power.irq_safe || parent->power.irq_safe)) {
> >>   		spin_unlock(&dev->power.lock);
> >>
> >>   		spin_lock(&parent->power.lock);
> >> @@ -706,7 +707,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
> >>   		 * parent is permanently resumed.
> >>   		 */
> >>   		parent = dev->parent;
> >> -		if (dev->power.irq_safe)
> >> +		if (dev->power.irq_safe && !parent->power.irq_safe)
> >
> > Of course, you haven't read the comment above these two lines, because
> > otherwise you wouldn't have submitted this patch at all.
> >
> > I'm not applying it.
> 
> Is there something seriously wrong with the code part too? Or is this 
> just a matter of updating the comment (sorry that I missed that)?

First, this isn't the only comment you've missed.

Second, what if the parent sets its irq_safe after the child does?

> If the thing I am doing somehow fundamentally flawed, I 	apologize. 
> However, this was an RFC patch after all and the problem I am trying to 
> solve is real.

Well, the whole irq_safe concept if somewhat rough and fragile (for example,
it doesn't play well with bus type callbacks that may sleep) and I'm not
sure if making it more fragile is a good idea.

Rafael

