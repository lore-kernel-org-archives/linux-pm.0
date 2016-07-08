From: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH v3 2/2] cpufreq: qoriq: Don't look at clock
 implementation details
Date: Fri, 08 Jul 2016 16:06:54 -0500
Message-ID: <1468012014.32358.74.camel@buserror.net>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
	 <1466058085-19353-2-git-send-email-oss@buserror.net>
	 <146785501714.73491.8643317356949121718@resonance>
	 <1467864803.32358.63.camel@buserror.net>
	 <146794477678.73491.8244253339435407853@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <146794477678.73491.8244253339435407853@resonance>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, yuantian.tang@nxp.com, leoyang.li@nxp.com, xiaofeng.ren@nxp.com
List-Id: linux-pm@vger.kernel.org

On Thu, 2016-07-07 at 19:26 -0700, Michael Turquette wrote:
> Quoting Scott Wood (2016-07-06 21:13:23)
> >=20
> > On Wed, 2016-07-06 at 18:30 -0700, Michael Turquette wrote:
> > >=20
> > > Quoting Scott Wood (2016-06-15 23:21:25)
> > > >=20
> > > >=20
> > > > -static struct device_node *cpu_to_clk_node(int cpu)
> > > > +static struct clk *cpu_to_clk(int cpu)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_node *=
np, *clk_np;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_node *=
np;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct clk *clk;
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!cpu_presen=
t(cpu))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > > > @@ -112,37 +80,28 @@ static struct device_node *cpu_to_clk_node=
(int
> > > > cpu)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!np)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clk_np =3D of_parse_=
phandle(np, "clocks", 0);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!clk_np)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > > > -
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clk =3D of_clk_get(n=
p, 0);
> > > Why not use devm_clk_get here?
> > devm_clk_get() is a wrapper around clk_get() which is not the same =
as
> > of_clk_get(). =C2=A0What device would you pass to devm_clk_get(), a=
nd what name
> > would you pass?
> I'm fuzzy on whether or not you get a struct device from a cpufreq
> driver. If so, then that would be the one to use. I would hope that
> cpufreq drivers model cpus as devices, but I'm really not sure withou=
t
> looking into the code.

It's not the cpufreq code that provides it, but get_cpu_device() could =
be
used.

Do you have any comments on the first patch of this set?

-Scott

