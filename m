From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH 1/6] binding-doc: power: pwrseq-generic: add binding doc
 for generic power sequence library
Date: Fri, 8 Jul 2016 10:39:13 +0800
Message-ID: <20160708023913.GD27779@shlinux2>
References: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
 <1467882892-27589-2-git-send-email-peter.chen@nxp.com>
 <1467884834.4236.36.camel@pengutronix.de>
 <577EEB63.3020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35612 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbcGHCqp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2016 22:46:45 -0400
Content-Disposition: inline
In-Reply-To: <577EEB63.3020007@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Peter Chen <peter.chen@nxp.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, stephen.boyd@linaro.org, oscar@naiandei.net, arnd@arndb.de, pawel.moll@arm.com, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, k.kozlowski@samsung.com, linux-usb@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org, mail@maciej.szmigiero.name, broonie@kernel.org, stern@rowland.harvard.edu, festevam@gmail.com, troy.kisky@boundarydevices.com, shawnguo@kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org

On Thu, Jul 07, 2016 at 04:53:07PM -0700, Joshua Clayton wrote:
> 
> 
> On 07/07/2016 02:47 AM, Philipp Zabel wrote:
> > Am Donnerstag, den 07.07.2016, 17:14 +0800 schrieb Peter Chen:
> >> Add binding doc for generic power sequence library.
> >>
> >> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> >> ---
> >>  .../bindings/power/pwrseq/pwrseq-generic.txt       | 56 ++++++++++++++++++++++
> >>  1 file changed, 56 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> >> new file mode 100644
> >> index 0000000..4b23834
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> >> @@ -0,0 +1,56 @@
> >> +The generic power sequence library
> >> +
> >> +Some hard-wired USB/MMC devices need to do power sequence to let the
> >> +device work normally, the typical power sequence like: enable USB
> >> +PHY clock, toggle reset pin, etc. But current Linux USB driver
> >> +lacks of such code to do it, it may cause some hard-wired USB devices
> >> +works abnormal or can't be recognized by controller at all. The
> >> +power sequence will be done before this device can be found at USB
> >> +bus.
> >> +
> >> +The power sequence properties is under the device node.
> >> +
> >> +Required properties:
> >> +- power-sequence: this device needs to do power sequence before enumeration
> >> +
> >> +Optional properties:
> >> +- clocks: the input clock for device.
> >> +- clock-name: must be "pwrseq-clk"
> > The "-clk" in the clock name is redundant.
> >
> >> +- pwrseq-reset-gpios: Should specify the GPIO for reset.
> >> +- pwrseq-reset-duration-us: the duration in microsecond for assert reset signal.
> > I understand you want to make it explicit that this GPIO is for the
> > pwrseq library, but are we really gaining anything over just calling
> > these reset-gpios and reset-duration-us?
> > The same applies to the clock name above.
> using  reset-gpios makes sense to  me too.
> The above "power-sequence" might then be better called "reset-on-init",
> But really, if a device has a reset gpio shouldn't the default behavior be to
> reset it on boot and when coming back from sleep?
> Is a special property even needed?

The power sequence does not include reset process only, it may include clock
and power as well.

-- 

Best Regards,
Peter Chen
