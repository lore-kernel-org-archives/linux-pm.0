From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH 0/5] Frequency resolution in CCF vs. cpufreq
Date: Thu, 15 May 2014 09:47:24 +0200
Message-ID: <20140515074724.GJ16662@pengutronix.de>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57294 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbaEOHrc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 May 2014 03:47:32 -0400
Content-Disposition: inline
In-Reply-To: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, May 14, 2014 at 03:30:50PM -0700, Soren Brinkmann wrote:
> Hi,
>=20
> I have one or two problems with cpufreq and the CCF, which are caused=
 by
> rounding/different frequency resolutions.
>=20
> cpufreq works with kHz, while the CCF uses Hz. On Zynq our default fr=
equency is
> 666666666 Hz which the CCF, due to rounding, reports as 666666660. An=
d for
Why does this happen? Isn't that a bug? What is the actual freqency?
666666666 Hz or 2000000000/3 Hz?

> cpufreq, which simply divides values it obtains through clk_round_rat=
e() by
> 1000, 666666.
> Since passing 666666 to clk_round_rate() does not result in 666666660
> (clk_round_rate() always rounds down!), we chose to put 666667 in the=
 OPP. This
What is OPP?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
