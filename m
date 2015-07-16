From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/3] PM / sleep: Go direct_complete if driver has no callbacks
Date: Thu, 16 Jul 2015 02:41:34 +0200
Message-ID: <6740752.elSTxeiQAg@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1507151444460.18896-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51908 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752605AbbGPAO5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 20:14:57 -0400
In-Reply-To: <Pine.LNX.4.44L0.1507151444460.18896-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>

On Wednesday, July 15, 2015 02:47:50 PM Alan Stern wrote:
> On Wed, 15 Jul 2015, Tomeu Vizoso wrote:
> 
> > If a suitable prepare callback cannot be found for a given device and
> > its driver has no PM callbacks at all, assume that it can go direct to
> > complete when the system goes to sleep.
> > 
> > The reason for this is that there's lots of devices in a system that do
> > no PM at all and there's no reason for them to prevent their ancestors
> > to do direct_complete if they can support it.
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > ---
> > 
> >  drivers/base/power/main.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 1710c26ba097..edda3f233c7c 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1540,6 +1540,21 @@ int dpm_suspend(pm_message_t state)
> >  	return error;
> >  }
> >  
> > +static bool driver_has_no_pm_callbacks(struct device_driver *drv)
> > +{
> > +	if (!drv->pm)
> > +		return true;
> > +
> > +	return !drv->pm->prepare &&
> > +	       !drv->pm->suspend &&
> > +	       !drv->pm->suspend_late &&
> > +	       !drv->pm->suspend_noirq &&
> > +	       !drv->pm->resume_noirq &&
> > +	       !drv->pm->resume_early &&
> > +	       !drv->pm->resume &&
> > +	       !drv->pm->complete;
> > +}
> 
> This isn't exactly what I meant.  We also need to check the dev_pm_ops 
> fields in dev->pm_domain, dev->type, dev->class, and dev->bus.  Only if 
> _all_ of these callbacks are missing should we use direct_complete.

Also checking that on every suspend is kind of wasteful, because those things
do not change very often.

Thanks,
Rafael

