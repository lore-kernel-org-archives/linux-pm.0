From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Date: Mon, 10 Dec 2018 06:27:39 +0000
Message-ID: <20181210062739.GP26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181120175211.3913-9-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Quentin Schulz <quentin.schulz@bootlin.com>, Vasily Khoruzhick <anarsoul@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 20 Nov 2018, Oskari Lemmela wrote:

> Parts of the AXP803 are compatible with their counterparts on the AXP813.
> These include the GPIO, ADC, AC and battery power supplies.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/mfd/axp20x.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
