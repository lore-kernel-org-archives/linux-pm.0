Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20F1C28E;
	Fri, 25 Sep 2026 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301226; cv=none; b=HLiTG0Klp4dZZXvxTeepXIpF0OTNIr1UQgebpz1YM6om/nIesDxJzVPlRWBNkOGTymNVP86PmZuytOGIGNAsHqkVU8I4F3Qd33E9UYKGfvK0/ZiDJ1shqLohdUYIqo0ZLer10MaxoQ4BCmohOGWoUkwk7+T/NqJ9oXyeiSPTW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301226; c=relaxed/simple;
	bh=jSezZ8ka+7l6x164+vDYQQG0thI+Di9tJoBHpJCSCV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz+Ts83nAobgNw03nmT4AoYoXMrhrJjLfQc73wEHIiFvALhLvqTgStklcFG0ZIU/ffN97SPHqP0pBN4bGJvXycBLS8MBxVFdzaWZI/tRmuAp5gsm+S9tYhl1T7CipKfzPwrTKymHDGpqNap5r94X2gQ/dp2R0FLnna6YPcHLv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R11Dr5eN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R11Dr5eN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2241F000FF;
	Fri, 25 Sep 2026 01:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301225;
	bh=x/+s1MwXJBsHumxQbKJBC0EHeRCj25bAxBmc4wAGJs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R11Dr5eNi0iOaW/CwqrvUyna0AAECQlFjB6LjWrnWQkmv+fYZ/GOtBgZJFL8ZvXrp
	 8Lxu7v0VRzIA2rC3nSmnT/zgWZjEw6qdqizn+uoVP0mmsCevlh3CiJSfVBPKYQJylV
	 xzr5Z2C9UUvlwgnrDGmIqRiysJ+oeIHBUthjS+zygbINsVCU8c/s5NWKn92ZkTF6+c
	 bqv1cSG1bu9IxgWGtdYLVSpLvzCqzrk9S1ohNFR+LjfJ3qZG4NxnEb5xR46zSq3QWs
	 QR17cvEuFIqjfcn11dYt8b9pnnT3+1/JnN/dPe22JBkV5vlDh7OG2mfxhbwNWuTpbG
	 rw2TYL0tsQkAQ==
Date: Thu, 24 Sep 2026 20:53:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	linux-iio@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: adc: renesas,rzg2l-adc: Make
 '#io-channel-cells' required for R9A08G045
Message-ID: <179030122229.2870089.14696823817437995108.robh@kernel.org>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
 <20260918150730.122056-6-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918150730.122056-6-biju.das.jz@bp.renesas.com>


On Fri, 18 Sep 2026 16:07:22 +0100, Biju Das wrote:
> Add a conditional schema constraint so that '#io-channel-cells' is
> required when the compatible string is "renesas,r9a08g045-adc".
> 
> This is required because the R9A08G045 ADC serves as an IIO provider,
> allowing external hardware consumer nodes (such as the TSU) to reference
> its individual channels. The '#io-channel-cells' property must be present
> so consumers can correctly specify the channel index in their 'io-channels'
> phandle property.
> 
> Fixes: a3152e5c742c ("dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * No change.
> ---
>  .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml   | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

