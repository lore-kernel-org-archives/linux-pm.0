Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033548D868;
	Thu, 17 Sep 2026 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683411; cv=none; b=tns0iqQccF0fcLOFdbZUs/IRfbzJVfmGaE9BJE36ClJfoJKKZoqzn72QwDAB7E46pPkXRXPDLPtqDqXmDswWg9MVSLUje1uExWJIEQRHrpuJjqX+X92fmX1yM0O9bFmFpKBcs8D9XOKdR1FYrs+5rUd8DiFqE7YqwWREvuI9iTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683411; c=relaxed/simple;
	bh=qz5WwkpeJJLsXU6eWyh21MIvSJfrbOgKiKvhfDrW6ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxfTLKQ+XH8BoK7BNe3MuvlqJOTXgceUFKP/vJishXHLeISBqFAiMeOVJSvGDvZ19UxJ3vJTzK4b5P6qV80FbeHd0hefJLLvMsQHs+jFsFMiINIYzOnfcTBEH9PHB/kHGnuzCnh+YGRIhyuagzfoAvXvbCnTdrxPKTAhYpnMKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey44S3pn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey44S3pn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B05F1F000FF;
	Thu, 17 Sep 2026 22:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789683409;
	bh=OWnzt8rLfj/dFjZYPIQKJfAFzcwj+93B+nzb3sOJ8wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ey44S3pngv/F4n0zm/K0EnPj+M0YWM2qeC9WO/7SNUXfrYfRZW0cYz56yYX/r5eo5
	 eT11WD9gfwZ/9VXfkBIiGRSVTPqndVrYl3KbvE2VELum47TNKDShTAOkWYMdL10e3e
	 Vn6d2cNzmCGlPU0GQGrRChnHH9Qn+LU2glwiCfXbv5b8wEgA85n0mR5XorlFKrRqLP
	 hKpo9ivNL3i+Q1Lv5nbgZh7Zxi9Uo0R5SiC37YcvmF+UceI8t1lz/oI/CkLJwVJEGe
	 oQ6rLRZmZIRAYDb2Ygj8IXDHoAz8FGmXROmce8UDMIQa3JMN5LnWFjij8+82Jts+8O
	 Y8YhhzyIwqXbQ==
Date: Thu, 17 Sep 2026 17:16:47 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clegoffic@baylibre.com>,
	devicetree@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/12] of: property: fw_devlink: Add support for
 renesas,scmi-firmware
Message-ID: <20260917221647.GA4038349-robh@kernel.org>
References: <cover.1788338320.git.geert+renesas@glider.be>
 <1d5c56c80291e447208ac8777aaf90ad6f0a4f4d.1788338320.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d5c56c80291e447208ac8777aaf90ad6f0a4f4d.1788338320.git.geert+renesas@glider.be>

On Wed, Sep 02, 2026 at 01:29:20PM +0200, Geert Uytterhoeven wrote:
> Let fw_devlink create device links between consumers and suppliers of
> SCMI firmware on Renesas platforms, and enforce these dependencies.
> 
> This prevents probing of drivers before the firmware they depend on
> becomes available, thus avoiding unneeded probe deferrals.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - s/firmware/renesas,scmi-firmware/,
> 
> v2:
>   - No changes.
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 72cf12907de034e9..e79cd3cce4e2e41a 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1417,6 +1417,7 @@ DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
>  DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> +DEFINE_SIMPLE_PROP(renesas_scmi_firmware, "renesas,scmi-firmware", NULL)
>  
>  static struct device_node *parse_pinctrl_n(struct device_node *np,
>  					   const char *prop_name, int index)
> @@ -1574,6 +1575,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_regulators, },
>  	{ .parse_prop = parse_gpio, },
>  	{ .parse_prop = parse_gpios, },
> +	{ .parse_prop = parse_renesas_scmi_firmware, },

This is going to be a catch-22, we can't have vendor specific properties 
here. If we need this, we need to come up with a distributed way to 
declare them. Linker section tricks is one way. Maybe something in the 
driver struct would work? 

Can you just avoid a property altogether? Why can't you check for the 
presence of SCMI at runtime?

Rob
