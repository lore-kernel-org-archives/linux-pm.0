From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v2 1/6] binding-doc: power: pwrseq-generic: add binding
 doc for generic power sequence library
Date: Thu, 14 Jul 2016 14:36:27 +0800
Message-ID: <20160714063627.GA28730@shlinux2>
References: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
 <1468375610-18625-2-git-send-email-peter.chen@nxp.com>
 <1468394851.3638.13.camel@pengutronix.de>
 <20160713084250.GB11863@shlinux2>
 <5786CCA6.2090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35582 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbcGNGoU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2016 02:44:20 -0400
Content-Disposition: inline
In-Reply-To: <5786CCA6.2090709@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org

On Wed, Jul 13, 2016 at 04:20:06PM -0700, Joshua Clayton wrote:
> 
> 
> On 07/13/2016 01:42 AM, Peter Chen wrote:
> > On Wed, Jul 13, 2016 at 09:27:31AM +0200, Philipp Zabel wrote:
> >> Am Mittwoch, den 13.07.2016, 10:06 +0800 schrieb Peter Chen:
> >>> Add binding doc for generic power sequence library.
> >>>
> >>> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> >>> ---
> >>>  .../bindings/power/pwrseq/pwrseq-generic.txt       | 53 ++++++++++++++++++++++
> >>>  1 file changed, 53 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> >>> new file mode 100644
> >>> index 0000000..186c58c
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> >>> @@ -0,0 +1,53 @@
> >>> +The generic power sequence library
> >>> +
> >>> +Some hard-wired USB/MMC devices need to do power sequence to let the
> >>> +device work normally,
> >> I would replace "to let the device work normally" with "before the
> >> device can be enumerated [on the bus]" here.
> >>
> > Ok.
> >
> >>>  the typical power sequence like: enable USB
> >>> +PHY clock, toggle reset pin, etc. But current Linux USB driver
> >>> +lacks of such code to do it, it may cause some hard-wired USB devices
> >>> +works abnormal or can't be recognized by controller at all. The
> >>> +power sequence will be done before this device can be found at USB
> >>> +bus.
> >>> +
> >>> +The power sequence properties is under the device node.
> >>> +
> >>> +Required properties:
> >>> +- power-sequence: this device needs to do power sequence before enumeration
> >> As Joshua pointed out, is this even needed at all?
> >>
> > If no, how we decide whether allocates pwrseq instance through pwrseq
> > library or not?
> >
> The pwrseq driver is Linux specific. The dts is supposed to be OS agnostic.
> It seems to me that If a driver supports pwrseq and the dts elements
> are there, it should use them, e.g. if there is a clock, enable the clock.
> if there is a reset gpio then take the device into and out of reset during probe.
> 

I agree with you, will delete this property.

-- 

Best Regards,
Peter Chen
