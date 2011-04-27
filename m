From: Colin Cross <ccross@google.com>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
 with device-specific OPPs
Date: Wed, 27 Apr 2011 11:37:07 -0700
Message-ID: <BANLkTinP0_qpF3sp8CzDy42i24wqqo7ohw__34976.9522938461$1303931729$gmane$org@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

(sorry, missent the earlier one)

On Wed, Apr 27, 2011 at 11:07 AM, Menon, Nishanth <nm@ti.com> wrote:
> On Wed, Apr 27, 2011 at 12:49, Colin Cross <ccross@google.com> wrote:
> +l-o
>
>> I'm a little confused about the design for this, and OPP as well. =A0OPP
>> matches a struct device * and a frequency to a voltage, which is not a
>> generically useful pairing, as far as I can tell. =A0On Tegra, it is
>> quite possible for a single device to have multiple clocks that each
>> have different voltage requirements, for example the display block can
>> have an interface clock as well as a pixel clock. =A0Simplifying this to
>> dev + freq =3D voltage seems very OMAP specific, and will be difficult
>> or impossible to adapt to Tegra.
> We have the same requirements as well(iclk,fclk,pixclk etc..)! We
> group them under voltage domains in OMAP ;). if your issue was a
> ability to have a single freq to a OPP, it is upto SoC to do the
> proper mapping. Concept of an OPP still remains consistent - which is
> for a voltage, there is only so much freq you can drive that specific
> module to.
No, that is still wrong. =A0You don't drive a module at a frequency, you
drive a clock. =A0You can't map struct device * 1-1 to a clock. =A0Look at
omap2_set_init_voltage:
static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0struct device *dev) {
        ...
 =A0 =A0 =A0 =A0clk =3D =A0clk_get(NULL, clk_name);
 =A0 =A0 =A0 =A0freq =3D clk->rate;
 =A0 =A0 =A0 =A0opp =3D opp_find_freq_ceil(dev, &freq);
 =A0 =A0 =A0 =A0...
}

What happens if I have a dev with two frequencies?  I can only pass a
dev into opp.  It makes infinitely more sense to pass in a clock:
opp_find_freq_ceil(clk, &freq).

> It is upto SoC frameworks to implement the transitions. E.g. lets look
> at scalability: How'd the mechanism proposed work with temperature
> variances: Example: I dont want to hit 1.5GHz if temp >70C - wont it
> be an SoC specific hack I'd need to introduce?
No, because you're putting it in the wrong place, that is a policy
decision.  Handle it in the clock framework, or handle it in the
device driver.  That's a bad example either way - what happens if you
are already at 1.5GHz when the temperature crosses 70C?  You need an
interrupt that tells you the temperature is too high, and than needs
to affect a policy decision at a much higher level than dvfs.

>
> All OPP framework does is store that maps, and leaves it to users to
> choose regulators, clock framework variances, SoC temperature sensors
> or what ever mechanisms they choose to allow through a transition.
I understand its just a map, but its a map between two things that
don't have a direct mapping in many SoCs.  I think if you changed
every usage of struct dev * in opp to struct clk *, it would make much
more sense.  There is already a mapping from struct dev * to struct
clk *, its called clk_get, and it takes a second parameter to allow
devices to have multiple clocks.
