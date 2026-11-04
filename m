Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765664;
	b=MINcLAyOQr08SrJXjwJNo9jhgkJ5Egge+9scrIZ6vdTBq4G+bP4LZuHEbuGmykCdFr+3
	 fRbicX/HWjDqp4te9mLE5/YZ2b2ttA+zrJqwBgktfd1PbPPzxB41khIkl/wClwcLLoiZc
	 0bs6dCqi/+VOVyv6akkd5jMTO58k70EPydOIrTSj2gIP8r3T9/APsyzzNQrZOxwvAp5sR
	 7fQLb9UaW26V3bhd/xs0TqnNse033nPadr6iKJdHT3WgMlGrzT0UNkRumuWxwfJnpa305
	 zEIFSlfolt27Km9yv8NrIs182aAr23lUYt6Va+nlQatpM5hdDY/g2xPiJSL3DeN+2Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mo2jrEhx3R1WdZmEd8pAxQMx+AigXmp2SsMuSvDCixU=;
	b=L0nKHUwi0rYRxxEq+/+bD4CP3s46YBhX4/eSp9/H0r+2mfK42Q7aSLJFbtCK/FqNtmUr
	 NOlQX1j0AFv2Kn6zaFR0g515cdcCK1fhkXrjrlVLrACgCrrYsVO8VqCZflV6vEIX9+lky
	 50M6YdMdibqiLB92X3TKnmumUaTcV1t9KdOfc502TDfTjLsuizJvW0RiM7nPmi8mRJugh
	 J7CiVn7X/Zy3n/ul5ziE4v3q+EsprfzwxCF7eSj6pO6IjyEqTpMZbJB54oDjFjPDAPVrP
	 lvhJbdw03C0UEkf7n8OTeVUXWk9Hln1JFkfkzR0yv0yXydnsZehM4BhJUZSenpMWCdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="bzqQDg/l";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F17606A328
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 04:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3F17606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bzqQDg/l
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35b2c599f43so536365eec.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 20:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793765663; x=1794370463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mo2jrEhx3R1WdZmEd8pAxQMx+AigXmp2SsMuSvDCixU=;
        b=bzqQDg/lMGz6dfQ7rqjvLLWKj2SVqN8Lq9OKxulhAav2LnwZYXQdZpmC6NjI+BM7Fc
         mX2vXoYj+74+aTstbYN3ykK+SGEgJxP5l/cLySrg2TF05mjSHi/lgG5TsqZFgdvcPknE
         sBQzJOhoL1hBrSbDU4FFMijklZCS/vu66Xs8KZI0aSwRXVub/X9SR+frX5Z4xo1FVswG
         mfqBe4+jA0PESCQGHJDnisxP+vAV43qNDlMjuIHTuHXNTlC2hFXuaVUuRNVWp0kBQ7+w
         abaR+5oODDc3xKrGLv3pPVJavBHsG5mGZQgtCKl6D3pVWEXued21+12lul+RJEgZWYWj
         TiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793765663; x=1794370463;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mo2jrEhx3R1WdZmEd8pAxQMx+AigXmp2SsMuSvDCixU=;
        b=ill9wScDQycO6Je0HzzmtzcuiLysYAyHwR89iFzgEnGor642M1N9eKRZVYkrFP/cxG
         vqyhhgS/U36FrZpM8qw2TH6VwXOlQdER1gVWTrBtY14bL/cvPBDg2NlSmN6UNNI0lF8p
         aaf2z4144bScdEiQfKc5v4oTk4P58yDkQWCTN4LJlGF2gFZZbGypAzTV/MAc4EzBWJ4I
         CSSEDLhPd4nH5gt8ZhzVyaeVmykWHYpuwmqsh1YiR4GVmi+VZLksxf9Uj3Y15paT2RGi
         ASP6Rjv1p1l67DzrUtjfJFl1qWAajYS4exAtEE0SBYpQDc+UmP30BWPScoyNHhvkCuEO
         tqJw==
X-Forwarded-Encrypted: i=1; AKwUvBwZTv21eCbqMcE1glWCveFTX0G2mtWcuYgOGrkC8RC7UvqMj7hrC0/vhkpnry8T5wXfsNzjNSABYg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/WHt+m3F59h4GfU6acar0UYABT4HVpv0hd12Lro4TRIDDUpKnj
	q6pYDAqE41YwM8oUMYq83tdpTiCI/2tXE4tp3aYjV2byjGjjf1wrRkCv0Ht6RSwhvrI=
X-Gm-Gg: AYBFou3FyOqr/hyToPTMXl0SsudR6z9QgzOmVtGAvFllao5akAzw9LfYnFJjcp6l58M
	nUQKyzCJwNSbj1MQtYtaeDXstxcPHCoTWAchUG+a7ZN/8va44GdvcBfJDC29o7iHY+HndmU972l
	QtxeeedGTLgxmLByQlreM3du1xG0EgD5JxA4HDhalqFfgtmdhU/LTAkOopRjuW5QmBU5Ay3cuG+
	UXrUT7xqLm+5cH0WT+ow3xpsK7bfLddkcpgh5R8t60DPQVHnpMPPzaaLlBIKFU+BVRmHK/tZoJ9
	u+VpYPm53pb3kTwJTa/Ox8OKw7qUOXQ0VEgiD2L89Fil+WwBCTVGZC7/x3o6Ynyq1vkLzzPG810
	abOgnv6s6SLbvAB9J8ZkJvI2rUsx+elXAB0/nqPaMvAJUXkyerRLp6RB1QqSDk98CY7TT6TkVc1
	BVyoNjeTmSZkWSvalTyO9Zm1zVn/KNc3uI2uSsf1NhKSPOXVVeuy+E71+6cXcP4I7x03zC+eTiX
	fCXWgxbXzTCL97gxYMepVKa108Q9NxNFgq/jwDmqvPgY2GE1FI2j5dZeMTBgwQYD72RboWZc6W4
	sbZ42EbQd5QcZ+1dExhhb/z+GcybIg==
X-Received: by 2002:a05:693c:6316:b0:36a:7bb7:4609 with SMTP id 5a478bee46e88-36a7bb74690mr6683187eec.34.1793765662314;
        Tue, 03 Nov 2026 20:14:22 -0800 (PST)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca394f297sm3541017eec.21.2026.11.03.20.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 20:14:21 -0800 (PST)
Date: Wed, 4 Nov 2026 09:44:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp: Allow 'clock-latency' with dynamically
 populated OPPs
Message-ID: <auqxGmYmQpWVXNeC@vireshk-B250M-D3H>
References: <20261103224538.877008-1-robh@kernel.org>
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
In-Reply-To: <20261103224538.877008-1-robh@kernel.org>

On 03-11-26, 16:45, Rob Herring (Arm) wrote:
> Tegra210 builds its CPU OPP table at runtime from fuse-derived process
> and speedo values and built-in CVB coefficients. Its CPU node therefore
> has clock-latency without a static operating-points property. The OPP
> core still reads that latency when initializing the table.
> 
> Fixes: 80728bfa8c79 ("dt-bindings: arm/cpus: Add missing properties")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v1.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v1.yaml b/Documentation/devicetree/bindings/opp/opp-v1.yaml
> index 61c080e50859..3dca8f7f146d 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v1.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v1.yaml
> @@ -24,7 +24,8 @@ properties:
>    clock-latency:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> -      The latency in nanoseconds for clock changes. Use OPP tables for new
> +      The latency in nanoseconds for clock changes. This also applies when
> +      operating points are populated dynamically. Use OPP tables for new
>        designs instead.
>  
>    voltage-tolerance:
> @@ -41,7 +42,6 @@ properties:
>          - description: Voltage for OPP in uV
>  
>  dependencies:
> -  clock-latency: [ operating-points ]
>    voltage-tolerance: [ operating-points ]
>  
>  additionalProperties: true

Applied. Thanks.

-- 
viresh
