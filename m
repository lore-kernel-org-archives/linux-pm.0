Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218995;
	b=gsLisVcpF3jegK+baTtCNNt+wns3GHxwpkOjdxDm3x7gR0lwBXi3QGOWX9nPBvUMnRi3
	 YZV2XWNfgZsib0WaNDjPq1E96IXqp+z0vMgxC510dLidmbLWwUH8erXBlbdbXBgW3Y5XJ
	 vNmmDD09BhMIxHGWTuhUXxe1cwb05MHPmX5rqgDkrF7iqgvckln+aRdzIgkk3xg9F992B
	 m72mRBBQmQCL+hYA39iHkjcOrsqyWi3ckHJPE1RnDEI0J772JWh8A3wPH1qZGoVvd03pW
	 vek0xGev+cUyvl9BzD3EmdhqK0fTt5awLGZ0XtQxAxutXqDRg2+PxdvCLngoGJBgnQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=Ipgv8rmvtp6GT7cHXnZSnikAq5xmVO9Okns04bQSCyo=;
	b=TRp8l0fed6D0X7EsxHdSkhsMQ/eBU5AIp1ehmDUDxivQeFdA0Bftb2LlfHIi913Hh/tt
	 GLRbB/xFeUM29OpYcuCWXlpQOanR5A/ID5hEC7pf65AyzSfxRWkn8R2tfhSSjDQikYGb6
	 UG9AYcFYj1EOLqN2JhzmthKfyyFFV+dYQeeIIgdrJ1k85iAWOVriShHWgcVvntOG0rVTx
	 J4qrftq07Wfj9+Lm1kvK81tfEBmvHGdu98+VG345wXwHiojsKRFPdus68uxlNMfP1UX2T
	 vsgG8EeVwl99SMndfSAga3AfnWYP5n2bRcRRiIyVYR2VyTCjy5IYtRMhm9xmqc/K1Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCQmoYvd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04667606A31D;
	Wed, 28 Oct 2026 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCQmoYvd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F031F01825;
	Wed, 28 Oct 2026 20:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218994;
	bh=Ipgv8rmvtp6GT7cHXnZSnikAq5xmVO9Okns04bQSCyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BCQmoYvdPFuxDGcgYVXcoGOhBadVV29fjFGZ75cGAPdbuv881H+JoZIsjWI98RBdy
	 EZpO5Bg7CzuM6KjGwPdiIQrP+aggCqbZCiBaDIN+xTeLl1z3CSg2kZeSpok4dh/W55
	 mupIwGez6i0qGTQ86grpe47HS+EVB40GztDnXWZTjIcfOvm62QHxiJHIFlFs4wGTyM
	 zOQDsvxFcz6zu9vooMLNgQGRbHlAzn3MnuzRvpQeDN0UnowD2n4k1eHEr8FmrpnGki
	 nM0MJbuo8CjCa8jERdbOL1/dLoGelhl1NubL3PJ2YgCZyYVf+906HW/o6+mIrMvo3E
	 Kx9l9WmQ64eYw==
From: Thomas Gleixner <tglx@kernel.org>
To: Brian Norris <briannorris@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf
 Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>, devicetree@vger.kernel.org,
 Tudor Ambarus <tudor.ambarus@linaro.org>, =?utf-8?Q?Andr=C3=A9?= Draszik
 <andre.draszik@linaro.org>, linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Radu Rendec
 <radu@rendec.net>, linux-arm-kernel@lists.infradead.org, Mariano Marciello
 <mmarciello@google.com>, Douglas Anderson <dianders@chromium.org>,
 linux-clk@vger.kernel.org, Jakub =?utf-8?Q?G=C5=82owacki?=
 <jglow@google.com>, Brian Norris
 <briannorris@chromium.org>
Subject: Re: [PATCH 7/9] irqchip/google-cpm: Add CPM IRQ driver
In-Reply-To: <20261026144346.7.I41e14e9460b3add41e69dac97abf57a741e9c4c5@changeid>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.7.I41e14e9460b3add41e69dac97abf57a741e9c4c5@changeid>
Date: Wed, 28 Oct 2026 21:23:11 +0100
Message-ID: <87se1py3ps.ffs@fw13>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 26 2026 at 14:43, Brian Norris wrote:
> +
> +static void cpm_irq_process_irq_status(struct cpm_irq_info *info, u32 irq_number)
> +{
> +	int ret;
> +
> +	ret = generic_handle_domain_irq_safe(info->domain, irq_number);

  int ret = generic...();

> +	if (ret)
> +		dev_err(info->dev, "Error handling IRQ %u, error code %d\n", irq_number, ret);
> +}
> +

> +static const struct irq_domain_ops cpm_irq_domain_ops = {
> +	.map = cpm_irq_domain_map,
> +	.xlate = irq_domain_xlate_onecell,

Tabular layout please

> +};
> +
> +static int cpm_irq_probe(struct auxiliary_device *adev, const struct auxiliary_device_id *id)
> +{
> +	struct device *dev = &adev->dev;
> +	struct cpm_client *client;
> +	struct cpm_irq_info *info;
> +	int ret;
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->dev = dev;
> +	auxiliary_set_drvdata(adev, info);
> +
> +	info->domain = irq_domain_create_tree(dev_fwnode(dev), &cpm_irq_domain_ops, info);
> +	if (!info->domain) {
> +		dev_err(dev, "Unable to add irq domain\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, cpm_irq_domain_remove_action, info->domain);
> +	if (ret) {
> +		dev_err(dev, "Failed to add irq domain removal action\n");
> +		return ret;
> +	}
> +
> +	client = devm_cpm_request_client(dev, CPM_AP_NS_IRQ_SERVICE,
> +					 cpm_irq_rx_callback, info);
> +	if (IS_ERR(client))
> +		return dev_err_probe(dev, PTR_ERR(client),
> +				     "Failed to request cpm client\n");

No line break required. You have 100 characters.

> +static struct auxiliary_driver cpm_irq_driver = {
> +	.probe = cpm_irq_probe,
> +	.name = "cpm-irq-chip",
> +	.id_table = cpm_irq_id_table,

Tabular layout

> +};
> +

Pointless new line.

> +module_auxiliary_driver(cpm_irq_driver);

Other than those nitpicks this looks reasonable.

> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Google CPM IRQ chip driver");
> +MODULE_AUTHOR("Jim Wylder <jwylder@google.com>");

This does not add up: I can't find Jim in the From/SOB tags of the mail.

Thanks,

        tglx
