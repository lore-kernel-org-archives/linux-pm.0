From: =?utf-8?q?J=C3=BCrgen_Borleis?= <jbe@pengutronix.de>
Subject: Re: [PATCH V2 4/6] DT: add binding for mxs on-chip regulators
Date: Tue, 5 May 2015 10:21:01 +0200
Message-ID: <201505051021.01939.jbe@pengutronix.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com> <201505041551.26355.jbe@pengutronix.de> <1858103470.878923.1430770850541.JavaMail.open-xchange@oxbaltgw08.schlund.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37878 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847AbbEEISa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 04:18:30 -0400
In-Reply-To: <1858103470.878923.1430770850541.JavaMail.open-xchange@oxbaltgw08.schlund.de>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, fabio.estevam@freescale.com, David Woodhouse <dwmw2@infradead.org>, Russell King <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org

Hi Stefan,

On Monday 04 May 2015 22:20:50 Stefan Wahren wrote:
> [...]
> >
> > +------------+     VDD5V  +---------+  VDDIO
> > | DC-DC      |   +--------> LINREG  +--------->+
> > |            |            | VDDIO   |          |
> > |            |            +---------+          |
> > |            |                                 |
> > | DCDC_VDDIO +->-+-----------------------------+
> > |            |   |
> > |            |   | VDDIO  +---------+ VDDMEM
> > |            |   +--------> LINREG  +--------->
> > |            |   |        | VDDMEM  |
> > |            |   |        +---------+
> > |            |   | VDDIO  +---------+  VDDA
> > |            |   +--------> LINREG  +--------->+
> > |            |            | VDDA    |          |
> > |            |            +---------+          |
> > | DCDC_VDDA  +->-+-----------------------------+
> > |            |   |
> > |            |   | VDDA   +---------+  VDDD
> > |            |   +--------> LINREG  +--------->+
> > |            |            | VDDD    |          |
> > |            |            +---------+          |
> > | DCDC_VDDD  +->-------------------------------+
> > +------------+                                 |
> >                                                v
>
> damn! I didn't noticed that VDDMEM is powered by VDDIO and VDD1P5 is
> powered by VDDA. Thank you very much.
>
> From my understanding VDDMEM and VDD1P5 describe the same regulator
> function (provides power to external memory such as SDRAM and mDDR which
> doesn't fit to VDDD, VDDIO or VDDA). But the usage of
> the name is not consistent across the documentation:
>                   | i.MX23 | i.MX28
> ------------------------------------
> Application note  | VDDMEM | VDD1P5
> Reference manual  | VDDMEM | VDDMEM
> Data sheet        | -      | VDD1P5
>
> I would suggest to use VDDMEM, because the registers are always called
> HW_VDDMEM (for both SoCs).

Ack.

> I think we have 3 options here:
>
> a) add the regulator daisy chain for the i.MX23 too
> b) remove VDD1P5 from the i.MX28 diagram so it would fit for both again
> c) remove the diagram complete
>
> I would prefer option b. What's your opinion?

I prefer a) because once the details are known, we should keep them.

Regards,
Juergen
