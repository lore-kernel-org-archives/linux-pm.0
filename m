From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH 0/5] Frequency resolution in CCF vs. cpufreq
Date: Thu, 15 May 2014 07:00:26 -0700
Message-ID: <6fe97032-ba6b-4dac-9064-34a9c788c57c@BN1BFFO11FD001.protection.gbl>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140515074724.GJ16662@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:20462
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751768AbaEOOCT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 May 2014 10:02:19 -0400
Content-Disposition: inline
In-Reply-To: <20140515074724.GJ16662@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Uwe,

On Thu, 2014-05-15 at 09:47AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, May 14, 2014 at 03:30:50PM -0700, Soren Brinkmann wrote:
> > Hi,
> >=20
> > I have one or two problems with cpufreq and the CCF, which are caus=
ed by
> > rounding/different frequency resolutions.
> >=20
> > cpufreq works with kHz, while the CCF uses Hz. On Zynq our default =
frequency is
> > 666666666 Hz which the CCF, due to rounding, reports as 666666660. =
And for
> Why does this happen? Isn't that a bug? What is the actual freqency?
> 666666666 Hz or 2000000000/3 Hz?

I don't know for sure. I think it's rounding that takes place in the
CCF. That output clock goes from a x-tal through an PLL and various
muxes and dividers. I guess some inaccuracies in the magnitude of a few
Hz are probably not avoidable in that processing chain.

>=20
> > cpufreq, which simply divides values it obtains through clk_round_r=
ate() by
> > 1000, 666666.
> > Since passing 666666 to clk_round_rate() does not result in 6666666=
60
> > (clk_round_rate() always rounds down!), we chose to put 666667 in t=
he OPP. This
> What is OPP?

As Nishanth already said, Operating Performance Points. Sorry for being
lazy and not having spelled that out.

	S=C3=B6ren

