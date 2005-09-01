From: David Brownell <david-b@pacbell.net>
Subject: Re: PowerOP Take 2 1/3: ARM OMAP1 platform support
Date: Thu, 01 Sep 2005 13:11:59 -0700
Message-ID: <20050901201159.92D7585EF0@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <EA12F909C0431D458B9D18A176BEE4A501E0AA90@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============66119271840742666=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A501E0AA90@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: tpoynor@mvista.com, r-woodruff2@ti.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============66119271840742666==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Date: Thu, 1 Sep 2005 07:41:09 -0500
> From: "Woodruff, Richard" <r-woodruff2@ti.com>
>
> > Again, PERDIV changes would need to involve clock.c to cascade
> > the changes through the clock tree.  Change PERDIV and you'll
> > need to recalculate the peripheral clocks that derive from it...
> > better not do it while an I/O operation is actively using it!
>
> As a note, it is not clear how well the current clock.c maps to proper
> switching anyway.  For OMAP2 there defiantly have been a couple points
> which needed consideration.

Right, there's no driver interlock for example; if someone sets
the rate, it "just happens" regardless of whether something is
depending on that current rate or not.  (I suspect APIs to change
clock rates should just fail unless the usecount is zero.  It'd
be messy to need clock rate negotiation APIs...)

Basically, any given architecture (or variant) will need to have
a lot of flexibility about how they implement operating points
and the transitions between them.  PERDIV can be modeled as just
bits in a registers ... but actually changing those bits can mean
changing lots of related ones too, and the code we've seen so
far doesn't reflect such issues.


> Current OMAP2 processors are such that the many of the major system
> clocks and their dividers 'need' to be programmed as a set else the
> system won't function properly.  This kind of thing fits very well into
> the operating point scheme.   Some lower level clocks do need
> rebalancing based on the changes, DPM's current notifier scheme works
> well there beneath the operating points.

Well, PowerOP isn't DPM, and I don't see notifiers.  Yet.  :)

I'm wanting to split the definitions of operating points apart
from the policy choice "what point to use next", much like what
a cpufreq "governor" does (the choices may be constrained by the
current operating point) ... and also to emphasize that operating
points relate to entire boards, including more than just CPU chips.  
(The CPU code tends to be cleaner than the board code, since it's
reused more widely ...)



> This set nature of dividers comes from the fact that many of the chip
> clocks are all completely balanced and running synchronously.  In the
> current clock.c idea, you can walk the tree and program a clock
> independently of other clocks not in your sub tree.  This is will not
> work straight off for the fundamental clocks.  OMAP1 had similar but
> different ratio constraints which aren't still all that well handled in
> code.  For OMAP1 the basic scheme started out as asynchronous clocks
> with fifos at clock boundaries, this injected a bit more flexibility as
> compared OMAP2 which depends on fixed rations and uses phase
> synchronizers.

And I'm sure that other vendors use each of those schemes (or will!)
as well as others.  :)

- Dave


--===============66119271840742666==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============66119271840742666==--
