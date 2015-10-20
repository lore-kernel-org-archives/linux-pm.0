From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Tue, 20 Oct 2015 03:22:55 -0700
Message-ID: <20151020102255.20687.72485@quantum>
References: <5706174.BUsqiXljxZ@wuerfel> <20151007125735.GA8170@kroah.com>
 <20151007130324.GA4557@linux> <5308760.2G5KJFF9Pi@wuerfel>
 <20151008074828.GF4570@linux> <20151019154009.20687.41178@quantum>
 <20151019155310.GO32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151019155310.GO32532@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dtor@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Russell King - ARM Linux (2015-10-19 08:53:11)
> On Mon, Oct 19, 2015 at 08:40:09AM -0700, Michael Turquette wrote:
> > Quoting Viresh Kumar (2015-10-08 00:48:28)
> > > On 07-10-15, 21:12, Arnd Bergmann wrote:
> > > > I think it clearly makes sense to have a fixed length for each of these
> > > > members:
> > > >
> > > > either 32 bit is enough to represent all possible values, then
> > > > there is no need to make them 'long' on 64-bit architectures, or 32 bit
> > > > is not enough and then the code is broken on 32-bit architectures today
> > > > and should be fixed.
> > > 
> > > I agree.
> > > 
> > > But I am not 100% sure why it was done this way to start with.
> > > Probably this is the logic behind that:
> > > - Max clock rate supported by a u32 is ~ 4.295 GHz
> 
> The limit is actually half that when you consider clk_round_rate()
> returns a long, because clk_round_rate() needs to be able to return
> errors.
> 
> The use of long and unsigned long was done in the knowledge that it'd
> restrict to 2GHz the upper limit, partially because 64-bit math on
> 32-bit systems is inefficient and expensive, and I initially wanted
> people to use the thing, so it had to be lean and fast.  (If I'd
> started out with something as complex as the CCF, it would've been
> laughed out as being "far too complex" and "we don't need this").
> 
> It also started out as a way to convey clock information to drivers
> for peripherals, which commonly don't need clocks up in the GHz range,
> indeed, it was rare at that time the API was designed for peripheral
> clocks to be much above 100MHz.

And this is still very true today. We've had a few instances where
platforms hit the 2GHz limit on a PLL feeding a divider to a CPU, but
the current state of things is working for the common case.

The big question is whether to change it in anticipation of higher clock
rates (somebody has to drive those THz transceivers and photonic
interconnects!) or just wait until enough people start screaming.

Regards,
Mike

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
