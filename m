From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] PM: check for complete cb before device lock in dpm_complete
Date: Mon, 30 Nov 2015 03:15:03 +0100
Message-ID: <1815101.hkTcZ3M1YO@vostro.rjw.lan>
References: <6146fb8483239461040674927df2e71d4555c59e.1445035227.git.todd.e.brandt@linux.intel.com> <CAJZ5v0gqUFWfUHRR3Y7t2bnrQjam3m_CHC0aHOSbJNLJZ5ctbQ@mail.gmail.com> <CAKdAkRQ3nUtOFfxKBembnzZZi-Kq1N0hRon39AY8XkTy7i4Ftw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60727 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752698AbbK3BpQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Nov 2015 20:45:16 -0500
In-Reply-To: <CAKdAkRQ3nUtOFfxKBembnzZZi-Kq1N0hRon39AY8XkTy7i4Ftw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Todd Brandt <todd.e.brandt@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, todd.e.brandt@intel.com

On Saturday, November 28, 2015 09:33:20 PM Dmitry Torokhov wrote:
> On Fri, Oct 16, 2015 at 3:49 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > Hi,
> >
> > On Sat, Oct 17, 2015 at 12:45 AM, Todd Brandt
> > <todd.e.brandt@linux.intel.com> wrote:
> >> If a device has no pm_ops complete callback it shouldn't have
> >> to be locked in order to skip it in the dpm_complete call. This causes
> >> problems when a device without a complete callback has already begun
> >> operation after its resume cb is called. It can end up holding up the
> >> system resume as the pm subsystem tries to get a device lock just to
> >> check for a callback that isn't there.
> >>
> >> This is basically the original v1 patch but updated for the latest kernel.
> >>
> >> Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> >> ---
> >>  drivers/base/power/main.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> >> index 1710c26..9bb8ff0 100644
> >> --- a/drivers/base/power/main.c
> >> +++ b/drivers/base/power/main.c
> >> @@ -899,8 +899,6 @@ static void device_complete(struct device *dev, pm_message_t state)
> >>         if (dev->power.syscore)
> >>                 return;
> >>
> >> -       device_lock(dev);
> >> -
> >>         if (dev->pm_domain) {
> >>                 info = "completing power domain ";
> >>                 callback = dev->pm_domain->ops.complete;
> >> @@ -920,13 +918,15 @@ static void device_complete(struct device *dev, pm_message_t state)
> >>                 callback = dev->driver->pm->complete;
> >>         }
> >>
> >> -       if (callback) {
> >> -               pm_dev_dbg(dev, state, info);
> >> -               callback(dev);
> >> -       }
> >> +       if (!callback)
> >> +               goto Complete;
> >>
> >
> > Suppose that the devices is unregistered at this point and callback
> > was pointing to the driver callback.
> >
> >> +       device_lock(dev);
> >> +       pm_dev_dbg(dev, state, info);
> >> +       callback(dev);
> >
> > I don't think it is correct to execute that callback here in that case, is it?
> 
> Continuing this line of thought: what if driver was unbound and
> rebound again before we got to executing device_complete()? In that
> case we should not be calling ->complete() even if it is present,
> since it is as if prepare() was not called, and there is nothing for
> ->complete() to undo.
> 
> It seems to me we should not be allowing bind/unbind transitions here.

Probes will be avoided after this patch:

https://patchwork.kernel.org/patch/7589121/

which I'm going to queue up for 4.5.

I'm not sure about unbinds, though.  Some parts of the kernel seem to want
to be able to remove devices during system suspend/resume.

Thanks,
Rafael

