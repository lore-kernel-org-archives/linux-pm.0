From: Andy Tang <andy.tang@nxp.com>
Subject: RE: [PATCH] cpufreq: qoriq: enhance bus frequency calculation
Date: Fri, 10 Mar 2017 10:12:44 +0000
Message-ID: <DB6PR0402MB2837CEF42A170F8CAEA599DFF3200@DB6PR0402MB2837.eurprd04.prod.outlook.com>
References: <1489047306-31818-1-git-send-email-andy.tang@nxp.com>
 <20170309093917.GB3341@vireshk-i7>
 <DB6PR0402MB2837F020F46C802207B81D2BF3200@DB6PR0402MB2837.eurprd04.prod.outlook.com>
 <20170310100511.GD3341@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170310100511.GD3341@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Friday, March 10, 2017 6:05 PM
> To: Andy Tang
> Cc: rjw@rjwysocki.net; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] cpufreq: qoriq: enhance bus frequency calculation
>=20
> On 10-03-17, 01:44, Andy Tang wrote:
> > > Will this always work? If yes, then what about dropping the code
> > > parsing DT completely ? That is, just rely on clk_get_rate() in all c=
ases.
> > >
> > We put all the clock tree configuration in driver, not in dts.
> > cg-pll0-div1 is hardcoded in driver since we don't depend on dts.
> > We kind of don't have other choices but use the hardcode clock name
> > here too.
>=20
> Looks like you misread my comment. Let me try again. Will it be fine to w=
rite
> get_bus_freq() this way?
>=20
> static u32 get_bus_freq(void)
> {
> 	struct clk *pltclk;
>=20
> 	/* get platform freq by its clock name */
> 	pltclk =3D clk_get(NULL, "cg-pll0-div1");
> 	if (IS_ERR(pltclk)) {
> 		pr_err("%s: can't get bus frequency %ld\n",
> 		       __func__, PTR_ERR(pltclk));
> 		return PTR_ERR(pltclk);
> 	}
>=20
> 	return clk_get_rate(pltclk);
> }
>=20
Yes, we can. But for some legacy powerpc-based socs, this may not work.
powerpc-base socs are still  using legacy clock driver. For compatibility s=
ake, we better be compatible with old ones. It would break any compatibilit=
y this way.

Regards,
Yuantian

> --
> viresh
