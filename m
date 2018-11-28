From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 12/14] mfd: axp20x: use explicit bit defines
Date: Wed, 28 Nov 2018 09:33:35 +0000
Message-ID: <20181128093335.GB4272@dell>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <a0f3f8a763d948159de122b8071b5de4bfc785c0.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a0f3f8a763d948159de122b8071b5de4bfc785c0.1543245984.git-series.plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org

On Mon, 26 Nov 2018, Priit Laes wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> The AXP20X_OFF define is an actual specific bit, define it as such.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/mfd/axp20x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
