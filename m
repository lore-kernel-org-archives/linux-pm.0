From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/9] pm: domains: avoid potential oops in pm_genpd_remove_device()
Date: Sat, 14 Mar 2015 02:27:47 +0100
Message-ID: <6087624.WOzBPsVyeT@vostro.rjw.lan>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk> <20150313092030.GC8656@n2100.arm.linux.org.uk> <CAMuHMdWmVLPqKs2ZyLjZ2DA2UAjhqzrr1LEtsW2CRYSTh+uoeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60890 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750818AbbCNBEA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 21:04:00 -0400
In-Reply-To: <CAMuHMdWmVLPqKs2ZyLjZ2DA2UAjhqzrr1LEtsW2CRYSTh+uoeQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Friday, March 13, 2015 01:45:52 PM Geert Uytterhoeven wrote:
> On Fri, Mar 13, 2015 at 10:20 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Mar 13, 2015 at 09:56:02AM +0100, Ulf Hansson wrote:
> >> On 12 March 2015 at 19:31, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> >> > pm_genpd_remove_device() should only be called with valid and present
> >> > pm domain.  There are circumstances where we may end up with something
> >> > that isn't a generic PM domain in dev->pm_domain (eg, vga_switcheroo
> >> > stuff.)
> >>
> >> Could the "vga_switcheroo" code deal with this instead?
> >
> > How is there any possibility what so ever that vga_switcherroo could
> > deal with this?
> >
> > The problem is if something which isn't a generic PM domain is registered
> > in dev->pm_domain, pm_genpd_remove_device() will treat it as a generic PM
> > domain, and try and de-reference it as if it were a generic PM domain.
> >
> > The problem is the generic PM domain code _assuming_ that whatever it
> > finds in dev->pm_domain is always a generic PM domain.  That is a broken
> > assumption.
> 
> Indeed, currently it's not possible to know which derivative of dev_pm_domain
> is used. For genpd, you have to look it up in the genpd list.
> This also complicates adding debug code.
> In addition, it can be statically or dynamically allocated. Hence sometimes %ps
> can tell you the type, sometimes it can't.
> 
> Should we add a type field to struct dev_pm_domain?

Then we'd have to keep track of all dev_pm_domain derivatives somehow and I'd
prefer to avoid that if possible.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
