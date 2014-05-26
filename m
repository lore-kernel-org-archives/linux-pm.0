From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
Date: Mon, 26 May 2014 12:45:31 +0200
Message-ID: <1401101131.4829.29.camel@weser.hi.pengutronix.de>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
	 <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
	 <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49545 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbaEZKqx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 06:46:53 -0400
In-Reply-To: <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Am Montag, den 26.05.2014, 16:02 +0530 schrieb Viresh Kumar:
> On 26 May 2014 15:45, Lucas Stach <l.stach@pengutronix.de> wrote:
> > SoC specific driver to be able to handle PLL reprogramming
> > for exact OPP frequencies and additional power saving.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  .../devicetree/bindings/cpufreq/cpufreq-imx5.txt   |  43 +++
> >  drivers/cpufreq/Kconfig.arm                        |   8 +
> >  drivers/cpufreq/Makefile                           |   1 +
> >  drivers/cpufreq/imx5-cpufreq.c                     | 302 +++++++++++++++++++++
> >  4 files changed, 354 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-imx5.txt
> >  create mode 100644 drivers/cpufreq/imx5-cpufreq.c
> 
> What stops you to use cpufreq-cpu0 driver with a CPU clock
> driver? Its highly discouraged to add a new driver here if you
> can reuse it.. Which is more or less confirmed from a broad look..

This driver handles the i.MX5 specific clock reparenting to be able to
reprogramm the PLL. cpufreq-cpu0 can only change a postdivider of the
PLL, which means we can't reach the exact OPP frequencies and can not
profit from the additional power savings of a slower running PLL.

Also without reprogramming the PLL we could possibly not scale to the
highest OPPs if the bootloader left the PLL at a slower rate. This is
the case for many i.MX53 boards, as the CPU regulator normally does
start up with the voltage required for 800MHz operation. If the
bootloader decides to not touch the regulator and set the PLL to 800MHz
the 1GHz and 1.2GHz operating points won't be useable.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

