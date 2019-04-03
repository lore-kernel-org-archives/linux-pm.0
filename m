From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v11 1/8] mfd: regulator: clk: split rohm-bd718x7.h
Date: Wed, 3 Apr 2019 07:19:16 +0100
Message-ID: <20190403061916.GL4187@dell>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <81d7136a77a2786c122a1cbf3289c96c51ded79f.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81d7136a77a2786c122a1cbf3289c96c51ded79f.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, heikki.haikola@fi.rohmeurop
List-Id: linux-pm@vger.kernel.org

On Mon, 25 Mar 2019, Matti Vaittinen wrote:

> Split the bd718x7.h to ROHM common and bd718x7 specific parts
> so that we do not need to add same things in every new ROHM
> PMIC header. Please note that this change requires changes also
> in bd718x7 sub-device drivers for regulators and clk.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk-bd718x7.c             |  6 +++---
>  drivers/mfd/rohm-bd718x7.c            | 23 ++++++++++++-----------
>  drivers/regulator/bd718x7-regulator.c | 25 +++++++++++++------------
>  include/linux/mfd/rohm-bd718x7.h      | 22 ++++++++--------------
>  include/linux/mfd/rohm-generic.h      | 20 ++++++++++++++++++++
>  5 files changed, 56 insertions(+), 40 deletions(-)
>  create mode 100644 include/linux/mfd/rohm-generic.h

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
