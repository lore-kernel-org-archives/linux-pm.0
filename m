From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Wed, 21 May 2014 08:58:10 -0700
Message-ID: <e9090453-ce40-4662-a3ea-fbdaffdb2aa4@BN1AFFO11FD046.protection.gbl>
References: <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
 <20140515073816.GI16662@pengutronix.de>
 <91822600-39d0-4e71-b0f5-9eda35b76ec0@BN1AFFO11FD016.protection.gbl>
 <20140519161949.GG16662@pengutronix.de>
 <db8633e5-01a9-4d3a-80e8-74e23a456d52@BN1BFFO11FD051.protection.gbl>
 <20140520073358.GJ16662@pengutronix.de>
 <4bb5f44a-60bb-4e34-8f88-f91b8419be8d@BL2FFO11FD050.protection.gbl>
 <537B957B.5010001@codeaurora.org>
 <668683e3-856e-4f30-9b11-8f3e91e12d1d@BL2FFO11FD038.protection.gbl>
 <20140521073457.GD31687@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2lp0243.outbound.protection.outlook.com ([207.46.163.243]:34376
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752552AbaEUQAa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 21 May 2014 12:00:30 -0400
Content-Disposition: inline
In-Reply-To: <20140521073457.GD31687@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 2014-05-21 at 09:34AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, May 20, 2014 at 02:48:20PM -0700, S=C3=B6ren Brinkmann wrote:
> > On Tue, 2014-05-20 at 10:48AM -0700, Stephen Boyd wrote:
> > > On 05/20/14 09:01, S=C3=B6ren Brinkmann wrote:
> > > >
> > > >>>>> +{
> > > >>>>> +	unsigned long lower, upper, cur, lower_last, upper_last;
> > > >>>>> +
> > > >>>>> +	lower =3D clk_round_rate(clk, rate);
> > > >>>>> +	if (lower >=3D rate)
> > > >>>>> +		return lower;
> > > >>>> Is the >-case worth a warning?
> > > >>> No, it's correct behavior. If you request a rate that is way =
lower than what the
> > > >>> clock can generate, returning something larger is perfectly v=
alid, IMHO.
> > > >>> Which reveals one problem in this whole discussion. The API d=
oes not
> > > >>> require clk_round_rate() to round down. It is actually an imp=
lementation
> > > >>> choice that had been made for clk-divider.
> > > >> I'm sure it's more than an implementation choice for clk-divid=
er. But I
> > > >> don't find any respective documentation (but I didn't try hard=
).
> > > > A similar discussion - without final conclusion:
> > > > https://lkml.org/lkml/2010/7/14/260
> > > >
> > > >
> > >=20
> > > Please call this new API something like clk_find_nearest_rate() o=
r
> > > something. clk_round_rate() is supposed to return the rate that w=
ill be
> > > set if you call clk_set_rate() with the same arguments. It's up t=
o the
> > > implementation to decide if that means rounding the rate up or do=
wn or
> > > to the nearest value.
> >=20
> > Sounds good to me. Are there any cases of clocks that round up? I t=
hink
> > that case would not be handled correctly. But I also don't see a us=
e
> > case for such an implementation.
> I don't really care which semantic (i.e. round up, round down or roun=
d
> closest) is picked, but I'd vote that all should pick up the same. I
> think the least surprising definition is to choose rounding down and =
add
> the function that is under discussion here to get a nearest match.
>=20
> So I suggest:
>=20
> 	- if round_rate is given a rate that is smaller than the
> 	  smallest available rate, return 0
> 	- add WARN_ONCE to round_rate and set_rate if they return with a
> 	  rate bigger than requested

Why do you think 0 is always valid? I think for a clock that can
generate 40, 70, 120, clk_round_rate(20) should return 40.

> 	- change the return values to unsigned long

Yep, I agree, this should happen.

	S=C3=B6ren

