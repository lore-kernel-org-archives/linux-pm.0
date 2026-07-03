Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFB433B6EA;
	Fri,  3 Jul 2026 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059903; cv=none; b=najiVJ0Zb1BoVhvdpog7/UrL2cO0FoMfgfLx2LoZm5anie88CvEeWbXqF3UlhMLKWCYjIu8KyYo7E2PoE3oIPVSPgaevJUsSCHvtDNAgQzf4SLz3Iyc8TdCTHbHgFyfbyHZKgJnaSITYXK5cLmx8iX3XCX/oXPVKq1XiuwmuRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059903; c=relaxed/simple;
	bh=w+YRfo6oCYu7YY8YJCa6Ag6FJmx0Hd7jtEMhbA+2mFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzIltiHS08qT+eArHYqIsmlBK/8ka+ZGIXM0X7sMHCQW4LL9UwacYdhwv2pNEm3rEz/REaKU4J+dUhX1ErMcpZvS793vHkAkXtRfUEASjQPeeK8eH24Yu3nGUS6vohj7OrrjKeGuNNsKTCBBKccBfdzDXkQvndiEV79V2wFxufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+Dg+JHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+Dg+JHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166EB1F000E9;
	Fri,  3 Jul 2026 06:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783059901;
	bh=TJMqb5uglMKDq+IApRTYk+IDF7wC5GEfD9IL9aBCrXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k+Dg+JHiD5FG2ehk+GqbjP9ne5mmr3jIf4HBiFaqIjLqelH96Xm/1vJkRH2+K88LY
	 emQ/IjMgl+KWhm9g0bagJH1+aqvBCYQXdenSGufhnJe3KeTqe4ay2qlSREJM3oT54y
	 Mrncjr0dgSoecnyM4qajV1YDygM5343p2OQkrk8KPle2+CgJvIWbSOjv7Wm6z7ZoxL
	 gn5c7dP4ycKmtYIG+CxfdvWBR1bbx7O3R1bdPArpNdVTRrLCK8XZnzFcEVrGgoGCqL
	 2pk1XF81ypBoRjpbJj7/5+JBs0cYnnOtzvM3UrMbTRV80mpmzeAyg0v6pGWuIftpXu
	 /1GZ01CTBeVXA==
Date: Fri, 3 Jul 2026 08:24:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, 
	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/4] powercap: qcom: Add SPEL powercap driver
Message-ID: <20260703-sceptical-famous-mouflon-42dec0@quoll>
References: <20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com>
 <20260702-qcom_spel_driver_upstream-v3-3-434d50f0c5b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-qcom_spel_driver_upstream-v3-3-434d50f0c5b0@oss.qualcomm.com>

On Thu, Jul 02, 2026 at 10:52:56PM +0530, Manaf Meethalavalappu Pallikunhi wrote:
>  QUALCOMM TEE (QCOMTEE) DRIVER
>  M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index 03c4c796d993..e3a47c653499 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -93,4 +93,17 @@ config DTPM_DEVFREQ
>  	help
>  	  This enables support for device power limitation based on
>  	  energy model.
> +
> +config QCOM_SPEL
> +	tristate "Qualcomm SPEL Powercap driver"
> +	depends on ARM64 || COMPILE_TEST

Why does it depend on ARM64?

Where is dependency on ARCH_QCOM?

...

> +static int spel_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct powercap_control_type *ct;
> +	struct spel_system *sp;
> +	int ret;
> +
> +	sp = kzalloc_obj(struct spel_system);

I miss the point why you are not using devm. You are introducing
ordering issues now, because sp is freed before other cleanups are done.


> +	if (!sp)
> +		return -ENOMEM;
> +
> +	sp->dev = dev;
> +
> +	/* Map config registers (units, capabilities) */
> +	sp->config_base = devm_platform_ioremap_resource_byname(pdev, "config");
> +	if (IS_ERR(sp->config_base)) {
> +		ret = PTR_ERR(sp->config_base);
> +		goto err_free_sp;
> +	}
> +
> +	/* Map constraint registers (power limits) */
> +	sp->constraint_base = devm_platform_ioremap_resource_byname(pdev, "constraints");
> +	if (IS_ERR(sp->constraint_base)) {
> +		ret = PTR_ERR(sp->constraint_base);
> +		goto err_free_sp;
> +	}
> +
> +	/* Map spel domain registers (energy counters) */
> +	sp->node_base = devm_platform_ioremap_resource_byname(pdev, "nodes");
> +	if (IS_ERR(sp->node_base)) {
> +		ret = PTR_ERR(sp->node_base);
> +		goto err_free_sp;
> +	}
> +
> +	sp->control_type = powercap_register_control_type(NULL, "qcom-spel",
> +							  NULL);
> +	if (IS_ERR(sp->control_type)) {
> +		dev_err(dev, "Failed to register control type\n");

syntax is everywhere: ret = dev_err_probe

Since years already. Don't upstream your old downstream code, but write
something based on current Linux drivers.

> +		ret = PTR_ERR(sp->control_type);
> +		goto err_free_sp;
> +	}
> +
> +	/* Save control_type before it might be freed by spel_release_zone() */
> +	ct = sp->control_type;
> +
> +	/* Initialize system and domains */
> +	ret = spel_init_system(sp, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize system\n");

dev_err_probe

Best regards,
Krzysztof

