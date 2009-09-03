From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Montreal Linux Power Management Mini-Summit, July	13,
	2009 -  Meeting Notes
Date: Thu, 3 Sep 2009 18:12:13 +0100
Message-ID: <20090903171213.GB9507@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.0905211430220.4390@localhost.localdomain>
	<alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
	<63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
	<4A9E2EA7.8080700@st.com>
	<20090902215832.GB21292@n2100.arm.linux.org.uk>
	<4A9FD7C7.7070301@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A9FD7C7.7070301@st.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Francesco VIRLINZI <francesco.virlinzi@st.com>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Linux Power Management List <linux-pm@lists.osdl.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 03, 2009 at 04:50:47PM +0200, Francesco VIRLINZI wrote:
> Hi Russel
> Sorry I don't know the clkdev API.
> In any case the CF, I will present, tracks the relationship between
>  device and clock.
> During any clock changing the CF checks if all the device agree the new rate
>  before the clock is changed.
>
> How does the clkdev work?

Looking at your abstract:

   The main goals are to manage:
   1. each clock and the operations that the clock support
   2. the clocks tree and the hierarchical relationships
   3. the clock-device relationships
   4. the clock rate change propagation
   5. in an architecture independent way.

   While several clock frameworks are able to address the first two points,
   most of the clock frameworks aren't architecture independent and are not
   able to involve the device driver in the propagation flow.

Point 3 is covered by the clk API, provided the clk API is implemented
correctly, particularly the clk_get() implementation.  clkdev helps to
ensure that people find it easy to implement this function.

Basically, clk_get(dev, id) is used to obtain the clock for device 'dev'.
If the device only has one clock, id _may_ be NULL, but otherwise is the
_input_ clock name for the device.  Eg, on OMAP, the watchdog has a
functional clock and an interface clock.  We give these "fck" and "ick"
names for the ID field.

Other devices in OMAP also have functional and interface clocks, which
aren't the same as the watchdog functional and interface clocks.  We
also pass "fck" and "ick" as the ID to clk_get().

So, the ID field is _not_ a unique clock name in the system; the API was
never designed for that to be the case.  It was always the intention that
clk_get() would return the clock for a particular input on the specified
device.

However, most people found that they could uniquely name their clocks and
ignore the 'dev' passed to clk_get... and then end up passing around clock
names.  That's precisely the wrong usage, and is not how the API is meant
to be used.  Such users need fixing rather than the API redesigned.

Point 2 is implementation specific.  Eg, OMAP has a complex tree of
clocks with PLLs, muxes and switches represented in its clock tree.
Such complexity is not necessary in the vast majority of implementations -
for instance, on Marvel PXA, there is no heirarchial arrangement of
clocks.  The same is true for development platforms such as Realview,
Versatile and Integrator.

Point 1 is also implementation specific.  We have platforms where there
is only one clock, and this is a fixed frequency clock.  Such platforms
should not be burdened by a complex heirarchial clock implementation.

Point 4 is something that OMAP might be able to use, though OMAP already
does this within its clk API implementation without notification of
drivers - the clock rates are driven by drivers requesting rates for
their own clocks rather than one driver influencing the clock rate for
another.

That said, PXA could do with some notification of core state changes,
which influences which clocks are available and the rate which they
run at.  It's something that is going to have some progress over the
next year or so, and it could result in the clk API being extended
with an optional API to support this.

Overall, I really don't buy the "it must be architecture independent"
argument - when I designed the clk API, I _intentionally_ left it up to
the platform to decide how the clk API was to be implemented because I
wanted the API to scale from the simplest single clock right up to
complex stuff like OMAP has.  The API does scale between these two
extremes fairly well at the expense of allowing non-SoC devices to use
it... and that's the biggest down side to allowing that range of scaling.

My biggest mistake, however, when designing the API was not to provide
a standard (but optional) implementation for clk_get() and clk_put(),
which I have now done with clkdev.  (arch/arm/common/clkdev.c)
