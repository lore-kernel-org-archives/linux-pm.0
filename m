From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [linux-pm] Montreal Linux Power Management Mini-Summit, July 13,
	2009 - Meeting Notes
Date: Thu, 3 Sep 2009 22:15:21 +0200
Message-ID: <63386a3d0909031315v77d2a2d0x490b15aa839f7339@mail.gmail.com>
References: <alpine.LFD.2.00.0905211430220.4390@localhost.localdomain>
	<alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
	<63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
	<4A9E2EA7.8080700@st.com>
	<20090902215832.GB21292@n2100.arm.linux.org.uk>
	<4A9FD7C7.7070301@st.com>
	<20090903171213.GB9507@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20090903171213.GB9507@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Francesco VIRLINZI <francesco.virlinzi@st.com>, Paul Mundt <lethal@linux-sh.org>, Linux Power Management List <linux-pm@lists.osdl.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

2009/9/3 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> [Francesco's blurb]
> =A0 The main goals are to manage:
> =A0 1. each clock and the operations that the clock support
> =A0 2. the clocks tree and the hierarchical relationships
> =A0 3. the clock-device relationships
> =A0 4. the clock rate change propagation
> =A0 5. in an architecture independent way.

> Point 4 is something that OMAP might be able to use, though OMAP already
> does this within its clk API implementation without notification of
> drivers - the clock rates are driven by drivers requesting rates for
> their own clocks rather than one driver influencing the clock rate for
> another.
>
> That said, PXA could do with some notification of core state changes,
> which influences which clocks are available and the rate which they
> run at. =A0It's something that is going to have some progress over the
> next year or so, and it could result in the clk API being extended
> with an optional API to support this.

We need something like (4) for U300 as well, we have the same
issue with core state propagating changes to several clocks, which
is mainly why I asked about this thing from the SuperH people.

> My biggest mistake, however, when designing the API was not to provide
> a standard (but optional) implementation for clk_get() and clk_put(),
> which I have now done with clkdev. =A0(arch/arm/common/clkdev.c)

If other SoCs like SuperH (obviously) and maybe PowerPC, etc need this
as well, could it be relocated to something like drivers/clk and include/li=
nux?
That sounds like fulfilling (5) for (3).

Linus Walleij
