From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/9] pm: domains: avoid potential oops in
 pm_genpd_remove_device()
Date: Fri, 13 Mar 2015 13:23:15 +0000
Message-ID: <20150313132315.GK8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7sq-0003m6-89@rmk-PC.arm.linux.org.uk>
 <CAPDyKFq8P7eceHkPFDnyUwpfjEN_0ao0NDLoxNjE7h4KDBL=qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42987 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbbCMNXb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 09:23:31 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFq8P7eceHkPFDnyUwpfjEN_0ao0NDLoxNjE7h4KDBL=qA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Mar 13, 2015 at 09:56:02AM +0100, Ulf Hansson wrote:
> On 12 March 2015 at 19:31, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index b3fbc21da2dc..11a1023fa64a 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1509,7 +1509,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
> >
> >         dev_dbg(dev, "%s()\n", __func__);
> >
> > -       if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev)
> > +       if (!pm_genpd_present(genpd) || IS_ERR_OR_NULL(dev)
> 
> The are two issues with this approach.
> 
> 1. pm_genpd_present() is build only for CONFIG_PM_SLEEP set.
> 2. pm_genpd_present() totally ignores holding the mutex which protects
> the list of GPDs.

Well, having looked more deeply at this, the PM domain code has more
problems.

void pm_genpd_syscore_poweroff(struct device *dev)
{
        genpd_syscore_switch(dev, true);
}
EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweroff);

void pm_genpd_syscore_poweron(struct device *dev)
{
        genpd_syscore_switch(dev, false);
}
EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);

both of these functions are externally callable without holding the
gpd_list_lock mutex, which results in:

static void genpd_syscore_switch(struct device *dev, bool suspend)
{
        struct generic_pm_domain *genpd;

        genpd = dev_to_genpd(dev);
        if (!pm_genpd_present(genpd))
                return;

calling this function without holding the gpd_list_lock either.

It also seems that there's a variety of ways which the generic PM domain
code gets from a struct device to a generic_pm_domain - one is the above.
Another is having this open coded:

        mutex_lock(&gpd_list_lock);
        list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
                if (&gpd->domain == dev->pm_domain) {
                        pd = gpd;
                        break;
                }
        }
        mutex_unlock(&gpd_list_lock);

This is only _not_ buggy because we only ever add to the list, never
remove from it, so we can be sure that a successfully obtained "pd"
will remain valid after the lock is dropped.

Another is:

        genpd = dev_to_genpd(dev);
        if (IS_ERR(genpd))
		...

when we're sure that dev->pm_domain points at a generic PM domain (in
the various runtime PM functions.)  It should be also noted that
dev_to_genpd() is exported to the whole kernel - is that safe?

In any case, I think dev_to_genpd() at least needs some commentry before
it saying that it is only for use when we know for certain that the
device has a generic_pm_domain attached, or the PM domain power is NULL
or an error pointer.

This is turning out to be a right can of worms...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
