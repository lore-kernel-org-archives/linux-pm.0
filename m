From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: power: supply: axp20x: add AXP813 AC
 power DT binding
Date: Fri, 12 Oct 2018 10:44:54 -0500
Message-ID: <20181012154454.GA15048@bogus>
References: <20181008181908.9456-1-oskari@lemmela.net>
 <20181008181908.9456-2-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008181908.9456-2-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon,  8 Oct 2018 21:19:02 +0300, Oskari Lemmela wrote:
> The AXP803/AXP813 AC power supply can limit input current and voltage.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  .../devicetree/bindings/power/supply/axp20x_ac_power.txt       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
