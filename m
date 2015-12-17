From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/4] ARM: bcm2835: add rpi power domain driver
Date: Thu, 17 Dec 2015 17:28:20 +0100
Message-ID: <CAPDyKFp5JfHmNw+ryoAnu-0XANcxW_pyNL_GUFUw7sBQmU+WDA@mail.gmail.com>
References: <1450312009-1791-1-git-send-email-eric@anholt.net>
	<1450312009-1791-3-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450312009-1791-3-git-send-email-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: linux-rpi-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>
List-Id: linux-pm@vger.kernel.org

On 17 December 2015 at 01:26, Eric Anholt <eric@anholt.net> wrote:
> From: Alexander Aring <alex.aring@gmail.com>
>
> This patch adds support for several power domains on Raspberry Pi,
> including USB (so it can be enabled even if the bootloader didn't do
> it), and graphics.
>
> This patch is the combined work of Eric Anholt (who wrote USB support
> inside of the Raspberry Pi firmware driver, and wrote the non-USB
> domain support) and Alexander Aring (who separated the original USB
> work out from the firmware driver).
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> v2: Add support for power domains other than USB, using the new
>     firmware interface, reword commit message (changes by Eric)
>
> v3: Restructure as a builtin driver, and drop
>     of_genpd_add_provider_onecell error handling to avoid
>     pm_genpd_exit() dependency until that API can be settled.  Clean
>     up copyright header, add missing ISP initialization, and fix typo
>     in transposer's name.
>
> v4: Move to drivers/soc/bcm/, move include to dt-bindings/soc/, set up
>     Makefile for the drivers/soc/bcm following clk/'s model.
>
>  drivers/soc/Kconfig                         |   1 +
>  drivers/soc/Makefile                        |   1 +
>  drivers/soc/bcm/Kconfig                     |   9 +
>  drivers/soc/bcm/Makefile                    |   1 +
>  drivers/soc/bcm/raspberrypi-power.c         | 247 ++++++++++++++++++++++++++++
>  include/dt-bindings/soc/raspberrypi-power.h |  41 +++++

There is currently a directory which I think may be better.
include/dt-bindings/power/*

Besides this nitpick, I think this looks good. You may add my:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
