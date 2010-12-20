From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Mon, 20 Dec 2010 22:13:53 +0100
Message-ID: <201012202213.53902.rjw__37411.551786545$1292879709$gmane$org@sisk.pl>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201012181559.50347.rjw@sisk.pl>
	<20101220150051.GI26706@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101220150051.GI26706@rakim.wolfsonmicro.main>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, December 20, 2010, Mark Brown wrote:
> On Sat, Dec 18, 2010 at 03:59:50PM +0100, Rafael J. Wysocki wrote:
> 
> > Second, the situation at hand is that the bus type implements dev_pm_ops,
> > but the driver doesn't.  Now, pm_generic_suspend() is called with a struct
> > device pointer, so it would have to go back to dev->bus, find the
> > ->legacy_suspend() callback (as opposed to ->suspend(), which also is legacy,
> > but is called by the PM core instead).  May I call that confusing?
> 
> Well, the trouble is that the whole situation is already pretty
> confusing for what should be very simple buses, each one needs to write
> a bunch of not really bus specific code in order to get basic behaviour
> which allows the drivers to make use of runtime PM, requiring more
> thought and care per bus than I'd expect given that they've nothing
> really to contribute.  This leads to the sort of random variations
> between buses that Rabin is reporting, and means that updates keep
> having to get done in multiple different places.
> 
> The overall effect is that from the point of view of trying to use
> runtime PM in drivers which work with these simple buses everything
> feels like it's much harder work than it should be.  Moving all the
> decision making out of the buses and into the PM core seems like a win
> here.

Well, the _solution_ is to get rid of the legacy stuff from those buses in the
first place.  Then, they'll just need to use the generic ops without any
trouble.

What you're proposing is a workaround that people will use as an excuse for
not doing the right thing forever.

Thanks,
Rafael
