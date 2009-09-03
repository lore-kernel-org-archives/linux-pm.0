From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: Montreal Linux Power Management Mini-Summit, July 13,
 2009 - Meeting Notes
Date: Thu, 3 Sep 2009 16:28:49 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039A899EC7@dlee02.ent.ti.com>
References: <alpine.LFD.2.00.0905211430220.4390@localhost.localdomain>
	<alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
	<63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
	<4A9E2EA7.8080700@st.com>	<20090902215832.GB21292@n2100.arm.linux.org.uk>
	<4A9FD7C7.7070301@st.com>	<20090903171213.GB9507@n2100.arm.linux.org.uk>
	<63386a3d0909031315v77d2a2d0x490b15aa839f7339@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <63386a3d0909031315v77d2a2d0x490b15aa839f7339@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Walleij <linus.ml.walleij@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Linux Power Management List <linux-pm@lists.osdl.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-
> bounces@lists.infradead.org] On Behalf Of Linus Walleij
> Sent: Thursday, September 03, 2009 3:15 PM
> To: Russell King - ARM Linux

> 2009/9/3 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>
> > [Francesco's blurb]
> >   The main goals are to manage:
> >   1. each clock and the operations that the clock support
> >   2. the clocks tree and the hierarchical relationships
> >   3. the clock-device relationships
> >   4. the clock rate change propagation
> >   5. in an architecture independent way.
>
> > Point 4 is something that OMAP might be able to use, though OMAP already
> > does this within its clk API implementation without notification of
> > drivers - the clock rates are driven by drivers requesting rates for
> > their own clocks rather than one driver influencing the clock rate for
> > another.
> >
> > That said, PXA could do with some notification of core state changes,
> > which influences which clocks are available and the rate which they
> > run at.  It's something that is going to have some progress over the
> > next year or so, and it could result in the clk API being extended
> > with an optional API to support this.
>
> We need something like (4) for U300 as well, we have the same
> issue with core state propagating changes to several clocks, which
> is mainly why I asked about this thing from the SuperH people.
>
> > My biggest mistake, however, when designing the API was not to provide
> > a standard (but optional) implementation for clk_get() and clk_put(),
> > which I have now done with clkdev.  (arch/arm/common/clkdev.c)

If you are not careful notifications can turn into a graph with cycles.  p_start: Driver A changes shared root speed. Then driver B gets notification of change.  Driver B then tries to adjust clock to get back into range for its device; Driver a gets notification of speed change: goto p_start.

Older OMAP clock code mainly called a simple recalc method as part of an internal propagate rate which happens as part of clk_set_rate. Only exporting 'safe' rates as returned by the clk_round_rate call can make a set_rate(valid_rate) calls work with out issue.

Both the good and the bad of the clock frame work is it hides clock node details from the driver. This allows the driver to talk in rates and not worry about upper structure. The inflexible is, sometimes you would like to add and remove nodes. If I plug in some hw-module which is deriving its clock from a processor clock, it would be nice to write that driver to add the node for its local clock and then just use the standard apis. To do this however requires you to understand the node structure at the driver (clk_install_node, clk_remove_node).

Paul Walmsley offered some patches with notifiers for OMAP recently which you might look at.  TI had also added a pre/post notifier which was used with clock changes in a different layer just above clock in a resource freamwork.  As it turns out for OMAP3, the notifiers are not needed very often as there are many independent DPLLs.  Back in OMAP2 however they were more important as most everything was derived from a single DPLL.

Some of the clock abuse which happened by allowing the specifying of physical I+F clocks for a devices instead of a single virtual clock can be useful.  In some cases it is important for the driver to sequence its internal clocks as part of init or shutdown.  Handling them as a single entity isn't always doable.  Sometimes you could factor that code out but not always.

Regards,
Richard W.
