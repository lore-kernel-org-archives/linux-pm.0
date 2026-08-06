Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC43590AE
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008252; cv=none; b=u5rrsh6rggxZ0fLqaYbsi7/N35S4PFFxh0Hz4iCsHtpwMegttOCk8kBxaPwoS73Fl3GKkptxAWxdevxH7sZ2gmuwX5IN6AYHG1CcgPfgZi9jJv9K4X61RFwcDxpEIVeIUaTzyKDmcPXDAYEBqTQNSanH9VSRYMUVnLVvbVI3IcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008252; c=relaxed/simple;
	bh=2Bux34acxbkkdsfc7hWzKdEN3DqFCaMDm99n6apUicc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=h0auZsGX506TVr9VCEQiyBzmrz3rhhdJ7ld4cREp4lODmxpe5Spp0y5Lz1m5mhTPmX+0AltVO/QiK6oe9imzNw0Z/7gWlQkhMlBWkJKIxgUlQlqggFqbD+AOlqktU/5hM5tbPbLlppB77b73f1E70dehwxDul3VpWu1savcHOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=aUsX59P/; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="aUsX59P/"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1786008236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dA4vidVbXhTuIp9QqxNa6zPIHYzqdAruYLG2CSq3Ubg=;
	b=aUsX59P/Rs0XtXz+pr6ZpDN3xLg2qhYYUcMwU5i5B/YJXki/xjKg/RXiIOPHD3m9wiyjvm
	jjtHnKM1QWosaYFlpMX5nDchtabNJlbdbH7CS3g+9D2C9VSszWthR0ltCUX05RcmR4QMZ/
	Xi0EOCqNBIStnzsROASC+WnMZmvfFI1x/8NpxUBVi1nbEflvD/gkv8vGZvdE3TsPPWwZXS
	CjIV1ID7V6Fmx2Y3YC7X6gKgc9XTIS+8wMAGg2lykgDGb3mM1ENs3gD1WilT84k7Zw+lJc
	7xdWzeqKxtFOe6gcU83DyeYCC7mrKZAkOp8H2qiDv6OHqQk0mQNkCccyFW6EDg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 11:23:39 +0200
Message-Id: <DKHR2P0XJF0B.OY937NT39DR7@cknow-tech.com>
Cc: <royalnet026@gmail.com>, <alchark@flipper.net>,
 <chaoyi.chen@rock-chips.com>, <diederik@cknow-tech.com>,
 <dri-devel@lists.freedesktop.org>, <linux-rockchip@lists.infradead.org>,
 <iommu@lists.linux.dev>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v6 3/9] dt-bindings: iommu: rockchip: allow the
 RK3576 NPU MMU clock set
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Jiaxing Hu" <gahing@gahingwoo.com>, <tomeu@tomeuvizoso.net>,
 <heiko@sntech.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <ulfh@kernel.org>, <p.zabel@pengutronix.de>,
 <ogabbay@kernel.org>, <zhangqing@rock-chips.com>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
 <20260806063413.350184-4-gahing@gahingwoo.com>
In-Reply-To: <20260806063413.350184-4-gahing@gahingwoo.com>
X-Migadu-Flow: FLOW_OUT

On Thu Aug 6, 2026 at 8:34 AM CEST, Jiaxing Hu wrote:
> The RK3576 NPU MMUs need more than aclk and iface. With only those two
> enabled the MMU accepts reads but silently drops register writes: a
> DTE_ADDR value written from the power domain, while the domain clocks
> are still on, reads back correctly, and the write rk_iommu_resume() does
> microseconds later does not land at all. The vendor DT names the CBUF
> clocks as that MMU's interface clocks and its driver keeps every NPU
> clock on for as long as the device is powered.
>
> The driver side of this is already upstream, commit 841363ebb508
> ("iommu/rockchip: Take all DT clocks"), which switched rk_iommu to
> devm_clk_bulk_get_all(). Widen the schema to match so those nodes can
> be described. minItems stays at 2, so every existing devicetree, which
> all carry exactly aclk and iface, is unaffected.

I agree with all remarks Sashiko made wrt this patch:
https://sashiko.dev/#/patchset/20260805063826.95682-1-gahing%40gahingwoo.co=
m?part=3D3

Now every MMU with "rockchip,rk3568-iommu", "rockchip,rk3588-iommu" or
"rockchip,rk3576-iommu" is allowed to have a minimum of 2 clocks, instead
of having exactly 2 clocks. That does not sound desirable.

Cheers,
  Diederik
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  .../devicetree/bindings/iommu/rockchip,iommu.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml =
b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> index 6ce41d11f..a3cedcaaa 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -42,14 +42,22 @@ properties:
>      minItems: 1
> =20
>    clocks:
> +    minItems: 2
>      items:
>        - description: Core clock
>        - description: Interface clock
> +      - description: Compute clock, RK3576 NPU MMUs only
> +      - description: Convolution buffer core clock, RK3576 NPU MMUs only
> +      - description: Convolution buffer interface clock, RK3576 NPU MMUs=
 only
> =20
>    clock-names:
> +    minItems: 2
>      items:
>        - const: aclk
>        - const: iface
> +      - const: npu
> +      - const: aclk_cbuf
> +      - const: hclk_cbuf
> =20
>    "#iommu-cells":
>      const: 0


