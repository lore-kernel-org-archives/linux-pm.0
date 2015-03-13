From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/9] pm: domains: avoid potential oops in
 pm_genpd_remove_device()
Date: Fri, 13 Mar 2015 16:58:32 +0000
Message-ID: <20150313165832.GW8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7sq-0003m6-89@rmk-PC.arm.linux.org.uk>
 <7h1tksx3g5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:43635 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299AbbCMQ6u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 12:58:50 -0400
Content-Disposition: inline
In-Reply-To: <7h1tksx3g5.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

On Fri, Mar 13, 2015 at 09:33:14AM -0700, Kevin Hilman wrote:
> Russell King <rmk+kernel@arm.linux.org.uk> writes:
> 
> > pm_genpd_remove_device() should only be called with valid and present
> > pm domain.  
> 
> Terminology nit: the patch adds a check for a valid an present genpd,
> not pm domain (which I think of as dev->pm_domain.)

Right, people are sloppy with terminology, it's my turn to be equally
sloppy :)  I'll fix it eventually (but I've just sent the next round of
patches.)  Can you re-comment on the new set so it doesn't get lost
please?  I'm not about to immediately go through another update round for
such a trivial change (which alone takes about 5 minutes due to the
number of branches and patches on top of this stuff).

> > There are circumstances where we may end up with something
> > that isn't a generic PM domain in dev->pm_domain (eg, vga_switcheroo
> > stuff.)
> 
> Wouldn't that particular case be caught by this check in pm_genpd_remove_device():
> 
>         || pd_to_genpd(dev->pm_domain) != genpd

Well, let's look at what pd_to_genpd() does:

static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
{
        return container_of(pd, struct generic_pm_domain, domain);
}

Now, both pd_to_genpd() and dev_to_genpd() are available for use outside
of the genpd code.  What that means is that other code _can_ decide to
do this (and indeed I do have code which does this):

        struct generic_pm_domain *genpd = dev_to_genpd(dev);

        while (1) {
                if (pm_genpd_remove_device(genpd, dev) != -EAGAIN)
                        break;
                cond_resched();
        }

Now, as there is no way for anything outside of genpd to know whether the
return value from this is a real genpd structure or not - and
pm_genpd_remove_device() tries hard to validate the genpd passed in - but
not sufficiently to catch bad cases where dev->pm_domain is not attached
to a genpd.

What I'm doing is ensuring that the weak-but-looking-like-belt-and-braces
test in pm_genpd_remove_device() is actually sufficiently strong to catch
bad uses which may otherwise result in subtle out-of-bounds corruption or
list corruption.

Now, the alternative solution would be to have pm_genpd_lookup_name()
exported from the genpd code, so I can actually look up the genpd which
is _supposed_ to be registered against the device and use that instead.
However, that's potentially dangerous because there is no refcounting
against genpds obtained in this way.

So I decided better validation was the lesser of the evils.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
