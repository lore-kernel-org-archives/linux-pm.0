Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792597473;
	b=SB/a2qQyoM/zk5/Pc3FfVTv2iC7eHMY5gUZmESugAsuNQbwUKQtAX/thNJg/NBnLwPCk
	 BqOKimck3HQyYwT/HPa27Y2F22aT3hBTZC6Z1hsjMF5oZXc5/pSHKSi8gbYG7ZZjpUOP8
	 WmZQFKlGlcHZuYimUOkvVnsKekTQCwaj3c34jAmIzyT8RGiURZXbw6qLqQtsyRAfwyFY0
	 62lQPdccJTqXN56kUo3/UaOTJ+ZQ+Mi+uXMcML0WiKFc9vkC3Gxva0p5YG4ZKAC7tczgY
	 EMeCVyxs+uMcLxOyCtcJO0B1ZIHABRldhLQGYtU0LUWbsfqUETYepG/yTROyZAFJ+oQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JP3isnTjkGCFTemUyIlLVxDc+jortqiyhczyp4kIfzM=;
	b=KRpb223XNK72+uxkBJ81xGxSDXDU+fArUwnpK5ZLoN2v2R9Hfk2odUNf/HKCIO/3Ns0C
	 QQqGhUB/6PGmXfhMbgiR1DbRlgqkOh/EK3Flj0S4ydcpjp1/WKZop84IX/RmvzPnmsIxb
	 AJUHQM9SqHcMmHk5Ropf3tsdoDb9CtAWq3Fmw8NeYb0/5qbL3bN3hQWQDmDSbQVue+BLy
	 6bVKYjo7RLwJF2joqPnRDdhZyvJAiWsim1CGPbH2RMZ2IV2JzQ4xD/f1honcOzTnKlICl
	 pGk9LS6kyv+fglFl3jXyb+enPuG8xvlEzxLlvT6hYd0LJ6dJlLdDd821XajckhKGgKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b="fT1Ejq+/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5960A2619
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 15:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8D5960A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=fT1Ejq+/
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so1088776a12.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792597471; cv=none;
        d=google.com; s=arc-20260327;
        b=PMhCO7Pg6Mnz8MVeWVE8oEwXGJIqMRUufn8n/B091+8qt19SV/stqDods0HFPchwp5
         IHvhLg4GcY7UkXWiyCl+ccnwtZGLlrSyBARCKvw3ytE2PKVD4f+tsDI+WdTQqDknTVzn
         ZFq26NUq9YcWAX7S70GwvAe9q1ytS6P3x9jzlqm2KdpydRqautgaObIJgsf6bI52w8dv
         s/tqkoUpXoBNynOK7WQ2ZL3f62+Fr77yb8KRrNVS2EI0N+wcA+7raSdYRKDxL+FbW/LM
         q8IZVdMMCZJlRsEV2RulbrPtOYH1f9FVf4HkJGlH1pen6C7yn0dsexjF4Jzkc4Cg8QTd
         1jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JP3isnTjkGCFTemUyIlLVxDc+jortqiyhczyp4kIfzM=;
        fh=HXPC8u+Ahr8lQ3dRnpSQYeDde6Xtr8yZA7yT0TDx9cY=;
        b=BIWutzbiY/NuMkLpKB3uetfA8+yNtp9i/ksVpEyubhtX49lEN/x85GmbHprL1Sx+7L
         rL/1hwr7gPSRhg/AogfD+xlqWGGGpOougDQ10P8ZkEqqccxSab1OTRyKAngrkr2+kJJx
         QpUf4RMjLGdz+K2av3bRtMo3dv5AK41LwIanofXJoPIXeUNct9s4RzoWkUZl5Vp9cO3w
         Y3rxp7hNpJb3PBfH5ogfp3YSomrx+TvoFc2vnAxpASAgUh8KOuntW/cHGaby/gH4iFp4
         4Lij698M1sS/CAWzKT+fbalY4ObcE8/4IwN58U7Vwmt0Lhp29+Rmq31CnU3ica7IInM3
         lxdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1792597471; x=1793202271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JP3isnTjkGCFTemUyIlLVxDc+jortqiyhczyp4kIfzM=;
        b=fT1Ejq+/L56l79ie+PNmdQbxUE9/wPpsUh5WzFCARRIo7DhXjRMQdSMvNzHnT/eXUK
         U1uG49UybtIek/3tGTHsFnortB7I2Ud3eqM90D/fcwX2ZoNpWpLOYqIySWj5tZGiVmo5
         A8c4weGoCSi9qGxJAFMQK7fltmLgJitKz6b5FZvPv8IhrMLbQUQ3XkwLPLN4X5zIAw7V
         jDdMr7FQo9B1Jxu6a/lEtrZm7yUThf57nza2x9rNdhhjVZ2bCwn+ycLxa1LDU2+7gAwM
         c4w3om4KynnPQ8oVYNL8wqUCw1p0MtaOC4BAZXAZdu98lWHTUOJYF6I9QRNLwZnlW/9S
         b/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792597471; x=1793202271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JP3isnTjkGCFTemUyIlLVxDc+jortqiyhczyp4kIfzM=;
        b=I0U1CAs1eN0WKxwIgDyPUWzCOuaALTKWCAxYGg5NheR+guafIxqESMt1LRZKsO2nQ3
         cd1BBkwEMesVECnbTF5iXDOtlTgF+paop+I/QmxKLD8gEPbeF+18fcCw0WEDZcmoMnnR
         DG71m6ZmOR/LMndSJtSIDwqTo2hWlNBAXOVdRXpBg0HPUKJ3MoHhyQXeDwCqxPIV5aHf
         +/gCPBkxkkQ30aoUXrAhecyT8VJbcK1Yekg32yDO0G6i0CDfCr/n0eDfPgPOx8nmjDyU
         X3djh6xML1OgfZTptraw6N9UAhHGTONubhogTI5pO5kHZcPjXy4UVwfSuIU3AjwTDnuU
         yJ7g==
X-Forwarded-Encrypted: i=1; AKwUvBwrUQcuV86YR/72FZEsx/L3WWLA5xVuvduORUDHZ0/NcI/kA+W/V6G+ZT/cyvv+4H1lQyykP2CBuA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLhJhtOg3jSv0CV/y3HuTg2Cz/XtElF9eo1MtbJDqkRzJjgYHa/
	cLunAxcn59MdIbaW7zdGr6yu0f2RKERrdavO7vkMTCCDKrSQ/+6Nl94ZATUHSjLurS6eZuzyxsI
	Rm+nSr4DlMwPJ59ifczzDTGH2DjaTuQGOMgeqomXeLQ==
X-Gm-Gg: AYBFou2okutSyMk3FHTFiIkGNbyOVVPSWdFtR7KZVpO/LW2Lzl4Za4z1x7/OfeiggFe
	fqN8n1vPnQvPKBmYuEY6p2pws8F7i/+SUJdUUOI27A8x0mZNwZxrscYWMGpdazqSW5j9nyfNGUR
	rEvbbuFh4tfENZzSYAcqZer8mmJjEnp57VgtLcAL7VYG4Fr7gcJRjScRqphp+3WxMUy9pzsqK4X
	Ww4SspJWRjo93I2TmmGSzuohburOTeNNaW7cR9dtwofYOGmKg5wfH1QcKB7LVRMM5jIfdRUe0E6
	cw7m0n3JWlR+uWho/DgfY5Tck9AecV+TzBuap1YMm0EcUGjQd6E81jlzyl7XWVpY5KSZAxtLOmC
	SruYe9FjC48qn7k/8bgHZW/A+XajeQoulsyAJngRHWD37rQf3ahD0ey2nCcBFWXyFxbuWJg==
X-Received: by 2002:a17:906:4fc8:b0:c2d:ca32:2176 with SMTP id
 a640c23a62f3a-c467961d9f7mr245660266b.8.1792597471151; Wed, 21 Oct 2026
 08:44:31 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com> <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
In-Reply-To: <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 21 Oct 2026 19:44:20 +0400
X-Gm-Features: AclHuK_OzLUc98RwVb-VyZ4la1jnJworigni-GUiOSt1W-ytIr-eQQIArUmgwS4
Message-ID: <CAKTNdwG5XA_chr2ZM9qTnr2RaDMzOjdb85bRdCr4aJCr1EGy7Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add PCIe M.2 Mechanical Key B connector
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

On Wed, Oct 21, 2026 at 5:51=E2=80=AFPM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
> connector is used to attach WWAN Adapters to the host machine over
> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0, selected by the
> Adapter's configuration pins.
>
> The connector provides a primary power supply of 3.3V/VBAT, along with
> optional GPIO signals for WWAN-specific power/radio control:
> FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1#/2#, WAKE_ON_WWAN#, and DPR.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
>  .../bindings/connector/pcie-m2-b-connector.yaml    | 146 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 147 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connec=
tor.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.=
yaml
> new file mode 100644
> index 000000000000..a7f4bcbc5119
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yam=
l
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key B Connector
> +
> +maintainers:
> +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical =
Key B
> +  connector. Mechanical Key B connectors are used to connect WWAN device=
s to
> +  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB =
2.0,
> +  selected by the Adapter's configuration pins.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-b-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for the 3.3v/VBAT supply.
> +
> +  full-card-power-off-gpios:
> +    description: GPIO output to FULL_CARD_POWER_OFF# signal. This signal=
 is
> +      used by the host system to turn off the entire Adapter. Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO output to RESET# signal. This signal is used by th=
e
> +      host system to place the WWAN Adapter into a power-on reset condit=
ion.
> +      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for more
> +      details.
> +    maxItems: 1
> +
> +  w-disable1-gpios:
> +    description: GPIO output to W_DISABLE1# signal. This signal is used =
by
> +      the host system to disable the WWAN radio on the Adapter. Refer, P=
CI
> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  w-disable2-gpios:
> +    description: GPIO output to W_DISABLE2# signal (default function of
> +      GPIO_10). This signal is used by the host system to disable a seco=
nd
> +      radio on the Adapter. Refer, PCI Express M.2 Specification r4.0,
> +      sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  wowwan-gpios:
> +    description: GPIO input to WAKE_ON_WWAN# (WoWWAN#) signal. The Adapt=
er
> +      asserts this signal to wake up the host system. Refer, PCI Express=
 M.2
> +      Specification r4.0, sec 3.2.13.3.6 for more details.
> +    maxItems: 1
> +
> +  dpr-gpios:
> +    description: GPIO output to the Dynamic Power Reduction (DPR) signal=
.
> +      This signal is provided by a host system proximity sensor to the
> +      Adapter to trigger a reduction in the radio transmit output power =
to
> +      meet regulatory SAR requirements. Refer, PCI Express M.2 Specifica=
tion
> +      r4.0, sec 3.2.13.4 for more details.
> +    maxItems: 1

This seems to be missing the four CONFIG_* pins, which are quite
crucial in these connectors, as they define which interfaces the
module asks the host to provide on the respective pins. Without those
module type detection is impossible.

> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host s=
ystem to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.1=
2.1 for
> +      more details.
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on th=
e
> +      connector. Since a single connector can have multiple interfaces, =
every
> +      interface has an assigned OF graph port number as described below.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: PCIe interface for WWAN
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: SSIC interface for WWAN
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB 2.0 interface for WWAN
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB3.1 Gen1 interface for WWAN
> +
> +    anyOf:
> +      - required:
> +          - port@0
> +      - required:
> +          - port@1
> +      - required:
> +          - port@3

This misses SATA which shares pins with PCIe. PCIe second lane also
conflicts with USB 3.1/SSIC, which isn't captured here. Should it be?

Should the graph also envisage connections for the I2C bus (GNSS),
audio (2 or 4 wire), re-muxing of W_DISABLE2# and WAKE_ON_WWAN# into
HSIC functions in Port Config_3, GNSS interrupt line and the such?
Should the connector node also define pinctrl configurations for each
of the 15 interface configurations?

Best regards,
Alexey
