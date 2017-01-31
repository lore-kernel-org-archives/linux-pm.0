From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/8] power: add power sequence library
Date: Wed, 1 Feb 2017 00:10:17 +0100
Message-ID: <CAJZ5v0iR7p-ftUzvVwW96Y55A=vYG8_UbhjuA4vw0BFFZ8a9iw@mail.gmail.com>
References: <1483425211-14473-1-git-send-email-peter.chen@nxp.com> <1483425211-14473-3-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33002 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdAaXKS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 18:10:18 -0500
In-Reply-To: <1483425211-14473-3-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, p.zabel@pengutronix.de, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>

On Tue, Jan 3, 2017 at 7:33 AM, Peter Chen <peter.chen@nxp.com> wrote:
> We have an well-known problem that the device needs to do some power
> sequence before it can be recognized by related host, the typical
> example like hard-wired mmc devices and usb devices.
>
> This power sequence is hard to be described at device tree and handled by
> related host driver, so we have created a common power sequence
> library to cover this requirement. The core code has supplied
> some common helpers for host driver, and individual power sequence
> libraries handle kinds of power sequence for devices. The pwrseq
> librares always need to allocate extra instance for compatible
> string match.
>
> pwrseq_generic is intended for general purpose of power sequence, which
> handles gpios and clocks currently, and can cover other controls in
> future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> if only one power sequence is needed, else call of_pwrseq_on_list
> /of_pwrseq_off_list instead (eg, USB hub driver).
>
> For new power sequence library, it can add its compatible string
> to pwrseq_of_match_table, then the pwrseq core will match it with
> DT's, and choose this library at runtime.
>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Quite honestly, I have a really hard time with trying to follow this
code and the total lack of documentation makes it even harder.  In
particular, the generic power sequence code is not even commented at
all, so it really is hard to say how this is going to work, let alone
deciding whether or not to apply it.

Plus, of course, the USB core changes must be acked by the maintainer
thereof for me to be able to handle the series.

But at this point I basically need you to explain the design to me, please.

Thanks,
Rafael
