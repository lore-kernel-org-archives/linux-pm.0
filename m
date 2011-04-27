From: Colin Cross <ccross@google.com>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
 with device-specific OPPs
Date: Wed, 27 Apr 2011 11:29:11 -0700
Message-ID: <BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA__35512.666803743$1303931718$gmane$org@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
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
No, that is still wrong.  You don't drive a module at a frequency, you
drive a clock.  You can't map struct device * 1-1 to a clock.  Look at
omap2_set_init_voltage:
static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
						struct device *dev) {

	clk =3D  clk_get(NULL, clk_name);
	freq =3D clk->rate;
	opp =3D opp_find_freq_ceil(dev, &freq);
	...
}

Now what happens if I have a dev with two frequencies,

>> Moreover, from a silicon perspective, there is always a simple link
>> from a single frequency to a minimum voltage for a given circuit.
>> There is no need to group them into OPPs, which seem to have a group
>> of clocks and their frequencies that map to a single voltage. =A0That is
>> an artifact of the way TI specifies voltages.
>>
>> I don't think DVFS is even the right place for any sort of governor.
>> DVFS is very simple - to increase to a specific clock speed, the
>> voltage must be immediately be raised, with minimum or no delay, to a
>> specified value that is specific to that clock. =A0When the frequency is
>> lowered, the voltage should be decreased. =A0There is a tiny bit of
>> policy to determine when to delay dropping the voltage in case the
>> frequency will immediately be raised again, but nowhere near the
>> complexity of what is shown here.
>>
>> I proposed in a different thread on LKML that DVFS be handled within
>> the generic clock implementation. =A0Platforms would register a
>> regulator and a table of voltages for each struct clock that required
>> DVFS, and the voltages would be changed on normal clk_* requests.
>> This maintains compatibility with existing clk_* calls.
>
> It is upto SoC frameworks to implement the transitions. E.g. lets look
> at scalability: How'd the mechanism proposed work with temperature
> variances: Example: I dont want to hit 1.5GHz if temp >70C - wont it
> be an SoC specific hack I'd need to introduce?
>
> All OPP framework does is store that maps, and leaves it to users to
> choose regulators, clock framework variances, SoC temperature sensors
> or what ever mechanisms they choose to allow through a transition.
>
>> There is a place for a GPU, etc., frequency governor, but it is a
>> completely separate issue from DVFS, and should not be mixed in. =A0I
>> could have a GPU that is not voltage scalable, but could still benefit
>> from lowering the frequency when it is not in use. =A0A devfreq
>> interface sounds perfect for this, as long as it only ends up calling
>> clk_* functions, and those functions handle getting the voltage
>> correct.
>
> Regards,
> Nishanth Menon
> PS:
> https://lists.linux-foundation.org/pipermail/linux-pm/2011-April/031113.h=
tml
> for start of thread
>
