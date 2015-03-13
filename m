From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/9] pm: domains: sync runtime PM status with PM domains
 after probe
Date: Fri, 13 Mar 2015 10:14:34 +0000
Message-ID: <20150313101434.GD8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7sv-0003mA-JP@rmk-PC.arm.linux.org.uk>
 <CAPDyKFrcjfLXCjLL8SGJUDz6ErROW=B8oDEg0eRPA92=m-dRQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42587 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbbCMKOv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 06:14:51 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFrcjfLXCjLL8SGJUDz6ErROW=B8oDEg0eRPA92=m-dRQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>

On Fri, Mar 13, 2015 at 10:30:59AM +0100, Ulf Hansson wrote:
> On 12 March 2015 at 19:31, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > Synchronise the PM domain status with runtime PM's status after a
> > platform device has been probed.  This augments the solution in commit
> > 2ed127697eb1 ("PM / Domains: Power on the PM domain right after attach
> > completes").
> >
> > The above commit added a call to power up the PM domain when a device
> > attaches to the domain in order to match the behaviour required by
> > drivers that make no use of runtime PM.  The assumption is that the
> > device driver will cause a runtime PM transition, which will synchronise
> > the PM domain state with the runtime PM state.
> >
> > However, by default, runtime PM will assume that the device is initially
> > suspended, and some drivers may make use of this should they not need to
> > touch the hardware during probe.
> >
> > In order to allow such drivers, trigger the PM domain code to check
> > whether the PM domain can be suspended after the probe function, undoing
> > the effect of the power-on prior to the probe.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/base/platform.c     |  2 ++
> 
> Don't we need this for more buses than the platform bus?

As you very well know, only the platform bus does this automatic binding
of a PM domain based on OF - something that you yourself were involved in
adding (your sign-off is on the patch adding it, so I assume that you
reviewed that patch as thoroughly as you seem to be reviewing mine) which
is the cause of my problems.

> >  drivers/base/power/common.c | 15 +++++++++++++++
> >  drivers/base/power/domain.c | 23 +++++++++++++++++++++++
> >  include/linux/pm.h          |  1 +
> >  include/linux/pm_domain.h   |  4 ++++
> >  5 files changed, 45 insertions(+)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 9421fed40905..552d1affc060 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -512,6 +512,8 @@ static int platform_drv_probe(struct device *_dev)
> >                 ret = drv->probe(dev);
> >                 if (ret)
> >                         dev_pm_domain_detach(_dev, true);
> > +               else
> > +                       dev_pm_domain_sync(_dev);
> >         }
> >
> >         if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
> > diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> > index b0f138806bbc..8c739a14d3c7 100644
> > --- a/drivers/base/power/common.c
> > +++ b/drivers/base/power/common.c
> > @@ -134,3 +134,18 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
> >                 dev->pm_domain->detach(dev, power_off);
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
> > +
> > +/**
> > + * dev_pm_domain_sync - synchronise the PM domain state with its devices
> > + * @dev: device corresponding with domain
> > + *
> > + * Synchronise the PM domain state with the recently probed device, which
> > + * may be in a variety of PM states.  This ensures that a device which
> > + * enables runtime PM in suspended state, and never transitions to active
> > + * in its probe handler is properly suspended after the probe.
> > + */
> > +void dev_pm_domain_sync(struct device *dev)
> > +{
> > +       if (dev->pm_domain && dev->pm_domain->sync)
> > +               dev->pm_domain->sync(dev);
> > +}
> 
> This is more of a taste and flavour comment, regarding the design approach.
> 
> To address the issue which @subject patch does, and together with the
> original problem, which was about making sure a PM domain stays
> powered during probe, that to me seems like a perfect match for a
> get/put API.
> 
> The current solution from commit 2ed127697eb1 ("PM / Domains: Power on
> the PM domain right after attach completes"), is to me just a hacky
> workaround (which obviously wasn't the proper solution) . $subject
> patch follows that approach.
> 
> What do you think of using a get/put approach instead, that would also
> give us nice symmetry of the API. As you know I have patches available
> for this, I am happy to post them if needed.

What I think you're proposing is nothing less than a total rewrite of the
PM domain code.

If that's what it's going to take to get this stuff in, then I'm just not
interested in persuing this anymore, sorry.  I don't have the time and
effort for that - something that people well know when they send me emails
that go unanswered...

I'm just trying to fix the problem which you created - and this is the way
which was discussed and settled upon.  If you _now_ want a different
approach, that's up to _you_ to implement.  Stop wasting my time.

> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 11a1023fa64a..13ae3355dff7 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2157,6 +2157,28 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
> >         genpd_queue_power_off_work(pd);
> >  }
> >
> > +static void genpd_dev_pm_sync(struct device *dev)
> > +{
> > +       struct generic_pm_domain *pd = NULL, *gpd;
> > +
> > +       if (!dev->pm_domain)
> > +               return;
> > +
> > +       mutex_lock(&gpd_list_lock);
> > +       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> > +               if (&gpd->domain == dev->pm_domain) {
> > +                       pd = gpd;
> > +                       break;
> > +               }
> > +       }
> > +       mutex_unlock(&gpd_list_lock);
> 
> Walking through the gpd list seems a bit "heavy". Can't we just expect
> the caller to have a valid generic_pm_domain pointer for its device?

No you can't.  See the second patch in this series.  dev->pm_domain can
contain other stuff which isn't a generic_pm_domain.  generic_pm_domain
is just one instance of a pm_domain implementation.  Others exist.

I would have assumed you would know these details as you have decided to
co-maintain this code, or if not, you'd be prepared to audit the kernel
to find out what might be in dev->pm_domain so that you have due diligence
before commenting on something you clearly know nothing about...

What I find even _more_ unacceptable is that you are question this, but
you didn't question the exact same code which was part of Tomasz Figa's
patch to add the OF-based PM domain code.  On the face of it, this
strikes of double standards - somehow I have to justify my code more
than other people do.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
