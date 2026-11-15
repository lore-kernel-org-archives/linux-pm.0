Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704334;
	b=EL553P4/E01LLASoMi7jmes8w6nrkIk0EFIgaXE+dqOgDuH+i2XswiAyo/btO8FZIIX9
	 WIiK5mcHF86orwYrVfT6jlFE0j2X4WxGU8Ql8XdR1cKQxf4Fv37Cp5Lrhp3HZuoWeKhCf
	 wo5Db+rRo+ydCx7iQT2ICZKBgVxg0/r9eoG5j+jDRkCxfba4Kr1cSDi9Xmm24+VepmWML
	 vgc7PHI08CFzkpu8SPymv8dKf4LCnzvVjoauaOLR/tPuGVWgqSzbtj/BR/WbLkssNGxuk
	 VQxo+Z0rXNUCZouEajUxSBdHIjPLkeJSFw7PPAqpX1ML9VF3Oaq5eNfLVc7uRmPJxEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=k7NOu9mRwqKS6KEdePuU/ewkkmtEQ/cj2Ubt3cKxgyM=;
	b=zezuvcwZ2Dze3uIYtfXPlLtaQuFcOzHILgKNNn5cf2nBSp/pZWX4YAukL+XDTqgPw9H8
	 mdEzZcaeh1ApTVLnkM8DSntUQSnmm+gB5bAwrnQhB4xq7op6cl14d207pO0PhJRDIn6bb
	 SXNIY+dcPeSZ1tDYYXCAFyb0fph0SH8KqNfBgx2UQ9q/IgG/DN0MboXYUX8MUB+rjAd1j
	 4ZgQvpNx0wh5/xeduUAfXdyzWWzhiCky3FY0Z7hM/8MfGLiAqM2KD3/RfbXY8APO563Fa
	 Ur8KVgODwSpMWeHPPkR8J3yIPheVBvsC/wlVO33Z23RB5aW5SmWpH6y+du5C6B9tA1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVLoFXwq;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499FD606A329
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 499FD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVLoFXwq
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so2503923c88.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794704333; x=1795309133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k7NOu9mRwqKS6KEdePuU/ewkkmtEQ/cj2Ubt3cKxgyM=;
        b=VVLoFXwqulWeucnw8PTyUoqoKo1n49Ix8VF4rvFKoBGKRxj3TB3ua9vgyrgU4nL2qi
         PmkoJxjWcOIms1fceHg+BzbYP5MEl2G9jm9hFUHK9J4QhiCX8Kqo8m67i3mnnhzTZLXu
         B7koqJKt5c7cKnQFC1prGlQO4bQiXQ5S76HBq9ky8BOQEcznfXKRoOE9o8dtxJKRVfR0
         jGKlG50HAOdRETaAeo9ct3E1rJju8j5wA5dFycvcn+bvJmkq1Jt0hWkrHPn7nj+pzTI/
         jt/0qZkh6VIukufGj8bLAWqdzfXdUBhON83OXlbaGjqI7UH1Etad5mwVsjEeyePuQ+u9
         OC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794704333; x=1795309133;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7NOu9mRwqKS6KEdePuU/ewkkmtEQ/cj2Ubt3cKxgyM=;
        b=rqrNAZSScePsU3e7BVh5EwMCxpWNufLAjPBuiUGzS7ADeoe1YY+4HwTdNGIztYd2Qx
         CFybsvu4HCiHMsg7vXlDrROpzFUvkPpIkI1At7Ge69wO9xm3J6s06BU7pukie0OnWR8S
         15qPhxeoFh5CwniJTco+VmYsBxxP+dI/uzABrhHo5hioDfF3xy5J9dbi00cZCigkF9zN
         Zd8++htzCK2JoY6cVpxKUgQtEr0jVDH+EJi95+hMc6ZlSDg2H8BRD+o/JOTST/YxHH1k
         4mmj7K9uHFKEZljk2s7+rFIa0GPs66xr54LRd7SCTlzyu5DZOWx0Q4tGfLmXFIlWTcx5
         7KWQ==
X-Forwarded-Encrypted: i=1; AL+hErGdsrnwsVsohHs/CxTedTpw1Q7vN5Zu+xC57+BHes1wfAWD3/l6VGsmD8NMwL2sXS+zxL9Zd8gWaA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/92fw5BVTnGszfVQimnsLvUmhApZOlgKiiBu1jx+vV4rFqYnhT
	Q6fHkySwYM62O3NTOl/nib42HeOiI2zqvlk4URQtB7QTADgQfX0TrV8R
X-Gm-Gg: AYBFou29tnuJzn+kiGVaHdt2jgG7Kmz5Tmy5B/Ptcp3MjBko7uTshxE72pHHi9jBKTp
	VqgUVJJx7WcDa2rEY5hvlsoOnC6oJvx2uc85DY/KlMjE2csrXdueKu+mTAtIOSRmbyxNRmU/fWa
	sfrIBeOjbLkHmNWKItIlNw3WHmKpcOG11+0kT9PG7upKaMMiuIRgMBWT7vKtTmX8/UMhSCeJDUy
	LKyR4SV/A9AbDiiAhBVkjI6JLFwvTAHvh7Ugn8tfjLlUd+9Y3M/by3/S+D5adgrMwoWSmSQEiLS
	BjH2eGQ6giMFmGDnWcYozfcbxsBvcG8Y5gtqM5q4vbSWpHaeJm4uA4jrLBcaebPAcqz4y+zdlp7
	p7ZQPB6asTdwwc9ageBS/AlAfhHpjTYNcaCy3UjfTXBjLdjQRLXyXn9IMDz66Ky+HhFnzTIgsFP
	ZErYu5eQ/C6E8vZCSjvzvv40O8A6gNBQ7vXNTDWyFHUe0mG1RkIjeA8p8qtx1VZpir7NaX6vDDV
	vfr//kvVTjVLw7BAkLGWQJF/DonAOk5pEGVotWtqJcxxU9xEkJsw6/JsPChP7ECStBI0/Q85QCB
	0/80LRuLOj75SWGNc6xNh1A/V/Sc+fFxvWcUm0XO/Iukk60CRdXZXHIi40sCkCVUnD0=
X-Received: by 2002:a05:7300:e9c5:20b0:361:167c:2364 with SMTP id 5a478bee46e88-37966e3ab7cmr7375931eec.8.1794704333340;
        Sat, 14 Nov 2026 16:58:53 -0800 (PST)
Received: from [192.168.35.43] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm35679526eec.21.2026.11.14.16.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 16:58:52 -0800 (PST)
Message-ID: <0f536451-9f7b-46f7-acca-e10e54dec37e@gmail.com>
Date: Sun, 15 Nov 2026 09:58:48 +0900
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: devfreq: event: rockchip,dfi: add
 rk3576
Content-Language: ko
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com
References: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
 <20260921-b4-rockchip-dfi-rk3576-support-v2-3-04f847016321@collabora.com>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260921-b4-rockchip-dfi-rk3576-support-v2-3-04f847016321@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 6:15 AM, Sebastian Reichel wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> The RK3576 has DFI hardware for monitoring the DDR's bandwidth much
> like other rockchip SoCs do. Unlike the RK3588 however, it only has two
> memory channels, so only two per-channel pclks for DFI.
> 
> Add a compatible for this SoC's variant, and add it to the conditionals
> at the bottom of the bindings file.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> index 3450e28b4020..dcf3bbde3e8d 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - rockchip,rk3399-dfi
>        - rockchip,rk3568-dfi
> +      - rockchip,rk3576-dfi
>        - rockchip,rk3588-dfi
>  
>    clocks:
> @@ -64,6 +65,24 @@ allOf:
>          - clocks
>          - clock-names
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3576-dfi
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          minItems: 2
> +          maxItems: 2
> +      required:
> +        - clocks
> +        - clock-names
> +
>    - if:
>        properties:
>          compatible:
> 

When I applied it, there are some error.
Could you please resend it on latest commit?

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
