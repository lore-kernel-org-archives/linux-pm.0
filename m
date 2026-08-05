Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D32C3E316B;
	Wed,  5 Aug 2026 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969539; cv=none; b=S/Z4oL6NnebxiVr8voMurqNrI8uqxml9yeuPPGNZJzlCNGs3WsJCTCwnHNYPEddg6yrzDU/guWPAKDVy55CwAknqHy/1HmyCW1FMPF2Qu7K4S+w7I6+XaPWMviBB7o3/8XaueT1ME4/N1fbMvfQeuqsiShkIQEm9PERw+PJS1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969539; c=relaxed/simple;
	bh=fysVipfONh/x9yJFLNjTer3RjlXeynbaGnDOhvC9ZS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHTOy/so3RaIqEVrFXMRU42KiwAX880HcbmEf3GDwn4jOd6de4K24Xq7J9xYYQ4VTiwOIoZOb66EqJCcNzhtIM1qRweejdTm6TGmL06igs2gJ9KIdt1kMfxC0XG+nvD+E/ZlDDD4vIBXC1ZAbwNXngU2v/5H89aPbPUaZyL7uqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Csf9NuPU; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Csf9NuPU"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hFlgx2py8zMlH2;
	Thu, 06 Aug 2026 00:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785969533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uS+RCfKyjG2UtT4+awjQRyRPyTMRZoUZeNGtWmbYJPA=;
	b=Csf9NuPUw00gLrfyzQpMvzedX0iF5woxs6AsivUK3fODBr/XLypjdeQgDq8UMF1Dw3DMHD
	QdWCzMYs/AXDgbmp6veIJWmlwG6QzhimzwxZPPEL4qwtLzMdDMut47kb180pVf2WAY3HhA
	G7l0lspMaE/nrnKj1Mwr46i+vKiy/worVbkZCCo/8L7UARVc1mfRXr8UZzb70vNN4R0xow
	m1vnQZHcQ/91YoSRewdVdBQRCK8IX6sYjNA788Sxh856Xk7Zs+3Msm27FXAFGdQfOz1Y4Q
	YI/QyD9et2mr5rQcu5tvxm2CubXt2BwFtcAu2/cj2ffCA+AeWKeN8LPDAX0DJw==
Message-ID: <0124d3a3-81dc-44ce-88a2-9426c65ac46c@mailbox.org>
Date: Thu, 6 Aug 2026 00:38:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/6] pmdomain: renesas: Add R-Car X5H MDLC driver
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1785941595.git.geert+renesas@glider.be>
 <89e6a71b35703f10e12f520af1f389b5f40f4b35.1785941595.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <89e6a71b35703f10e12f520af1f389b5f40f4b35.1785941595.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a370a64fff6b4dfe338
X-MBO-RS-META: 355w3c5a4crihgw76irh7wwwrs3zhmwk

On 8/5/26 5:20 PM, Geert Uytterhoeven wrote:

Hello Geert,

[...]

> +DEFINE_MDLC_RESET_WRAPPER(reset)
> +DEFINE_MDLC_RESET_WRAPPER(assert)
> +DEFINE_MDLC_RESET_WRAPPER(deassert)
> +DEFINE_MDLC_RESET_WRAPPER(status)
> +
> +static const struct reset_control_ops r8a78000_mdlc_reset_ops = {
> +	.reset = r8a78000_mdlc_reset,
> +	.assert = r8a78000_mdlc_assert,
> +	.deassert = r8a78000_mdlc_deassert,
> +	.status = r8a78000_mdlc_status,
> +};

Please keep the list sorted alphabetically.

> +static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
> +				    struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct r8a78000_mdlc_priv *priv;
> +	struct of_phandle_args pd_spec;
> +	const struct mod_map *map;
> +	unsigned int id;
> +	int ret;
> +
> +	ret = of_parse_phandle_with_args(np, "power-domains",
> +					 "#power-domain-cells", 0, &pd_spec);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (pd_spec.args_count != 2) {
> +		of_node_put(pd_spec.np);

Maybe some "goto error" fail path which does of_node_put() wouldn't hurt 
here, since the of_node_put() is duplicated in here multiple times.

> +		return -EINVAL;
> +	}
> +
> +	scoped_guard(mutex, &r8a78000_mdlc_lock) {
> +		hlist_for_each_entry(priv, &r8a78000_mdlc_list, link) {
> +			if (priv->np == pd_spec.np)
> +				break;
> +		}
> +	}
> +
> +	if (!priv) {
> +		dev_err(dev, "%s: MDLC %pOF not found\n", __func__, pd_spec.np);
> +		of_node_put(pd_spec.np);
> +		return -ENODEV;
> +	}
> +
> +	id = pd_spec.args[1];
> +	of_node_put(pd_spec.np);
> +
> +	map = mod_map_find(priv->mod_map, id);
> +	if (!map) {
> +		dev_err(dev, "Unknown module 0x%x\n", id);
> +		return -ENOENT;
> +	}
> +
> +	dev_dbg(dev, "Ignoring HW module 0x%x\n", id);
> +	return 0;
> +}

[...]

> +static int r8a78000_mdlc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct r8a78000_mdlc_priv *priv;
> +	const struct mdlc_info *info;
> +	struct resource *res;
> +	int ret;
> +
> +	ret = r8a78000_genpd_always_on_singleton(dev);
> +	if (ret)
> +		return ret;
> +
> +	info = of_device_get_match_data(dev);
> +	if (!info)
> +		return -ENODEV;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	priv->np = np;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	for (; info->base; info++) {
> +		if (info->base == res->start)
> +			break;
> +	}
> +
> +	if (!info->base) {
> +		dev_dbg(dev, "Unsupported MDLC instance 0x%pa\n", &res->start);

return dev_err_probe() might be more appropriate here, even if that 
would be more chatty until the support for various MDLC nodes lands.

Some dev_info_probe() would be even better, but we don't have that.

[...]
