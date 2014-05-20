From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Tue, 20 May 2014 14:48:20 -0700
Message-ID: <668683e3-856e-4f30-9b11-8f3e91e12d1d@BL2FFO11FD038.protection.gbl>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
 <20140515073816.GI16662@pengutronix.de>
 <91822600-39d0-4e71-b0f5-9eda35b76ec0@BN1AFFO11FD016.protection.gbl>
 <20140519161949.GG16662@pengutronix.de>
 <db8633e5-01a9-4d3a-80e8-74e23a456d52@BN1BFFO11FD051.protection.gbl>
 <20140520073358.GJ16662@pengutronix.de>
 <4bb5f44a-60bb-4e34-8f88-f91b8419be8d@BL2FFO11FD050.protection.gbl>
 <537B957B.5010001@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1blp0189.outbound.protection.outlook.com ([207.46.163.189]:42609
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750735AbaETVub (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 May 2014 17:50:31 -0400
Content-Disposition: inline
In-Reply-To: <537B957B.5010001@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Mike Turquette <mturquette@linaro.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

On Tue, 2014-05-20 at 10:48AM -0700, Stephen Boyd wrote:
> On 05/20/14 09:01, S=C3=B6ren Brinkmann wrote:
> >
> >>>>> +{
> >>>>> +	unsigned long lower, upper, cur, lower_last, upper_last;
> >>>>> +
> >>>>> +	lower =3D clk_round_rate(clk, rate);
> >>>>> +	if (lower >=3D rate)
> >>>>> +		return lower;
> >>>> Is the >-case worth a warning?
> >>> No, it's correct behavior. If you request a rate that is way lowe=
r than what the
> >>> clock can generate, returning something larger is perfectly valid=
, IMHO.
> >>> Which reveals one problem in this whole discussion. The API does =
not
> >>> require clk_round_rate() to round down. It is actually an impleme=
ntation
> >>> choice that had been made for clk-divider.
> >> I'm sure it's more than an implementation choice for clk-divider. =
But I
> >> don't find any respective documentation (but I didn't try hard).
> > A similar discussion - without final conclusion:
> > https://lkml.org/lkml/2010/7/14/260
> >
> >
>=20
> Please call this new API something like clk_find_nearest_rate() or
> something. clk_round_rate() is supposed to return the rate that will =
be
> set if you call clk_set_rate() with the same arguments. It's up to th=
e
> implementation to decide if that means rounding the rate up or down o=
r
> to the nearest value.

Sounds good to me. Are there any cases of clocks that round up? I think
that case would not be handled correctly. But I also don't see a use
case for such an implementation.

	S=C3=B6ren

