From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 10/11] mfd: axp20x: Add AC power supply cell for AXP813
Date: Thu, 25 Oct 2018 11:23:51 +0100
Message-ID: <20181025102351.GT4939@dell>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-11-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181023185330.10472-11-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Oct 2018, Oskari Lemmela wrote:

> As axp20x-ac-power-supply now supports AXP813, add a cell for it.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/mfd/axp20x.c | 5 +++++
>  1 file changed, 5 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
