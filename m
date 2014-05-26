From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
Date: Mon, 26 May 2014 16:36:09 +0530
Message-ID: <CAKohponTUsYLf-8_iSnttwK8oXyJEZVWpF+a=vLC7r_jZ8AzOQ@mail.gmail.com>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
	<1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
	<CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
	<1401101131.4829.29.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:48362 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbaEZLGK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 07:06:10 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so7966062obc.9
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2014 04:06:09 -0700 (PDT)
In-Reply-To: <1401101131.4829.29.camel@weser.hi.pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On 26 May 2014 16:15, Lucas Stach <l.stach@pengutronix.de> wrote:
> This driver handles the i.MX5 specific clock reparenting to be able to
> reprogramm the PLL. cpufreq-cpu0 can only change a postdivider of the
> PLL, which means we can't reach the exact OPP frequencies and can not
> profit from the additional power savings of a slower running PLL.
>
> Also without reprogramming the PLL we could possibly not scale to the
> highest OPPs if the bootloader left the PLL at a slower rate. This is
> the case for many i.MX53 boards, as the CPU regulator normally does
> start up with the voltage required for 800MHz operation. If the
> bootloader decides to not touch the regulator and set the PLL to 800MHz
> the 1GHz and 1.2GHz operating points won't be useable.

Almost all users of cpufreq-cpu0 has such situations and they have
written a clock-driver for "cpu clock" to get this fixed. And they handle
all this PLL stuff in clk_set_rate() for this new clock..

I still couldn't find anything so special here that can't be fixed this way.
There is no point adding and maintaining a cpufreq driver if we can
use cpufreq-cpu0.
