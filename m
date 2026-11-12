Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794480808;
	b=pHH9o1v71oBXEeonJs6TfHSqN82xdCKhG9PAptudJSOcAdbj/tJXZg4jdsqLd1sw9gLe
	 HtICrz9wOfZsML2m1a2IrQDkLwkusuM5hhZQkMJxz6d8pJMWrkSQZv74284JYiCrxEwmG
	 SUcxaEHjxf9ba2eT5A96G5A6X8pnsTa5c06wLAqFrxemAxyc/jHWWTYlAxVkHLb1HLoXQ
	 03PmX7UgDkME3m791H6mHoLfepiLIwVh/kFM+bbFupSa3zTzTUstDx2LYykuLnxgkvprs
	 mNBMAGsnxkIPNE4J+E3JL8GTH2ZcFagC552kzFuDL4J9igw3SdTa2p6oqQEBOVY2/1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480808;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=tLqa2FMlsnasCoo7Flq+ndrdNn8MeKqOwSnsMbw1pOY=;
	b=Wxenffg9eYSwmpR/yVOatTgt/r9DaSmwyshBYaQgiQ4OuWKCpKl7LmdYd2wnV1dYC5v4
	 seMis7YBeU9JYcTB4JR7UqniA58esEcRjsCKDskcMRnQWrxRBDepH2ov3ODf7TWjFW2Oi
	 wekYXdTqBE0lwgAGH3UkHZpetiXpcfa/SaR3HW2gJbXf7OQuP1kS6dt2ICdHmW/uvT2Sh
	 QMlmNphw22Et0CHdwDsL1/S/IilW/eAUueTJzeS+02Gjl4ObSvwrC/zdHDTdmgipk+DqN
	 sxIUD+CExfkkCC5cvXIYrmMbFU8jmB2qee5sx2vpFkn6Pd74kVBJoYGyf6nMUs2d0GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ziyao.cc;
	spf=pass smtp.mailfrom=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=gTIN1Kf1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBED606A323;
	Thu, 12 Nov 2026 10:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CBED606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=gTIN1Kf1
ARC-Seal: i=1; a=rsa-sha256; t=1794480779; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BTHypljfRAlk3PgTfQxskdtuHNyT2eHhwDSiPxWGcIxxpp5EKRnJ9l+nwrKju1zF32gR5z4S+iYv6e0UOFFOJVukfdb78fs5wDpiizkF3aMI9YuQIHDRiOUHu1oYn4wFVQnzBD0whvsnuWpeVq2kHHZ9mEQOh1x+KGICvTM65bk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794480779; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tLqa2FMlsnasCoo7Flq+ndrdNn8MeKqOwSnsMbw1pOY=; 
	b=CH5rP2keafftl/e1MuUB8BRJ33woDqE+wNT/OnRtWXmlfi0E5Gt6anyAJ6nxg0Pe62OJ1t3oTh+JITovKbcfT3eeIQ8BnYkBps3ThTSFFnNzdFJ/lqE1rf6w7Ex/JT7PWP1aGzNJCIweSHxFLYC62xkN/gXRllCOXFyHQxBK+sg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256; b=gTIN1Kf1OSDmSisFgXIGp5nzx0VF2FjdVAGWgze/GM97/5ObZWtXtixYOhOLTr5oOTMCHDXorlaH4phnj1Ijw0LsTX2uCTBCgF0TGLh3mNdZJPOpthgOr3pRIIJpI9Y9+OzZrIUx0AlL3cHOa6dmeFr8HOhPr59+d/J2v/9qirE=; c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1; bh=tLqa2FMlsnasCoo7Flq+ndrdNn8MeKqOwSnsMbw1pOY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794480778136240.92925563025153;
	Thu, 12 Nov 2026 02:52:58 -0800 (PST)
Date: Thu, 12 Nov 2026 10:52:43 +0000
From: Yao Zi <me@ziyao.cc>
To: aiyengar1990@gmail.com, Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Yao Zi <me@ziyao.cc>, Igor Pecovnik <igor@armbian.com>
Subject: Re: [PATCH v2 2/2] pmdomain: rockchip: report domain errors once,
 with dev_err_probe()
Message-ID: <avWae91pfLv9vyUv@pie>
References: <20261112-pmdomain-rockchip-v2-0-5cd942a23df7@gmail.com>
 <20261112-pmdomain-rockchip-v2-2-5cd942a23df7@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-pmdomain-rockchip-v2-2-5cd942a23df7@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.473.96
X-ZohoMailClient: External

On Thu, Nov 12, 2026 at 08:23:30AM +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> When a power domain clock is not available yet,
> rockchip_pm_add_one_domain() returns -EPROBE_DEFER, and both it and its
> callers rockchip_pm_domain_probe() and rockchip_pm_add_subdomain() print
> that with dev_err():
> 
>   rockchip-pm-domain ...: power-domain: failed to get clk at index 1: -517
>   rockchip-pm-domain ...: failed to handle node power-domain: -517
> 
> once per probe attempt, and the second line twice for a nested domain.
> On an RK3588 board whose NPU domain clock appears late this is more than
> 20 error lines before the domain finally probes, and the reason of the
> deferral is not recorded. Other failures are reported twice (once where
> they happen and once by the callers), or only by the callers, which name
> the node but not what failed: a missing pm_qos phandle and a pm_qos node
> without a regmap print nothing in rockchip_pm_add_one_domain(), and a
> failed clk_bulk_prepare() only has the message of the clk core, which
> names neither the device nor the domain.
> 
> Report every error once, where it happens, with dev_err_probe(), and
> drop the "failed to handle (subdomain) node" messages from the callers.
> A deferral is then quiet and keeps its specific reason in
> /sys/kernel/debug/devices_deferred, such as "failed to get clk at index
> 1", and -ENOMEM, which the callers used to print, is quiet as well. The
> return values are unchanged, except that a failed
> syscon_node_to_regmap() for a pm_qos node now returns its own error
> instead of -ENODEV: it can be -EPROBE_DEFER (a syscon regmap that is
> not registered yet, or a syscon clock or hwlock that is not available
> yet), which must not turn into a probe failure.
> 
> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
> Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-power domains")
> Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 98 +++++++++++++++-------------------
>  1 file changed, 43 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 00c7e78f89b5..be077fb52f40 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -804,28 +804,22 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>  	int error;
>  
>  	error = of_property_read_u32(node, "reg", &id);
> -	if (error) {
> -		dev_err(pmu->dev,
> -			"%pOFn: failed to retrieve domain id (reg): %d\n",
> -			node, error);
> -		return -EINVAL;
> -	}
> +	if (error)
> +		return dev_err_probe(pmu->dev, -EINVAL,
> +				     "%pOFn: failed to retrieve domain id (reg)\n",
> +				     node);
>  
> -	if (id >= pmu->info->num_domains) {
> -		dev_err(pmu->dev, "%pOFn: invalid domain id %d\n",
> -			node, id);
> -		return -EINVAL;
> -	}
> +	if (id >= pmu->info->num_domains)
> +		return dev_err_probe(pmu->dev, -EINVAL,
> +				     "%pOFn: invalid domain id %d\n", node, id);

These look like code clean-up instead of fixes, thus should be split
into a separate patch, especially when we probably want to backport the
real fixes. This applies for many places below.

Aside these unnecessary code changes, this patch seems in a better shape
than the very first version[1] I submitted a week ago, which seems,
unfortunately, being ignored.

I'll drop the second patch in my series and use yours instead. But
please search before sending patches next time to avoid duplicated work.

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.

[1]: https://lore.kernel.org/linux-rockchip/20261105001257.1368266-1-me@ziyao.cc/
