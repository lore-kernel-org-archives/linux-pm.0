Received: from mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF837429CD5
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531597; cv=none; b=YKYlX8S3fLcrizC5ifTlA/DrOaz/h2cpLjS+991Ra3rs21GbcX2z+jQU0E//DwZWEO65yGmWAvh4+BVaWAw4tifq7dczDft6ke8phfqdbofyeU6OlNsmKZZoOQ1UOEEC71X2bfCh7P43RddQNh4TkivmfPSszpHqZ92YsA4xm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531597; c=relaxed/simple;
	bh=jEdVtLUq6P/fnp0VQPDEUME0wY+Z9SUacgM2EjSQXx8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Oj6l5pJfuaZ3Q3RaRYapEuxC5enFViOfsof6nTrxQ/PSeoY54v7RKwlONGs/GuVHhPTN+15oyx721ZLrU12Oh5dmu8SDu2a9zik0kgl67OYo4OTtPt2321WR5mvYhN/wUhP7F9IIJvxOO3V1Q2bAkJMuYIZEwusvGFtsSQjgGRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=A36WZeEm; arc=none smtp.client-ip=91.218.175.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="A36WZeEm"
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jEdVtLUq6P/fnp0VQPDEUME0wY+Z9SUacgM2EjSQXx8=;
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786531592; v=1; x=1787136392;
 b=A36WZeEmnAngoq4JvyLZYL5YYC51oK/6AIG8iuABfU2U7np39+RPA7UZAUf8xDACInGcpl/t
 h8WgCT8CGsutVb1ykv++AWjscIyi6nhKsr5EZB7fK38fa4LOrqoEn5KBxQwVm6/09Bw08pAI5kx
 AhMu4WoanKDFhasBMD5ZAOqpW+jd19NPCLb8R1LtIGosyUznwpX13fsg0JVX//OGcZS2pUTcDX1
 lUSlLEGaDltWiHO8SMfmd2uDBrPmaYDiCHmUQ4zr5hjcgYf47eKixnhG1kLxWca1K8SRJH7SHeq
 nJ+Z1XIclMBI/N5KAB48t3FDGY+d6mEp63ClHQQyhdNpw==
X-Envelope-To: linux-pm@vger.kernel.org
Received: from localhost (92.254.112.55)
	by smtp.migadu.com with ESMTPS id bdf0263f67b1a77a;
	Wed, 12 Aug 2026 10:45:27 +0000
X-Migadu-Scanner: mta11.migadu.com
Authentication-Results: mta11.migadu.com;
	none
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 12:45:18 +0200
Message-Id: <DKMWKH7ECZZM.3GL6MUEUO2Q1N@cknow-tech.com>
Cc: <royalnet026@gmail.com>, <alchark@flipper.net>,
 <chaoyi.chen@rock-chips.com>, <diederik@cknow-tech.com>,
 <dri-devel@lists.freedesktop.org>, <linux-rockchip@lists.infradead.org>,
 <iommu@lists.linux.dev>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 04/10] dt-bindings: iommu: rockchip: allow the RK3576
 NPU MMU clock set
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Jiaxing Hu" <gahing@gahingwoo.com>, <tomeu@tomeuvizoso.net>,
 <heiko@sntech.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <ulfh@kernel.org>, <p.zabel@pengutronix.de>,
 <ogabbay@kernel.org>, <zhangqing@rock-chips.com>
X-Mailer: aerc 0.22.0-9-ge948bb7230f4
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-5-gahing@gahingwoo.com>
In-Reply-To: <20260812094106.1391698-5-gahing@gahingwoo.com>

Hi Jiaxing,

On Wed Aug 12, 2026 at 11:40 AM CEST, Jiaxing Hu wrote:
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

Drop the ", RK3576 NPU MMUs only" part as it is not future proof, not
needed, not enforceable and not enforced.

IIUC, only a RK3576 NPU MMU can and should have 5 clocks, but a non-NPU
RK3576 MMU should only have 2 clocks, just like any MMU for RK3568 and
RK3588.
So you'd need a new compatible for RK3576 NPU MMU and enforce that only
that one has exactly 5 clocks, while all other compatibles are only
allowed to have 2 clocks.
=20
Right now, it is allowed that a ``rockchip,rk3568-iommu`` compatible has
5 clocks while a RK3576 NPU MMU only has 2. Both are incorrect.

Cheers,
  Diederik

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


