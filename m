From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v14 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Date: Wed, 8 May 2019 12:24:19 +0100
Message-ID: <20190508112419.GU3995@dell>
References: <cover.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
 <a666794d68b846a5527fc37e80cce5010615f54a.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a666794d68b846a5527fc37e80cce5010615f54a.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, heikki.haikola@fi.rohmeurop
List-Id: linux-pm@vger.kernel.org

On Thu, 02 May 2019, Matti Vaittinen wrote:

> ROHM BD70528MWV is an ultra-low quiescent current general
> purpose single-chip power management IC for battery-powered
> portable devices.
> 
> Add MFD core which enables chip access for following subdevices:
> 	- regulators/LED drivers
> 	- battery-charger
> 	- gpios
> 	- 32.768kHz clk
> 	- RTC
> 	- watchdog
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> Changelog v14: No changes
> 
>  drivers/mfd/Kconfig              |  17 ++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/rohm-bd70528.c       | 316 ++++++++++++++++++++++++
>  include/linux/mfd/rohm-bd70528.h | 408 +++++++++++++++++++++++++++++++
>  4 files changed, 742 insertions(+)
>  create mode 100644 drivers/mfd/rohm-bd70528.c
>  create mode 100644 include/linux/mfd/rohm-bd70528.h

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
