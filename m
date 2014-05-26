From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
Date: Mon, 26 May 2014 17:57:33 +0200
Message-ID: <1401119853.4829.65.camel@weser.hi.pengutronix.de>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
	 <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
	 <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
	 <1401101131.4829.29.camel@weser.hi.pengutronix.de>
	 <CAKohponTUsYLf-8_iSnttwK8oXyJEZVWpF+a=vLC7r_jZ8AzOQ@mail.gmail.com>
	 <1401107748.4829.39.camel@weser.hi.pengutronix.de>
	 <CAKohpo=ncHUmtJOEw4FZG1BWUSuiQK4n+ETEMJWJj9UoPz2cnw@mail.gmail.com>
	 <1401109863.4829.46.camel@weser.hi.pengutronix.de>
	 <CAKohponzJma6yNueMef2Q4k+qT-n7boV0tx0pCqjFmuQWj6TXg@mail.gmail.com>
	 <1401112697.4829.56.camel@weser.hi.pengutronix.de>
	 <CAKohponvWLVfBL06HURnTq4nmdKjROV-bd4pVcbNmsAUYYC+nA@mail.gmail.com>
	 <1401118115.4829.60.camel@weser.hi.pengutronix.de>
	 <CAKohpo=yShVa+5On0cPU68ooQGO8dFXP+amPHf3taP_aYYe1Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47537 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbaEZP6y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 11:58:54 -0400
In-Reply-To: <CAKohpo=yShVa+5On0cPU68ooQGO8dFXP+amPHf3taP_aYYe1Qg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Am Montag, den 26.05.2014, 21:05 +0530 schrieb Viresh Kumar:
> On 26 May 2014 20:58, Lucas Stach <l.stach@pengutronix.de> wrote:
> > The platform I'm working on supports cpu rail voltage regulation just
> > fine.
> 
> So, the regulator can be scaled to support all values from your dts
> and we can work without MAX-volt parameter here..

The max-volt parameter is still useful to determine the acceptable
tolerance. It defines that max voltage one would pass to the regulator
framework, without the need to "compute" the tolerance in any way, as we
already have a datasheet defined max value.

> 
> > I just want to make sure that the driver works properly on platforms
> > where this isn't the case.
> 
> Can we just take care of this simply by not adding any regulators at
> all? In that case cpufreq-cpu0 will try working without a regulator..

No, we need the regulator to determine which OPPs are actually useable.
If the regulator is only supplying 1.1V we can only scale to 800MHz max,
which is the case for some of the industrial i.MX53 versions.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

