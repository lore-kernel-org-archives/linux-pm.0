From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC 3/3] ARM: dts: enable power subsystem for i.MX28
Date: Thu, 20 Nov 2014 23:57:03 +0100 (CET)
Message-ID: <1167895673.64469.1416524223868.JavaMail.open-xchange@oxbaltgw04.schlund.de>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com> <1416514477-19190-4-git-send-email-stefan.wahren@i2se.com> <CAOMZO5AWOs8ODsru+ySsLb=R4ezDL19nK_z0zAXdbrDfPT8KhA@mail.gmail.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:52358 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141AbaKTW5w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Nov 2014 17:57:52 -0500
In-Reply-To: <CAOMZO5AWOs8ODsru+ySsLb=R4ezDL19nK_z0zAXdbrDfPT8KhA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Fabio,

> Fabio Estevam <festevam@gmail.com> hat am 20. November 2014 um 22:32
> geschrieben:
>
>
> Hi Stefan,
>
> On Thu, Nov 20, 2014 at 6:14 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > This patch enables the power subsystem for all i.MX28 boards.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> > arch/arm/boot/dts/imx28.dtsi | 6 +++++-
> > 1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > index 47f68ac..5c163a5 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -1022,8 +1022,12 @@
> > };
> >
> > power: power@80044000 {
> > + compatible = "fsl,imx28-power";
>
> Should we have 'fsl,imx23-power' and 'fsl,imx28-power' as compatible strings?

yes, of course.

>
> Or ''fsl,mxs-power' could be used for both?

I think that would be a bad idea. I can't believe that all PMU register of
i.MX23 and i.MX28 are identical. So in the future we will have to distinguish
between them. It's better to do it now like most of the mxs driver does.

Stefan
