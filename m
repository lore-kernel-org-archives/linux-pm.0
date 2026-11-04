Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790152;
	b=ntMmHN5EDxofDQ16a/Vz951ClvMwzdolNFT+PitlAbB9C1A/SJ27QzRasEKkInLHXyOw
	 q+rzmkV64ZnrgN7KBfjuU0lHxEaWok0duk4oEgane0yk0dloeXMMgXvDdLUnaxNrmNsMu
	 07rZW2APNsz/y5KK4RoLdXiBVi6QOeKWo0MXxvLWJzmgUjZ15cYVUfrWIJlDOU+Ut2ZuK
	 NNTfwAuLUQnNCUQvs6zK7vd/dfZlIH3DPaw+jjBwpIlqWYGWNTozX14U3WuUiTEwPxh/z
	 WyC1CK6WWeknqo+/3fN1ppiZkvWc8L3RRbkptbagg4iC6rTfwqg7S9f4qhfipEOfesQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790152;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=D6EynbrAyE4kBCRtfAuXRbcm+KrJUZjKmPIkF+rnkGE=;
	b=hP7HIw3Db2ZKP4M/9NeUDaBHreKhSVy4XMpqi1ZDmGTn0FLuUzsNjeeb6E2emJUEUM+W
	 8JcfJXMwncFhAesvbcVVbQLDfFZHSQxn0f8yuJ3Xqp4gNiVRXU0+84q24/RzmhPkpLTRU
	 2Zuoe6SJ3z+UxNkKcbztmNCedH43u0QSnBnCbO9cEG4uF6fHjKIPXUR8Wd/atpUbDMwg1
	 tM+ICUDignEPmtXem1vaBFhVs/71Z+b1TaJ3cuhSILatKUCARl0KeVq9qpvIDJlvdBkqj
	 OcnlvFaI8sySvL23dDVtLEUzJCIat5RkXdELE/KG+p5pJ4TPZ4b0gAja7ydGhzUDzNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=HprGKrTr;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDB606A326;
	Wed,  4 Nov 2026 11:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87BDB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=HprGKrTr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=D6EynbrAyE4kBCRtfAuXRbcm+KrJUZjKmPIkF+rnkGE=; b=HprGKrTrwC+A6mzuC5DOgjQHfS
	9qs/Upv6aoKHG/RC8l/fMPvz6uAI9m6ULjaFh0EJqly5ovt/0VvP5KYdJRBwMz0rk+pft8OZzS+92
	849Q7YRLbD4aNTLZ2CkjJrhujXha78Xa/8NaNc92aWMrJpPvzMccTJwnDxg/nlhP+kwRw5G1H9Z+A
	Y4M9jo7W49Tk66EBbJDF8kT2pr7PJiZm5MPdKfgTeiH6C3Eu4ZnhChxCo5tiuZ7kkGPfu1Jtv0c4I
	UpzG9FmCH0IyiUCX+ggLidwZAWo4lmOqV8jNDjPiI+y5VRvll40JKas30nrfAh0tiUYPPtgj6/v5A
	7zta+zuw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>,
 chaoyi.chen@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>, Conor Dooley <conor.dooley@microchip.com>
Subject:
 Re: [PATCH v15 08/15] dt-bindings: iommu: rockchip: describe the RK3576 NPU
 MMU
Date: Wed, 04 Nov 2026 12:02:02 +0100
Message-ID: <15606397.O6BkTfRZtg@diego>
In-Reply-To: <20261101082307.151957-9-gahing@gahingwoo.com>
References:
 <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-9-gahing@gahingwoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Sonntag, 1. November 2026, 09:23:00 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Jiaxing Hu:
> The RK3576 NPU MMUs are rk3568-iommu compatible but take five clocks
> instead of two. Give them their own compatible and pin both clock counts =
in
> allOf.
>=20
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/iommu/rockchip,iommu.yaml        | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml =
b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> index 6ce41d11ff5e..83d7e7c8e0c2 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -26,6 +26,7 @@ properties:
>        - items:
>            - enum:
>                - rockchip,rk3576-iommu
> +              - rockchip,rk3576-npu-iommu
>                - rockchip,rk3588-iommu
>            - const: rockchip,rk3568-iommu
> =20
> @@ -42,14 +43,22 @@ properties:
>      minItems: 1
> =20
>    clocks:
> +    minItems: 2
>      items:
>        - description: Core clock
>        - description: Interface clock
> +      - description: Compute clock
> +      - description: Convolution buffer core clock
> +      - description: Convolution buffer interface clock
> =20
>    clock-names:
> +    minItems: 2
>      items:
>        - const: aclk
>        - const: iface
> +      - const: npu
> +      - const: aclk_cbuf
> +      - const: hclk_cbuf

I'd really like more justification in the commit message, why these
additional clocks are needed.

Not saying this is wrong, just should get a bit more explanation.


Heiko


