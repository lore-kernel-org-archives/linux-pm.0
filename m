From: David Brownell <david-b@pacbell.net>
Subject: Re: cpufreq-related updates [WAS: Fix console handling
	during	suspend/resume]
Date: Fri, 23 Jun 2006 14:48:32 -0700
Message-ID: <200606231448.32927.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606230926.26604.david-b@pacbell.net>
	<20060623203658.GA4264@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060623203658.GA4264@neo.rr.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 23 June 2006 1:36 pm, Adam Belay wrote:
> On Fri, Jun 23, 2006 at 09:26:26AM -0700, David Brownell wrote:
> > On Thursday 22 June 2006 4:31 pm, Benjamin Herrenschmidt wrote:
> > >  - cpufreq (this is a design bug with cpufreq with the "core/midlayer"
> > > trying to get in charge instead of the driers and registering a sysdev
> > > which is very wrong).
> > =

> > That could stand some elaboration in a separate thread; there are folk
                                      ^^^^^^^^^^^^^^^^^^^^
Notice changed $SUBJECT ...

> > working to enhance cpufreq so that it handles other frequency/voltage
> > scaling approaches.  I happened to notice that cpufreq isn't even using
> > the driver model very well, too ...
> =

> On a related note, let's remember that cpufreq needs a sort of "FREEZE"
> functionality, on some platforms, before transitioning the cpu operating
> point. =


Actually I don't think FREEZE is the right model there, especially
considering the cases where other clocks are coupled to the CPU clock
and therby need to be adjusted.

One potential model is that resume() should verify clock settings and
adjust things as needed (e.g. MMC, USART, or SPI dividers), and that
suspend() should be invoked for the devices that need re-clocking.
Linux knows the devices affected by a clk_set_rate(), since clk_get()
takes the device as a parameter.

As an example, on at91 hardware cpufreq can easily change the cpu
clock using /1, /2, and /4 dividers and not change the I/O clocks.
But other frequency changes involve updating PLL settings and then
reclocking at least the peripherals mentioned above.


> Moreover, we need similar stuff for PCI resource rebalancing =

> (although this case would be partial tree suspending), a feature that
> will likely become very necessary in the near future.

How about elaborating on what you mean by that?


> It would be nice =

> if the suspend model was robust enough to handle these runtime device
> suspend cases as well.

Yes.

- Dave
