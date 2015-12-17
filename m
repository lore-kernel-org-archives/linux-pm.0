From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v4 0/4] Raspberry Pi power domains
Date: Thu, 17 Dec 2015 14:32:48 -0800
Message-ID: <7hh9jg7lkf.fsf@deeprootsystems.com>
References: <1450312009-1791-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35017 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933884AbbLQWcv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 17:32:51 -0500
Received: by mail-pa0-f48.google.com with SMTP id jx14so20413806pad.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Dec 2015 14:32:50 -0800 (PST)
In-Reply-To: <1450312009-1791-1-git-send-email-eric@anholt.net> (Eric Anholt's
	message of "Wed, 16 Dec 2015 16:26:45 -0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: linux-rpi-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>

Eric Anholt <eric@anholt.net> writes:

> Update from v3 to move the driver under drivers/soc.  I've placed it
> under drivers/soc/bcm since that's how the other drivers under
> drivers/soc are structured.

Thanks, I like it better under drivers/soc too.

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Kevin

> Alexander Aring (3):
>   ARM: bcm2835: add rpi power domain driver
>   dt-bindings: add rpi power domain driver bindings
>   ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.
>
> Eric Anholt (1):
>   ARM: bcm2835: Define two new packets from the latest firmware.
>
>  .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt |  47 ++++
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 +
>  arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
>  drivers/soc/Kconfig                                |   1 +
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/bcm/Kconfig                            |   9 +
>  drivers/soc/bcm/Makefile                           |   1 +
>  drivers/soc/bcm/raspberrypi-power.c                | 247 +++++++++++++++++++++
>  include/dt-bindings/soc/raspberrypi-power.h        |  41 ++++
>  include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
>  10 files changed, 361 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
>  create mode 100644 drivers/soc/bcm/Kconfig
>  create mode 100644 drivers/soc/bcm/Makefile
>  create mode 100644 drivers/soc/bcm/raspberrypi-power.c
>  create mode 100644 include/dt-bindings/soc/raspberrypi-power.h
