Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF23327A916;
	Wed, 27 May 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893672; cv=none; b=tgcvxYx3Hkn00WhDq3TkGsxbveWTE7vwlZLlwkPL9QLMWuYQ+12nYGSXBPZ0HUafdRoVbJEVLjYpCQVmu5rOstImK2l1hSddP+SiBSzoJe1b9FFMjPmFLN2XJX9b/eamSSEqFiSggLOrfPl22W2CFh7FJIKzvsz4hHKzKhxIsNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893672; c=relaxed/simple;
	bh=sxqDiryLoBnJ6NFyrS/FmQ8pTRjJ4rHNr4I1qRjbgSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpXBZXT/2v+1beW+IEnpZUk+2fyCpRNUlOhn8YiTuFPA6Zn+okXi5GvwWdjYAUqx5ZHMLFwTDZzgYNjwE/1YQIFalZKVHfqhDcqReAVUD0DdzPjReJRkdxOE3dNRbogpln5azXaq8AcyLvbueUr3cc47EHDbBF70ngbfZKbIpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsfaJKEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsfaJKEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304871F000E9;
	Wed, 27 May 2026 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779893670;
	bh=E6Q8XCy0zXe1xOArUqxZeTNT47K+djAyAvzM5weh5ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HsfaJKEqK2zij9eVrAg/H0mCdwW7f+jPa6VPlEi/OgY18/ICbhaP0TvYh02P8723q
	 d05/6fhwusJiiPJCqgehDfzasMA+Enbu3dco5olHjA4LRWS0ScqZg6ScRCEOg6NfSX
	 wlkVeTSJTa6r40HbORDCamwiQ3gsl3jYZvDbcmQCXGETQosWLBuASMMaEvuVjRTWZR
	 K9syJsgAM43De46p3pd5dp4mgwVBVihbXgRbLDFLuc4PtLOFmk6MuouWeBcjK2A8V+
	 /QNs9aec1herrWcN95kTc3CezqNwxaCA/ZvmxtZF7NrGEv2brgIxuqmW6Hzttnlm2A
	 VLP/U1zlNDH7Q==
Date: Wed, 27 May 2026 15:54:23 +0100
From: Lee Jones <lee@kernel.org>
To: linux-kernel-dev@aliel.fr
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 3/8] mfd: khadas-mcu: Add per-variant configuration
 infrastructure and VIM4 support
Message-ID: <20260527145423.GC671544@google.com>
References: <20260516-add-mcu-fan-khadas-vim4-v6-0-cccc9b61f465@aliel.fr>
 <20260516-add-mcu-fan-khadas-vim4-v6-3-cccc9b61f465@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516-add-mcu-fan-khadas-vim4-v6-3-cccc9b61f465@aliel.fr>

On Sat, 16 May 2026, Ronald Claveau via B4 Relay wrote:

> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Introduce a per-variant configuration structure (khadas_mcu_data)
> holding the regmap config and MFD cells,
> selected at probe time via the of_device_id match data.
> This makes adding other variants straightforward.
> 
> Add an enum khadas_mcu_type used as value to match.
> 
> Also introduce khadas_mcu_fan_pdata to pass fan register address and
> maximum level to the fan sub-driver, removing the hardcoded constants.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>  include/linux/mfd/khadas-mcu.h | 44 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mfd/khadas-mcu.h b/include/linux/mfd/khadas-mcu.h
> index a99ba2ed0e4e0..88de49b78f5e6 100644
> --- a/include/linux/mfd/khadas-mcu.h
> +++ b/include/linux/mfd/khadas-mcu.h
> @@ -70,6 +70,13 @@
>  #define KHADAS_MCU_WOL_INIT_START_REG		0x87 /* WO */
>  #define KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG	0x88 /* WO */
>  
> +/* VIM4 specific registers */
> +#define KHADAS_MCU_VIM4_REST_CONF_REG		0x2c /* WO - reset EEPROM */
> +#define KHADAS_MCU_VIM4_LED_ON_RAM_REG		0x89 /* WO - LED volatile */
> +#define KHADAS_MCU_VIM4_FAN_CTRL_REG		0x8a /* WO */
> +#define KHADAS_MCU_VIM4_WDT_EN_REG		0x8b /* WO */
> +#define KHADAS_MCU_VIM4_SYS_RST_REG		0x91 /* WO */
> +
>  enum {
>  	KHADAS_BOARD_VIM1 = 0x1,
>  	KHADAS_BOARD_VIM2,
> @@ -82,10 +89,43 @@ enum {
>   * struct khadas_mcu - Khadas MCU structure
>   * @device:		device reference used for logs
>   * @regmap:		register map
> + * @data:		pointer to variant-specific config
>   */
>  struct khadas_mcu {
> -	struct device *dev;
> -	struct regmap *regmap;
> +	struct device			*dev;
> +	struct regmap			*regmap;
> +	const struct khadas_mcu_data	*data;
> +};
> +
> +/**
> + * struct khadas_mcu_data - per-variant configuration
> + * @regmap_config:	regmap configuration
> + * @cells:		MFD sub-devices
> + * @ncells:		number of sub-devices
> + * @fan_cells:		MFD fan sub-devices
> + * @nfan_cells:		number of fan sub-devices
> + */
> +struct khadas_mcu_data {
> +	const struct regmap_config	*regmap_config;
> +	const struct mfd_cell		*cells;
> +	int				ncells;
> +	const struct mfd_cell		*fan_cells;
> +	int				nfan_cells;
> +};

My alarm bells started ringing as soon as I saw this!

> +/**
> + * struct khadas_mcu_fan_pdata - fan sub-driver configuration
> + * @fan_reg: register address to write the fan level
> + * @max_level: maximum fan level
> + */
> +struct khadas_mcu_fan_pdata {
> +	unsigned int fan_reg;
> +	unsigned int max_level;
> +};
> +
> +enum khadas_mcu_type {
> +	KHADAS_MCU_GENERIC, /* VIM1/2/3, Edge, Edge-V */
> +	KHADAS_MCU_VIM4,
>  };
>  
>  #endif /* MFD_KHADAS_MCU_H */
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones
