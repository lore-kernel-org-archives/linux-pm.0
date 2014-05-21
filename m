From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Wed, 21 May 2014 09:34:57 +0200
Message-ID: <20140521073457.GD31687@pengutronix.de>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
 <20140515073816.GI16662@pengutronix.de>
 <91822600-39d0-4e71-b0f5-9eda35b76ec0@BN1AFFO11FD016.protection.gbl>
 <20140519161949.GG16662@pengutronix.de>
 <db8633e5-01a9-4d3a-80e8-74e23a456d52@BN1BFFO11FD051.protection.gbl>
 <20140520073358.GJ16662@pengutronix.de>
 <4bb5f44a-60bb-4e34-8f88-f91b8419be8d@BL2FFO11FD050.protection.gbl>
 <537B957B.5010001@codeaurora.org>
 <668683e3-856e-4f30-9b11-8f3e91e12d1d@BL2FFO11FD038.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34599 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaEUHfI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 03:35:08 -0400
Content-Disposition: inline
In-Reply-To: <668683e3-856e-4f30-9b11-8f3e91e12d1d@BL2FFO11FD038.protection.gbl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Mike Turquette <mturquette@linaro.org>, Russell King <linux@arm.linux.org.uk>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

On Tue, May 20, 2014 at 02:48:20PM -0700, S=F6ren Brinkmann wrote:
> On Tue, 2014-05-20 at 10:48AM -0700, Stephen Boyd wrote:
> > On 05/20/14 09:01, S=F6ren Brinkmann wrote:
> > >
> > >>>>> +{
> > >>>>> +	unsigned long lower, upper, cur, lower_last, upper_last;
> > >>>>> +
> > >>>>> +	lower =3D clk_round_rate(clk, rate);
> > >>>>> +	if (lower >=3D rate)
> > >>>>> +		return lower;
> > >>>> Is the >-case worth a warning?
> > >>> No, it's correct behavior. If you request a rate that is way lo=
wer than what the
> > >>> clock can generate, returning something larger is perfectly val=
id, IMHO.
> > >>> Which reveals one problem in this whole discussion. The API doe=
s not
> > >>> require clk_round_rate() to round down. It is actually an imple=
mentation
> > >>> choice that had been made for clk-divider.
> > >> I'm sure it's more than an implementation choice for clk-divider=
=2E But I
> > >> don't find any respective documentation (but I didn't try hard).
> > > A similar discussion - without final conclusion:
> > > https://lkml.org/lkml/2010/7/14/260
> > >
> > >
> >=20
> > Please call this new API something like clk_find_nearest_rate() or
> > something. clk_round_rate() is supposed to return the rate that wil=
l be
> > set if you call clk_set_rate() with the same arguments. It's up to =
the
> > implementation to decide if that means rounding the rate up or down=
 or
> > to the nearest value.
>=20
> Sounds good to me. Are there any cases of clocks that round up? I thi=
nk
> that case would not be handled correctly. But I also don't see a use
> case for such an implementation.
I don't really care which semantic (i.e. round up, round down or round
closest) is picked, but I'd vote that all should pick up the same. I
think the least surprising definition is to choose rounding down and ad=
d
the function that is under discussion here to get a nearest match.

So I suggest:

	- if round_rate is given a rate that is smaller than the
	  smallest available rate, return 0
	- add WARN_ONCE to round_rate and set_rate if they return with a
	  rate bigger than requested
	- change the return values to unsigned long

Do we also need a round_up implementation?

Mike? Russell? Any thoughts from your side?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
