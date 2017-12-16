From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v3 05/11] thermal: armada: Add support for Armada AP806
Date: Sun, 17 Dec 2017 00:22:34 +0200
Message-ID: <20171216222234.xp5gybcbfymouvvd@tarshish>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-6-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:58016 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756888AbdLPWWi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Dec 2017 17:22:38 -0500
Content-Disposition: inline
In-Reply-To: <20171214103011.24713-6-miquel.raynal@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>

Hi Miquèl,

On Thu, Dec 14, 2017 at 11:30:05AM +0100, Miquel Raynal wrote:
> From: Baruch Siach <baruch@tkos.co.il>
> 
> The AP806 component is integrated in the Armada 8k and 7k lines of
> processors.
> 
> The thermal sensor sample field on the status register is a signed
> value. Extend armada_get_temp() to handle signed values.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---

[...]

> +static void armada_ap806_init_sensor(struct platform_device *pdev,
> +				     struct armada_thermal_priv *priv)
> +{
> +	u32 reg;
> +
> +	if (!priv->control0) {
> +		dev_err(&pdev->dev,
> +			"Cannot access to control0 (control LSB) register\n");
> +		return;
> +	}

With the probe time control area size validation this check would not be 
needed.

baruch

> +
> +	reg = readl_relaxed(priv->control0);
> +	reg &= ~CONTROL0_TSEN_RESET;
> +	reg |= CONTROL0_TSEN_START | CONTROL0_TSEN_ENABLE;
> +	writel(reg, priv->control0);
> +	msleep(10);
> +}

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
