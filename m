From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/9] pm: domains: avoid potential oops in
 pm_genpd_remove_device()
Date: Fri, 13 Mar 2015 09:20:31 +0000
Message-ID: <20150313092030.GC8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7sq-0003m6-89@rmk-PC.arm.linux.org.uk>
 <CAPDyKFq8P7eceHkPFDnyUwpfjEN_0ao0NDLoxNjE7h4KDBL=qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42480 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbbCMJUs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 05:20:48 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFq8P7eceHkPFDnyUwpfjEN_0ao0NDLoxNjE7h4KDBL=qA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Mar 13, 2015 at 09:56:02AM +0100, Ulf Hansson wrote:
> On 12 March 2015 at 19:31, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > pm_genpd_remove_device() should only be called with valid and present
> > pm domain.  There are circumstances where we may end up with something
> > that isn't a generic PM domain in dev->pm_domain (eg, vga_switcheroo
> > stuff.)
> 
> Could the "vga_switcheroo" code deal with this instead?

How is there any possibility what so ever that vga_switcherroo could
deal with this?

The problem is if something which isn't a generic PM domain is registered
in dev->pm_domain, pm_genpd_remove_device() will treat it as a generic PM
domain, and try and de-reference it as if it were a generic PM domain.

The problem is the generic PM domain code _assuming_ that whatever it
finds in dev->pm_domain is always a generic PM domain.  That is a broken
assumption.

> 
> >
> > Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/base/power/domain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
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

Okay, I'll fix both of those by making it always available and by
taking the appropriate lock, and removing the duplication in
genpd_dev_pm_detach().

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
