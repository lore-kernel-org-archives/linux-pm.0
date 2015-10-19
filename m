From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Mon, 19 Oct 2015 16:53:11 +0100
Message-ID: <20151019155310.GO32532@n2100.arm.linux.org.uk>
References: <5706174.BUsqiXljxZ@wuerfel>
 <20151007125735.GA8170@kroah.com>
 <20151007130324.GA4557@linux>
 <5308760.2G5KJFF9Pi@wuerfel>
 <20151008074828.GF4570@linux>
 <20151019154009.20687.41178@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:48174 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbbJSPxc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2015 11:53:32 -0400
Content-Disposition: inline
In-Reply-To: <20151019154009.20687.41178@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dtor@chromium.org>, linux-arm-kernel@lists.infradead.org

On Mon, Oct 19, 2015 at 08:40:09AM -0700, Michael Turquette wrote:
> Quoting Viresh Kumar (2015-10-08 00:48:28)
> > On 07-10-15, 21:12, Arnd Bergmann wrote:
> > > I think it clearly makes sense to have a fixed length for each of these
> > > members:
> > >
> > > either 32 bit is enough to represent all possible values, then
> > > there is no need to make them 'long' on 64-bit architectures, or 32 bit
> > > is not enough and then the code is broken on 32-bit architectures today
> > > and should be fixed.
> > 
> > I agree.
> > 
> > But I am not 100% sure why it was done this way to start with.
> > Probably this is the logic behind that:
> > - Max clock rate supported by a u32 is ~ 4.295 GHz

The limit is actually half that when you consider clk_round_rate()
returns a long, because clk_round_rate() needs to be able to return
errors.

The use of long and unsigned long was done in the knowledge that it'd
restrict to 2GHz the upper limit, partially because 64-bit math on
32-bit systems is inefficient and expensive, and I initially wanted
people to use the thing, so it had to be lean and fast.  (If I'd
started out with something as complex as the CCF, it would've been
laughed out as being "far too complex" and "we don't need this").

It also started out as a way to convey clock information to drivers
for peripherals, which commonly don't need clocks up in the GHz range,
indeed, it was rare at that time the API was designed for peripheral
clocks to be much above 100MHz.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
