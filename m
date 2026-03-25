Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E13EC2E3;
	Wed, 25 Mar 2026 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451412; cv=none; b=gKcsjj74UnUe6VbdAMY9kAmQuK1lIAGIeME7dTYN0udqPb01HI5F10NMbEd85kl50Z2/ktOCwlovmV/3hN4+1nHd/TLeZp4wTo5Feck2buGnVV6QFLATHNNIm9efKdJ4Lk+4Mn0+ZpXqqi/N+TB8tXOa0JiTIo8BAWRJI0+LNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451412; c=relaxed/simple;
	bh=L0NZKuey/qtbdcYAIlwJ3QmTPmbqw9VkoZc/ieR/GoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMsnP3gTiE+1CNJLKE5YB9P++UntK63yx+CfRaWsR4UdV2QFbLZtHfX6ZwqJoR6RGcAg1oBOJ/kOe1va12xpkwhOO1J7GTpJodkdBls1lnN19wy56D4LOrFQ/1LcqVA/oQmgH3bkrTVIWNV1nem88aMnUjdsKBeXboLPeVg7SHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtgLPc99; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtgLPc99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1655C4CEF7;
	Wed, 25 Mar 2026 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774451411;
	bh=L0NZKuey/qtbdcYAIlwJ3QmTPmbqw9VkoZc/ieR/GoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtgLPc99SGspJufCX4AksCgN9iaFZv9EnGlI38e1Rp3ZcCevNC5a8xnbW/71r9/o/
	 YgEEvLhgVjQmYFDoqYPvnXbdqgkeIz/2AeVbryqVjseiBuKj9Q+ZUB3/o6XF/s03Qe
	 IfYszNMabMHO/GPGJyWVroFsYPHc1D1jPw9Urz33rPmxfe8oEbD7yY25uwjM4gV/fU
	 L+47ahSqNvUVLnmXDIf5eZjlOviPbsnBCJuAXlBCDcVMMeFu+Ac/f6DNP76LzIHnPG
	 zQ2eHlaeuDfyy+ww1CwEdBN1nSZBeEZpE0pJ5L4fqlpK3PrpacuiYXB8RIs2R8B3T0
	 VpMPMlI/U2GwQ==
Date: Wed, 25 Mar 2026 15:10:04 +0000
From: Lee Jones <lee@kernel.org>
To: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>
Subject: Re: [PATCH RESEND v8 3/6] mfd: max77759: add register bitmasks and
 modify irq configs for charger
Message-ID: <20260325151004.GD1141718@google.com>
References: <20260314-max77759-charger-v8-0-226ca5f8c7d2@google.com>
 <20260314-max77759-charger-v8-3-226ca5f8c7d2@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260314-max77759-charger-v8-3-226ca5f8c7d2@google.com>

On Sat, 14 Mar 2026, Amit Sunil Dhamne via B4 Relay wrote:

> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Add register bitmasks for charger function.
> 
> In addition split the charger IRQs further such that each bit represents
> an IRQ downstream of charger regmap irq chip. In addition populate the
> ack_base to offload irq ack to the regmap irq chip framework.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: André Draszik <andre.draszik@linaro.org>
> ---
>  drivers/mfd/max77759.c       |  91 ++++++++++++++++++++--
>  include/linux/mfd/max77759.h | 176 ++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 230 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
> index a7efe233ec8c..288746f675b8 100644
> --- a/drivers/mfd/max77759.c
> +++ b/drivers/mfd/max77759.c
> @@ -201,8 +201,24 @@ static const struct regmap_config max77759_regmap_config_charger = {
>   *         - SYSUVLO_INT
>   *         - FSHIP_NOT_RD
>   *     - CHGR_INT: charger
> - *       - CHG_INT
> - *       - CHG_INT2
> + *       - INT1
> + *         - AICL
> + *         - CHGIN
> + *         - WCIN
> + *         - CHG
> + *         - BAT
> + *         - INLIM
> + *         - THM2
> + *         - BYP
> + *       - INT2
> + *         - INSEL
> + *         - SYS_UVLO1
> + *         - SYS_UVLO2
> + *         - BAT_OILO
> + *         - CHG_STA_CC
> + *         - CHG_STA_CV
> + *         - CHG_STA_TO
> + *         - CHG_STA_DONE
>   */
>  enum {
>  	MAX77759_INT_MAXQ,
> @@ -256,8 +286,38 @@ static const struct regmap_irq max77759_topsys_irqs[] = {
>  };
>  
>  static const struct regmap_irq max77759_chgr_irqs[] = {
> -	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_1, 0, GENMASK(7, 0)),
> -	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_2, 1, GENMASK(7, 0)),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_AICL, 0,
> +		       MAX77759_CHGR_REG_CHG_INT_AICL),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_CHGIN, 0,
> +		       MAX77759_CHGR_REG_CHG_INT_CHGIN),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_WCIN, 0,
> +		       MAX77759_CHGR_REG_CHG_INT_WCIN),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_CHG, 0,
> +		       MAX77759_CHGR_REG_CHG_INT_CHG),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_BAT, 0,
> +		       MAX77759_CHGR_REG_CHG_INT_BAT),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_INLIM, 0,
> +		       MAX77759_CHGR_REG_CHG_INT_INLIM),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_THM2, 0,
> +		       MAX77759_CHGR_REG_CHG_INT_THM2),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT1_BYP, 0,
> +		       MAX77759_CHGR_REG_CHG_INT_BYP),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_INSEL, 1,
> +		       MAX77759_CHGR_REG_CHG_INT2_INSEL),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_SYS_UVLO1, 1,
> +		       MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO1),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_SYS_UVLO2, 1,
> +		       MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO2),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_BAT_OILO, 1,
> +		       MAX77759_CHGR_REG_CHG_INT2_BAT_OILO),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_CC, 1,
> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_CV, 1,
> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_TO, 1,
> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO),
> +	REGMAP_IRQ_REG(MAX77759_CHGR_INT2_CHG_STA_DONE, 1,
> +		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE),
>  };
>  
>  static const struct regmap_irq_chip max77759_pmic_irq_chip = {
> @@ -302,6 +362,7 @@ static const struct regmap_irq_chip max77759_chrg_irq_chip = {

Minor nit: The new code in this patch consistently uses "chgr" as the prefix
for charger-related names. To improve consistency, how about we rename this
struct to `max77759_chgr_irq_chip`?

>  	.domain_suffix = "CHGR",
>  	.status_base = MAX77759_CHGR_REG_CHG_INT,
>  	.mask_base = MAX77759_CHGR_REG_CHG_INT_MASK,
> +	.ack_base = MAX77759_CHGR_REG_CHG_INT,
>  	.num_regs = 2,
>  	.irqs = max77759_chgr_irqs,
>  	.num_irqs = ARRAY_SIZE(max77759_chgr_irqs),
> @@ -325,8 +386,22 @@ static const struct resource max77759_gpio_resources[] = {
>  };
>  
>  static const struct resource max77759_charger_resources[] = {
> -	DEFINE_RES_IRQ_NAMED(MAX77759_CHARGER_INT_1, "INT1"),
> -	DEFINE_RES_IRQ_NAMED(MAX77759_CHARGER_INT_2, "INT2"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_AICL,         "AICL"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_CHGIN,        "CHGIN"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_WCIN,         "WCIN"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_CHG,          "CHG"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_BAT,          "BAT"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_INLIM,        "INLIM"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_THM2,         "THM2"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT1_BYP,          "BYP"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_INSEL,        "INSEL"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_SYS_UVLO1,    "SYS_UVLO1"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_SYS_UVLO2,    "SYS_UVLO2"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_BAT_OILO,     "BAT_OILO"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_CC,   "CHG_STA_CC"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_CV,   "CHG_STA_CV"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_TO,   "CHG_STA_TO"),
> +	DEFINE_RES_IRQ_NAMED(MAX77759_CHGR_INT2_CHG_STA_DONE, "CHG_STA_DONE"),
>  };
>  
>  static const struct mfd_cell max77759_cells[] = {
> diff --git a/include/linux/mfd/max77759.h b/include/linux/mfd/max77759.h
> index c6face34e385..fd5aea21ab2e 100644
> --- a/include/linux/mfd/max77759.h
> +++ b/include/linux/mfd/max77759.h
> @@ -59,35 +59,65 @@
>  #define MAX77759_MAXQ_REG_AP_DATAIN0            0xb1
>  #define MAX77759_MAXQ_REG_UIC_SWRST             0xe0
>  
> -#define MAX77759_CHGR_REG_CHG_INT               0xb0
> -#define MAX77759_CHGR_REG_CHG_INT2              0xb1
> -#define MAX77759_CHGR_REG_CHG_INT_MASK          0xb2
> -#define MAX77759_CHGR_REG_CHG_INT2_MASK         0xb3
> -#define MAX77759_CHGR_REG_CHG_INT_OK            0xb4
> -#define MAX77759_CHGR_REG_CHG_DETAILS_00        0xb5
> -#define MAX77759_CHGR_REG_CHG_DETAILS_01        0xb6
> -#define MAX77759_CHGR_REG_CHG_DETAILS_02        0xb7
> -#define MAX77759_CHGR_REG_CHG_DETAILS_03        0xb8
> -#define MAX77759_CHGR_REG_CHG_CNFG_00           0xb9
> -#define MAX77759_CHGR_REG_CHG_CNFG_01           0xba
> -#define MAX77759_CHGR_REG_CHG_CNFG_02           0xbb
> -#define MAX77759_CHGR_REG_CHG_CNFG_03           0xbc
> -#define MAX77759_CHGR_REG_CHG_CNFG_04           0xbd
> -#define MAX77759_CHGR_REG_CHG_CNFG_05           0xbe
> -#define MAX77759_CHGR_REG_CHG_CNFG_06           0xbf
> -#define MAX77759_CHGR_REG_CHG_CNFG_07           0xc0
> -#define MAX77759_CHGR_REG_CHG_CNFG_08           0xc1
> -#define MAX77759_CHGR_REG_CHG_CNFG_09           0xc2
> -#define MAX77759_CHGR_REG_CHG_CNFG_10           0xc3
> -#define MAX77759_CHGR_REG_CHG_CNFG_11           0xc4
> -#define MAX77759_CHGR_REG_CHG_CNFG_12           0xc5
> -#define MAX77759_CHGR_REG_CHG_CNFG_13           0xc6
> -#define MAX77759_CHGR_REG_CHG_CNFG_14           0xc7
> -#define MAX77759_CHGR_REG_CHG_CNFG_15           0xc8
> -#define MAX77759_CHGR_REG_CHG_CNFG_16           0xc9
> -#define MAX77759_CHGR_REG_CHG_CNFG_17           0xca
> -#define MAX77759_CHGR_REG_CHG_CNFG_18           0xcb
> -#define MAX77759_CHGR_REG_CHG_CNFG_19           0xcc
> +#define MAX77759_CHGR_REG_CHG_INT                      0xb0
> +#define   MAX77759_CHGR_REG_CHG_INT_AICL               BIT(7)
> +#define   MAX77759_CHGR_REG_CHG_INT_CHGIN              BIT(6)
> +#define   MAX77759_CHGR_REG_CHG_INT_WCIN               BIT(5)
> +#define   MAX77759_CHGR_REG_CHG_INT_CHG                BIT(4)
> +#define   MAX77759_CHGR_REG_CHG_INT_BAT                BIT(3)
> +#define   MAX77759_CHGR_REG_CHG_INT_INLIM              BIT(2)
> +#define   MAX77759_CHGR_REG_CHG_INT_THM2               BIT(1)
> +#define   MAX77759_CHGR_REG_CHG_INT_BYP                BIT(0)
> +#define MAX77759_CHGR_REG_CHG_INT2                     0xb1
> +#define   MAX77759_CHGR_REG_CHG_INT2_INSEL             BIT(7)
> +#define   MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO1         BIT(6)
> +#define   MAX77759_CHGR_REG_CHG_INT2_SYS_UVLO2         BIT(5)
> +#define   MAX77759_CHGR_REG_CHG_INT2_BAT_OILO          BIT(4)
> +#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC        BIT(3)
> +#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV        BIT(2)
> +#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO        BIT(1)
> +#define   MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE      BIT(0)
> +#define MAX77759_CHGR_REG_CHG_INT_MASK                 0xb2
> +#define MAX77759_CHGR_REG_CHG_INT2_MASK                0xb3
> +#define MAX77759_CHGR_REG_CHG_INT_OK                   0xb4
> +#define MAX77759_CHGR_REG_CHG_DETAILS_00               0xb5
> +#define   MAX77759_CHGR_REG_CHG_DETAILS_00_CHGIN_DTLS  GENMASK(6, 5)
> +#define MAX77759_CHGR_REG_CHG_DETAILS_01               0xb6
> +#define   MAX77759_CHGR_REG_CHG_DETAILS_01_BAT_DTLS    GENMASK(6, 4)
> +#define   MAX77759_CHGR_REG_CHG_DETAILS_01_CHG_DTLS    GENMASK(3, 0)
> +#define MAX77759_CHGR_REG_CHG_DETAILS_02               0xb7
> +#define   MAX77759_CHGR_REG_CHG_DETAILS_02_CHGIN_STS   BIT(5)
> +#define MAX77759_CHGR_REG_CHG_DETAILS_03               0xb8
> +#define MAX77759_CHGR_REG_CHG_CNFG_00                  0xb9
> +#define   MAX77759_CHGR_REG_CHG_CNFG_00_MODE           GENMASK(3, 0)
> +#define MAX77759_CHGR_REG_CHG_CNFG_01                  0xba
> +#define MAX77759_CHGR_REG_CHG_CNFG_02                  0xbb
> +#define   MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC          GENMASK(5, 0)
> +#define MAX77759_CHGR_REG_CHG_CNFG_03                  0xbc
> +#define MAX77759_CHGR_REG_CHG_CNFG_04                  0xbd
> +#define   MAX77759_CHGR_REG_CHG_CNFG_04_CHG_CV_PRM     GENMASK(5, 0)
> +#define MAX77759_CHGR_REG_CHG_CNFG_05                  0xbe
> +#define MAX77759_CHGR_REG_CHG_CNFG_06                  0xbf
> +#define   MAX77759_CHGR_REG_CHG_CNFG_06_CHGPROT        GENMASK(3, 2)
> +#define MAX77759_CHGR_REG_CHG_CNFG_07                  0xc0
> +#define MAX77759_CHGR_REG_CHG_CNFG_08                  0xc1
> +#define MAX77759_CHGR_REG_CHG_CNFG_09                  0xc2
> +#define   MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM     GENMASK(6, 0)
> +#define MAX77759_CHGR_REG_CHG_CNFG_10                  0xc3
> +#define MAX77759_CHGR_REG_CHG_CNFG_11                  0xc4
> +#define MAX77759_CHGR_REG_CHG_CNFG_12                  0xc5
> +/* Wireless Charging input channel select */
> +#define   MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL        BIT(6)
> +/* CHGIN/USB input channel select */
> +#define   MAX77759_CHGR_REG_CHG_CNFG_12_CHGINSEL       BIT(5)
> +#define MAX77759_CHGR_REG_CHG_CNFG_13                  0xc6
> +#define MAX77759_CHGR_REG_CHG_CNFG_14                  0xc7
> +#define MAX77759_CHGR_REG_CHG_CNFG_15                  0xc8
> +#define MAX77759_CHGR_REG_CHG_CNFG_16                  0xc9
> +#define MAX77759_CHGR_REG_CHG_CNFG_17                  0xca
> +#define MAX77759_CHGR_REG_CHG_CNFG_18                  0xcb
> +#define   MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN          BIT(0)
> +#define MAX77759_CHGR_REG_CHG_CNFG_19                  0xcc
>  
>  /* MaxQ opcodes for max77759_maxq_command() */
>  #define MAX77759_MAXQ_OPCODE_MAXLENGTH (MAX77759_MAXQ_REG_AP_DATAOUT32 - \
> @@ -101,6 +131,94 @@
>  #define MAX77759_MAXQ_OPCODE_USER_SPACE_READ     0x81
>  #define MAX77759_MAXQ_OPCODE_USER_SPACE_WRITE    0x82
>  
> +/*
> + * Charger Input Status
> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE:
> + *     Charger input voltage (Vchgin) < Under Voltage Threshold (Vuvlo)
> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE: Vchgin > Vuvlo and
> + *     Vchgin < (Battery Voltage (Vbatt) + system voltage (Vsys))
> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_OVERVOLTAGE:
> + *     Vchgin > Over Voltage threshold (Vovlo)
> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_VALID:
> + *     Vchgin > Vuvlo, Vchgin < Vovlo and Vchgin > (Vsys + Vbatt)
> + */
> +enum max77759_chgr_chgin_dtls_status {
> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE,
> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE,
> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_OVERVOLTAGE,
> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_VALID,
> +};
> +
> +/*
> + * Battery Details
> + * @MAX77759_CHGR_BAT_DTLS_NO_BATT_CHG_SUSP:
> + *     No battery and the charger suspended
> + * @MAX77759_CHGR_BAT_DTLS_DEAD_BATTERY: Vbatt < Vtrickle
> + * @MAX77759_CHGR_BAT_DTLS_BAT_CHG_TIMER_FAULT:
> + *     Charging suspended due to timer fault
> + * @MAX77759_CHGR_BAT_DTLS_BAT_OKAY:
> + *     Battery okay and Vbatt > Min Sys Voltage (Vsysmin)
> + * @MAX77759_CHGR_BAT_DTLS_BAT_UNDERVOLTAGE:
> + *     Battery is okay. Vtrickle < Vbatt < Vsysmin
> + * @MAX77759_CHGR_BAT_DTLS_BAT_OVERVOLTAGE:
> + *     Battery voltage > Overvoltage threshold
> + * @MAX77759_CHGR_BAT_DTLS_BAT_OVERCURRENT:
> + *     Battery current exceeds overcurrent threshold
> + * @MAX77759_CHGR_BAT_DTLS_BAT_ONLY_MODE:
> + *     Battery only mode and battery level not available
> + */
> +enum max77759_chgr_bat_dtls_states {
> +	MAX77759_CHGR_BAT_DTLS_NO_BATT_CHG_SUSP,
> +	MAX77759_CHGR_BAT_DTLS_DEAD_BATTERY,
> +	MAX77759_CHGR_BAT_DTLS_BAT_CHG_TIMER_FAULT,
> +	MAX77759_CHGR_BAT_DTLS_BAT_OKAY,
> +	MAX77759_CHGR_BAT_DTLS_BAT_UNDERVOLTAGE,
> +	MAX77759_CHGR_BAT_DTLS_BAT_OVERVOLTAGE,
> +	MAX77759_CHGR_BAT_DTLS_BAT_OVERCURRENT,
> +	MAX77759_CHGR_BAT_DTLS_BAT_ONLY_MODE,
> +};
> +
> +/*
> + * Charger Details
> + * @MAX77759_CHGR_CHG_DTLS_PREQUAL: Charger in prequalification mode
> + * @MAX77759_CHGR_CHG_DTLS_CC:      Charger in fast charge const curr mode
> + * @MAX77759_CHGR_CHG_DTLS_CV:      Charger in fast charge const voltage mode
> + * @MAX77759_CHGR_CHG_DTLS_TO:      Charger is in top off mode
> + * @MAX77759_CHGR_CHG_DTLS_DONE:    Charger is done
> + * @MAX77759_CHGR_CHG_DTLS_RSVD_1:  Reserved
> + * @MAX77759_CHGR_CHG_DTLS_TIMER_FAULT:   Charger is in timer fault mode
> + * @MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM:
> + *     Charger is suspended as bettery removal detected

Typo here, s/bettery/battery/.

> + * @MAX77759_CHGR_CHG_DTLS_OFF:
> + *     Charger is off. Input invalid or charger disabled
> + * @MAX77759_CHGR_CHG_DTLS_RSVD_2:  Reserved
> + * @MAX77759_CHGR_CHG_DTLS_RSVD_3:  Reserved
> + * @MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER:
> + *     Charger is off as watchdog timer expired
> + * @MAX77759_CHGR_CHG_DTLS_SUSP_JEITA:    Charger is in JEITA control mode
> + */
> +enum max77759_chgr_chg_dtls_states {

Just a small style suggestion, could you please align the descriptions in this
kerneldoc block? It improves readability. Using a consistent number of spaces
or tabs after the colon helps.

Feel free to use up to 100-chars if it improves readability.

> +	MAX77759_CHGR_CHG_DTLS_PREQUAL,
> +	MAX77759_CHGR_CHG_DTLS_CC,
> +	MAX77759_CHGR_CHG_DTLS_CV,
> +	MAX77759_CHGR_CHG_DTLS_TO,
> +	MAX77759_CHGR_CHG_DTLS_DONE,
> +	MAX77759_CHGR_CHG_DTLS_RSVD_1,
> +	MAX77759_CHGR_CHG_DTLS_TIMER_FAULT,
> +	MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM,
> +	MAX77759_CHGR_CHG_DTLS_OFF,
> +	MAX77759_CHGR_CHG_DTLS_RSVD_2,
> +	MAX77759_CHGR_CHG_DTLS_RSVD_3,
> +	MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER,
> +	MAX77759_CHGR_CHG_DTLS_SUSP_JEITA,
> +};
> +
> +enum max77759_chgr_mode {
> +	MAX77759_CHGR_MODE_OFF,
> +	MAX77759_CHGR_MODE_CHG_BUCK_ON = 0x5,
> +	MAX77759_CHGR_MODE_OTG_BOOST_ON = 0xA,
> +};
> +
>  /**
>   * struct max77759 - core max77759 internal data structure
>   *

-- 
Lee Jones [李琼斯]
