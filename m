From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH 2/8] power: add power sequence library
Date: Fri, 3 Feb 2017 16:16:15 +0800
Message-ID: <20170203081614.GA24614@b29397-desktop>
References: <1483425211-14473-1-git-send-email-peter.chen@nxp.com>
 <1483425211-14473-3-git-send-email-peter.chen@nxp.com>
 <CAJZ5v0iR7p-ftUzvVwW96Y55A=vYG8_UbhjuA4vw0BFFZ8a9iw@mail.gmail.com>
 <20170201080817.GD17968@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33888 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdBCIQj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2017 03:16:39 -0500
Content-Disposition: inline
In-Reply-To: <20170201080817.GD17968@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Chen <peter.chen@nxp.com>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, p.zabel@pengutronix.de, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sas

On Wed, Feb 01, 2017 at 09:08:17AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 01, 2017 at 12:10:17AM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 3, 2017 at 7:33 AM, Peter Chen <peter.chen@nxp.com> wrote:
> > > We have an well-known problem that the device needs to do some power
> > > sequence before it can be recognized by related host, the typical
> > > example like hard-wired mmc devices and usb devices.
> > >
> > > This power sequence is hard to be described at device tree and handled by
> > > related host driver, so we have created a common power sequence
> > > library to cover this requirement. The core code has supplied
> > > some common helpers for host driver, and individual power sequence
> > > libraries handle kinds of power sequence for devices. The pwrseq
> > > librares always need to allocate extra instance for compatible
> > > string match.
> > >
> > > pwrseq_generic is intended for general purpose of power sequence, which
> > > handles gpios and clocks currently, and can cover other controls in
> > > future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > > if only one power sequence is needed, else call of_pwrseq_on_list
> > > /of_pwrseq_off_list instead (eg, USB hub driver).
> > >
> > > For new power sequence library, it can add its compatible string
> > > to pwrseq_of_match_table, then the pwrseq core will match it with
> > > DT's, and choose this library at runtime.
> > >
> > > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > 
> > Quite honestly, I have a really hard time with trying to follow this
> > code and the total lack of documentation makes it even harder. 

Sorry about that, Is it ok I add the design doc at:
Documentation/power/power-sequence/design.rst?

> > particular, the generic power sequence code is not even commented at
> > all, 

The generic power sequence code just implements the APIs which are 
called at power/pwrseq/core.c, and those API are commented at
include/linux/power/pwrseq.h. Anyway, I will add more comments at it.
	
-- 

Best Regards,
Peter Chen
