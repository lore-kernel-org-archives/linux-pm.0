From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Powering down unused PM domains (was: Re: [PATCH 0/4] PM /
 Domains: Fix race conditions during boot)
Date: Fri, 10 Oct 2014 10:55:29 +0200
Message-ID: <20141010085529.GA27342@amd>
References: <CAMuHMdUwbOEfLcu_UVKq_iHx5Qzn7ne1+cwt58C0ntTZBf1esg@mail.gmail.com>
 <CAPDyKFrJ7x-MS79OqxPOUWVearpp6AQP160+9QXnhVXWnH9aWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrJ7x-MS79OqxPOUWVearpp6AQP160+9QXnhVXWnH9aWw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > While operation A2 is PM domain-centric (it walks the list of genpd domains),
> > A3 and B3 are device-centric (A3 operates on one specific device, B3 walks the
> > list of devices).
> > Hence B3 never touches PM domains that don't contain any devices[*].
> > So these PM domains are kept powered-up if CONFIG_PM_RUNTIME=n, even on
> > system suspend.
> >
> > Shouldn't PM domains without devices be powered down at some point?
> > When? In B2, or in B3?
> 
> I agree with Rafael and Sylwester, that it would be an advantage if PM
> domains can be initialized in powered off state. Simply because, those
> may then be left in powered off state all the time, if they are
> unused.

Also... powering up all the domains at the same time is quite harsh at
the battery. Even if they are powered down "soon", it still causes
spike in current which may trip the battery (especially when battery
is old and nearly discharged).

> > P.S. Will any of you be at ELC-E next week, for further PM domain discussions?
> 
> That would have been great, but I won't be there. Unless I schedule a
> last minute trip. :-)

I should be there.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
