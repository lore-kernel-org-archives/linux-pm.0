From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
Date: Wed, 24 Oct 2018 08:56:33 -0500
Message-ID: <20181024135633.GA342@bogus>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-5-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181023185330.10472-5-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:
> The AXP803 ADC is compatible with AXP813 ADC, but add
> specific compatible for it.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
