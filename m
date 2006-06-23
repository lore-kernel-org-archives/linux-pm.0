From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: cpufreq-related updates [WAS: Fix console handling
	during suspend/resume]
Date: Fri, 23 Jun 2006 18:53:43 -0400
Message-ID: <20060623225343.GA3438@neo.rr.com>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606230926.26604.david-b@pacbell.net>
	<20060623203658.GA4264@neo.rr.com>
	<200606231448.32927.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606231448.32927.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 23, 2006 at 02:48:32PM -0700, David Brownell wrote:
> On Friday 23 June 2006 1:36 pm, Adam Belay wrote:
> > On Fri, Jun 23, 2006 at 09:26:26AM -0700, David Brownell wrote:
> > > On Thursday 22 June 2006 4:31 pm, Benjamin Herrenschmidt wrote:
> > > >  - cpufreq (this is a design bug with cpufreq with the "core/midlay=
er"
> > > > trying to get in charge instead of the driers and registering a sys=
dev
> > > > which is very wrong).
> > > =

> > > That could stand some elaboration in a separate thread; there are folk
>                                       ^^^^^^^^^^^^^^^^^^^^
> Notice changed $SUBJECT ...

Thanks :)

> =

> > > working to enhance cpufreq so that it handles other frequency/voltage
> > > scaling approaches.  I happened to notice that cpufreq isn't even usi=
ng
> > > the driver model very well, too ...
> > =

> > On a related note, let's remember that cpufreq needs a sort of "FREEZE"
> > functionality, on some platforms, before transitioning the cpu operating
> > point. =

> =

> Actually I don't think FREEZE is the right model there, especially
> considering the cases where other clocks are coupled to the CPU clock
> and therby need to be adjusted.
> =

> One potential model is that resume() should verify clock settings and
> adjust things as needed (e.g. MMC, USART, or SPI dividers), and that
> suspend() should be invoked for the devices that need re-clocking.
> Linux knows the devices affected by a clk_set_rate(), since clk_get()
> takes the device as a parameter.
> =

> As an example, on at91 hardware cpufreq can easily change the cpu
> clock using /1, /2, and /4 dividers and not change the I/O clocks.
> But other frequency changes involve updating PLL settings and then
> reclocking at least the peripherals mentioned above.

I was specifically referring to this issue:

http://lkml.org/lkml/2005/4/25/228

It would appear that DMA has to be stopped and drivers have to be quiesced
during a cpufreq transition in some cases.

But, yes, there are certainly other cpufreq concerns as well.

> =

> =

> > Moreover, we need similar stuff for PCI resource rebalancing =

> > (although this case would be partial tree suspending), a feature that
> > will likely become very necessary in the near future.
> =

> How about elaborating on what you mean by that?

Sure.  The basic idea is to pause device driver operation, disable the
device, reprogram the resource bars, and then resume driver operation.  It's
most useful for the PCI hotplug case, where a bridge window might not be
large enough to provide for a newly added device.  In such a case, the PCI
bridge and every device attached to it would have to be suspended in one way
or another before the resources could be adjusted.

Thanks,
Adam
