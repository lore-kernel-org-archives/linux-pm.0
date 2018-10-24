From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 02/11] dt-bindings: power: supply: axp20x: add AXP803
 power bindings
Date: Wed, 24 Oct 2018 08:55:24 -0500
Message-ID: <20181024135524.GA30329@bogus>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-3-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181023185330.10472-3-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 23, 2018 at 09:53:21PM +0300, Oskari Lemmela wrote:
> The AXP803 power supplies are compatible with AXP813, but
> add specific compatibles for them.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  .../devicetree/bindings/power/supply/axp20x_ac_power.txt         | 1 +
>  .../devicetree/bindings/power/supply/axp20x_battery.txt          | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
