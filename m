From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH 0/5] Frequency resolution in CCF vs. cpufreq
Date: Thu, 15 May 2014 07:05:28 -0700
Message-ID: <3c6b2890-3df4-48e9-8cc5-8e2d8955f64f@BL2FFO11FD032.protection.gbl>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <CAKohpokm3WVnu_DggKc4PbhVAKNexrJ4051F-gnVFFTDOyz9ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2lp0235.outbound.protection.outlook.com ([207.46.163.235]:45133
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752880AbaEOOHT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 May 2014 10:07:19 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpokm3WVnu_DggKc4PbhVAKNexrJ4051F-gnVFFTDOyz9ew@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Viresh,

On Thu, 2014-05-15 at 11:42AM +0530, Viresh Kumar wrote:
> On 15 May 2014 04:00, Soren Brinkmann <soren.brinkmann@xilinx.com> wr=
ote:
> > I have one or two problems with cpufreq and the CCF, which are caus=
ed by
> > rounding/different frequency resolutions.
> >
> > cpufreq works with kHz, while the CCF uses Hz. On Zynq our default =
frequency is
> > 666666666 Hz which the CCF, due to rounding, reports as 666666660. =
And for
> > cpufreq, which simply divides values it obtains through clk_round_r=
ate() by
> > 1000, 666666.
> > Since passing 666666 to clk_round_rate() does not result in 6666666=
60
> > (clk_round_rate() always rounds down!), we chose to put 666667 in t=
he OPP. This
> > causes issue 1: cpufreq stats are broken.
>=20
> I know it might a big exercise, but wouldn't it be worth to make cpuf=
req start
> using frequencies in Hz ?

I haven't looked into this. As you say yourself, that might be a rather
big project. I will take a look at it, but I can't promise that I have
time to dedicate to this. Also, as said above, even though our CPU is
supposed to run at 666666666 Hz, rounding lets the last 6 Hz disappear.
I think we have to handle deviances either way.

	S=C3=B6ren

