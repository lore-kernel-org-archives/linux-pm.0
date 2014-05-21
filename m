From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Wed, 21 May 2014 13:33:00 -0700
Message-ID: <20140521203300.9521.67546@quantum>
References: <20140515073816.GI16662@pengutronix.de>
 <20140519161949.GG16662@pengutronix.de>
 <db8633e5-01a9-4d3a-80e8-74e23a456d52@BN1BFFO11FD051.protection.gbl>
 <20140520073358.GJ16662@pengutronix.de>
 <4bb5f44a-60bb-4e34-8f88-f91b8419be8d@BL2FFO11FD050.protection.gbl>
 <537B957B.5010001@codeaurora.org>
 <668683e3-856e-4f30-9b11-8f3e91e12d1d@BL2FFO11FD038.protection.gbl>
 <20140521073457.GD31687@pengutronix.de>
 <e9090453-ce40-4662-a3ea-fbdaffdb2aa4@BN1AFFO11FD046.protection.gbl>
 <20140521182308.GN31687@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:56961 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbaEUUdj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 16:33:39 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so1756925pbb.20
        for <linux-pm@vger.kernel.org>; Wed, 21 May 2014 13:33:38 -0700 (PDT)
In-Reply-To: <20140521182308.GN31687@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?utf-8?q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Quoting Uwe Kleine-K=C3=B6nig (2014-05-21 11:23:08)
> Hello S=C3=B6ren,
>=20
> On Wed, May 21, 2014 at 08:58:10AM -0700, S=C3=B6ren Brinkmann wrote:
> > On Wed, 2014-05-21 at 09:34AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, May 20, 2014 at 02:48:20PM -0700, S=C3=B6ren Brinkmann wr=
ote:
> > > > On Tue, 2014-05-20 at 10:48AM -0700, Stephen Boyd wrote:
> > > > > On 05/20/14 09:01, S=C3=B6ren Brinkmann wrote:
> > > > > >
> > > > > >>>>> +{
> > > > > >>>>> + unsigned long lower, upper, cur, lower_last, upper_la=
st;
> > > > > >>>>> +
> > > > > >>>>> + lower =3D clk_round_rate(clk, rate);
> > > > > >>>>> + if (lower >=3D rate)
> > > > > >>>>> +         return lower;
> > > > > >>>> Is the >-case worth a warning?
> > > > > >>> No, it's correct behavior. If you request a rate that is =
way lower than what the
> > > > > >>> clock can generate, returning something larger is perfect=
ly valid, IMHO.
> > > > > >>> Which reveals one problem in this whole discussion. The A=
PI does not
> > > > > >>> require clk_round_rate() to round down. It is actually an=
 implementation
> > > > > >>> choice that had been made for clk-divider.
> > > > > >> I'm sure it's more than an implementation choice for clk-d=
ivider. But I
> > > > > >> don't find any respective documentation (but I didn't try =
hard).
> > > > > > A similar discussion - without final conclusion:
> > > > > > https://lkml.org/lkml/2010/7/14/260
> > > > > >
> > > > > >
> > > > >=20
> > > > > Please call this new API something like clk_find_nearest_rate=
() or
> > > > > something. clk_round_rate() is supposed to return the rate th=
at will be
> > > > > set if you call clk_set_rate() with the same arguments. It's =
up to the
> > > > > implementation to decide if that means rounding the rate up o=
r down or
> > > > > to the nearest value.
> > > >=20
> > > > Sounds good to me. Are there any cases of clocks that round up?=
 I think
> > > > that case would not be handled correctly. But I also don't see =
a use
> > > > case for such an implementation.
> > > I don't really care which semantic (i.e. round up, round down or =
round
> > > closest) is picked, but I'd vote that all should pick up the same=
=2E I
> > > think the least surprising definition is to choose rounding down =
and add
> > > the function that is under discussion here to get a nearest match=
=2E
> > >=20
> > > So I suggest:
> > >=20
> > >     - if round_rate is given a rate that is smaller than the
> > >       smallest available rate, return 0
> > >     - add WARN_ONCE to round_rate and set_rate if they return wit=
h a
> > >       rate bigger than requested
> >=20
> > Why do you think 0 is always valid? I think for a clock that can
> > generate 40, 70, 120, clk_round_rate(20) should return 40.
> I didn't say it's a valid value. It just makes the it possible to che=
ck
> for clk_round_rate(clk, rate) <=3D rate.
>=20
> I grepped a bit around and found da850_round_armrate which implements=
 a
> round_rate callback returning the best match.
> omap1_clk_round_rate_ckctl_arm can return a value < 0.
> s3c2412_roundrate_usbsrc can return values that are bigger than
> requested. (I wonder if that is a bug though.)
>=20
> > >     - change the return values to unsigned long
> >=20
> > Yep, I agree, this should happen.
> And we're using 0 as error value? e.g. for the case where
> omap1_clk_round_rate_ckctl_arm returns -EIO now?

No. clk_round_rate returns long for a reason, which is that we can
provide an error code to the caller. From include/linux/clk.h:

/**
 * clk_round_rate - adjust a rate to the exact rate a clock can provide
 * @clk: clock source
 * @rate: desired clock rate in Hz
 *
 * Returns rounded clock rate in Hz, or negative errno.
 */

This has the unfortunate side effect that the max value we can return
safely is 2147483647 (~2GHz). So another issue here is converting clock
rates to 64-bit values.

Regards,
Mike

>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig   =
         |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |
