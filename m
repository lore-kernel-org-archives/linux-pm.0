From: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH v3 2/2] cpufreq: qoriq: Don't look at clock
 implementation details
Date: Wed, 06 Jul 2016 23:13:23 -0500
Message-ID: <1467864803.32358.63.camel@buserror.net>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
	 <1466058085-19353-2-git-send-email-oss@buserror.net>
	 <146785501714.73491.8643317356949121718@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <146785501714.73491.8643317356949121718@resonance>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, yuantian.tang@nxp.com, leoyang.li@nxp.com, xiaofeng.ren@nxp.com
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-07-06 at 18:30 -0700, Michael Turquette wrote:
> Quoting Scott Wood (2016-06-15 23:21:25)
> >=20
> > -static struct device_node *cpu_to_clk_node(int cpu)
> > +static struct clk *cpu_to_clk(int cpu)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_node *np, =
*clk_np;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_node *np;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct clk *clk;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!cpu_present(cp=
u))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > @@ -112,37 +80,28 @@ static struct device_node *cpu_to_clk_node(int=
 cpu)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!np)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clk_np =3D of_parse_phan=
dle(np, "clocks", 0);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!clk_np)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clk =3D of_clk_get(np, 0=
);
> Why not use devm_clk_get here?

devm_clk_get() is a wrapper around clk_get() which is not the same as
of_clk_get(). =C2=A0What device would you pass to devm_clk_get(), and w=
hat name
would you pass?

> >=20
> > @@ -221,17 +180,12 @@ static int qoriq_cpufreq_cpu_init(struct
> > cpufreq_policy *policy)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_nomem2;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pnode =3D of_parse_phand=
le(np, "clocks", 0);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!pnode) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pr_err("%s: could not get clock information\n",=
 __func__);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto err_nomem2;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0count =3D clk_get_num_pa=
rents(policy->clk);
> We already have of_clk_get_parent_count. This is found in
> clk-provider.h, which doesn't fit perfectly here since the cpufreq
> driver is not a clock provider, but instead a consumer.

It's also a device tree function, and the clock parents in question are=
n't in
the device tree.

> > @@ -240,23 +194,11 @@ static int qoriq_cpufreq_cpu_init(struct
> > cpufreq_policy *policy)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_pclk;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fmask)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0mask =3D fmask[get_cpu_physical_id(cpu)];
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0mask =3D 0x0;
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < c=
ount; i++) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clk =3D of_clk_get(pnode, i);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clk =3D clk_get_parent_by_index(policy->clk, i)=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0data->pclk[i] =3D clk;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0freq =3D clk_get_rate(clk);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/*
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* the clock is valid if its frequency is =
not masked
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* and large than minimum allowed frequenc=
y.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (freq < min_cpufreq || (mask & (1 << i)))
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
table[i].frequency =3D CPUFREQ_ENTRY_INVALID;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0else
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
table[i].frequency =3D freq / 1000;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0table[i].frequency =3D freq / 1000;
> Hmm, so you change cpu clock rate by selecting different clock source=
s
> from a cpu clock mux, right?

Yes. =C2=A0You'd think such a simple thing would be more straightforwar=
d.

>  I wonder if you can just have a child mux
> clock that selects parents from .set_rate (via a .determine_rate
> callback)? Then you could just call clk_set_rate() on your cpu mux cl=
ock
> and maybe skip most of the stuff this driver does?

"Most of the stuff this driver does" is dealing with the cpufreq subsys=
tem
(ask the cpufreq maintainers why it requires so much boilerplate), asso=
ciating
clock muxes with cpus, etc. =C2=A0It is also not obvious to me how to u=
se
determine_rate() or that the end result would be any simpler or better.=
 =C2=A0It
seems like the implementation would just be reimplementing logic that a=
lready
exists in cpufreq, and the cpufreq driver would still need to be able t=
o get a
list of possible frequencies, because cpufreq wants a table of them.

After nearly a year of non-response to these patches[1], a request to
completely rearchitect this driver[2] just to avoid exposing a couple
straightforward informational functions to clock consumers[3] was not q=
uite
what I was hoping for. =C2=A0What is wrong with clock consumers being a=
ble to query
the parent list, given that clock consumers have the ability to request=
 a
particular parent?

-Scott

[1] Original versions:
http://www.spinics.net/lists/linux-clk/msg03069.html
http://www.spinics.net/lists/linux-clk/msg03070.html


[2] The only reason I'm touching this driver at all is because it curre=
ntly
makes bad assumptions about clock provider internals (and clock provide=
r
device tree structure) that are broken by the new bindings enabled by
commit=C2=A00dfc86b3173fee ("clk: qoriq: Move chip-specific knowledge i=
nto
driver").

[3] I initially discussed adding consumer APIs for this patchset in=C2=A0
http://lkml.iu.edu/hypermail/linux/kernel/1509.2/02728.html

