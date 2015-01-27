From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
Date: Tue, 27 Jan 2015 19:35:09 +0100 (CET)
Message-ID: <1954124242.301697.1422383709733.JavaMail.open-xchange@oxbaltgw09.schlund.de>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com> <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com> <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com> <20150125150431.GE2719@earth.universe> <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de> <20150127001629.GP21293@sirena.org.uk>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:62753 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbA0Sfz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 13:35:55 -0500
In-Reply-To: <20150127001629.GP21293@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org

Hi Mark,

> Mark Brown <broonie@kernel.org> hat am 27. Januar 2015 um 01:16 geschrieben:
>
>
> On Mon, Jan 26, 2015 at 08:46:45PM +0100, Stefan Wahren wrote:
>
> > > > Does a common property name exists for the switching frequency or would
> > > > it be vendor specific?
>
> > > As far as I know most regulators have fixed switching frequencies,
> > > so there is no common property name so far. I added regulator
> > > framework people, since this property should be regulator specific.
>
> No, it's pretty common for there to be a couple of options - there's
> normally a performance tradeoff (power for regulation accuracy and/or
> cost) which can be selected. IIRC it's selected at design time as it
> affect the choice of passives on the board.
>
> > okay i understand. But doesn't it need a extra driver to set the switching
> > frequency because of the new compatible string?
>
> I don't understand this bit at all, sorry.

Sebastian suggested a new sub-node in the devicetree:

    powerpll {
        compatible = "fsl,imx28-power-pll"
        #clock-cells = <0>;
        clock-frequency = <12345>;
    }

and i think that the new compatible string needs a separate driver to take care
of the switching frequency.

Or is it okay to leave the handling of the switching frequency in the mxs-power
driver?

Btw if we add a new node to set switching frequency, i think it would be better
to describe the dc-dc convertor and not the pll:

    dcdc {
       compatible = "fsl,imx28-dcdc"
       frequency = <12345>;
    }

What do you think?

Best regards
Stefan

>
> >
> > At this point i think about moving this feature into the bootloader.
> >
> > @Fabio, @Marek:
> >
> > What's your opinion about that?
> >
> > >
> > > -- Sebastian
> >
> > Stefan
> >
