From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/4] Raspberry Pi power domains
Date: Thu, 17 Dec 2015 17:33:30 +0100
Message-ID: <CAPDyKFp=ykY4dFTxeq+et6z5ek-UYGnBOFG7Po0pSUL7jSYc8g@mail.gmail.com>
References: <1450215622-27394-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35657 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966192AbbLQQdb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 11:33:31 -0500
Received: by mail-yk0-f178.google.com with SMTP id v6so25003743ykc.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Dec 2015 08:33:30 -0800 (PST)
In-Reply-To: <1450215622-27394-1-git-send-email-eric@anholt.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rpi-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>

On 15 December 2015 at 22:40, Eric Anholt <eric@anholt.net> wrote:
> Since the pm_genpd_exit() patch is still going through review, and
> other drivers in the tree just ignore the error cases, Ulf offered to
> merge the series as a builtin driver not depending on that interface.
> We still avoid dangling pointer references, by just continuing with
> probing if of_genpd_add_provider_onecell() fails.  We can easily go
> back and update the driver when a pm_genpd_exit() lands.
>
> Alexander Aring (3):
>   ARM: bcm2835: add rpi power domain driver
>   dt-bindings: add rpi power domain driver bindings
>   ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.
>
> Eric Anholt (1):
>   ARM: bcm2835: Define two new packets from the latest firmware.
>
>  .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  47 ++++
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 +
>  arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
>  arch/arm/mach-bcm/Kconfig                          |  10 +
>  arch/arm/mach-bcm/Makefile                         |   1 +
>  arch/arm/mach-bcm/raspberrypi-power.c              | 247 +++++++++++++++++++++
>  include/dt-bindings/arm/raspberrypi-power.h        |  41 ++++
>  include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
>  8 files changed, 360 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>  create mode 100644 include/dt-bindings/arm/raspberrypi-power.h
>
> --
> 2.6.2
>

Besides a nitpick for patch2, I would also reverse the order of patch3
and patch2. DT docs should go in before the actual parsing of the new
bindings/compatibles.

Anyway, for the hole series, you may add my:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
