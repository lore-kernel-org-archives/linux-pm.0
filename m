Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1139732E;
	Tue, 12 May 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591609; cv=none; b=bg1o44jZ0SoK7NWrZXi98QXL7jRD4wfPA60kWKAPmALzsJ4/s7rs6qxvKn0BkPVabLUHz7PRzrGq6dFjK1xeZYMeVCbIjDepeiJSuW/2vhlqZsI3elVUIBbobjVSMFaimFFlq95rhv2SRVHahNkj6Kh5IMWlsU71lKHaojg9Xjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591609; c=relaxed/simple;
	bh=CX64YbIUWl8RdUzb+Ud5wV0VY7WrYZ76F+BXobyWbII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcSUucOkXlfRUEVsQ+SOTeWlBwN9ys1fI7GNdiNOIS5fk4ja+UMEdfnOPRUw3KI49UtgraZYc5eERAvTEYyV24njW+agdFpPZzUrMuTUBk7VN5x7Ebb6aHc3cReo3XAl2SSYWOCYXR09+P4mealoI+jZ3uljQWOx9tbpyr80kDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdVhf77D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdVhf77D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D4FC2BCF5;
	Tue, 12 May 2026 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778591608;
	bh=CX64YbIUWl8RdUzb+Ud5wV0VY7WrYZ76F+BXobyWbII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AdVhf77DDYTVZmGXLlltu0/q6TBCLetH1UoFRP1R3kE5gCkvJp6uotziv0XpbnhvZ
	 ZBXrMa7/wdpIGS7+aqDmIowf/NH9PUFAefogOzbqegaNUk/15Ez055zuXCEOhi4213
	 7+6zJtg/85Ba46OXrtQJQwolpGtGo5gTEf/NW3B/mL13ydYbMpvzpxzkUbbRsX/1D+
	 wkhHl6o8uMeAfTJwPBJ1GhnYK2K6LECg0Ho5SKIlBSe9oWU/r/hexQJ6vxpeB8ypOR
	 AImGo0WI5aoCXBG/wMR3WrOvRW2jC0cMUkJVuWA1FMqJA2ckh1zLgRGWGRm0ZAbqj1
	 T8VMzMJLfQNqA==
Date: Tue, 12 May 2026 14:13:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 01/16] dt-bindings: iio: adc: mt6359: generalize
 description for mt63xx series
Message-ID: <20260512141313.425535d9@jic23-huawei>
In-Reply-To: <20260512-mt6323-v2-1-3efcba579e88@protonmail.com>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
	<20260512-mt6323-v2-1-3efcba579e88@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 08:18:15 +0300
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> Update binding title to the MT63xx, since the list of compatibles already
> includes mt6363 and mt6373 which don't belong to the mt6350 family.
Hi Roman,

Wild cards have a nasty habit of going wrong.  I'd prefer to see
language like: MT6359 and similar PMIC AUXADC

It is less important here than in many other places because the
file has an explicit list soon after this, but none the less
we've been bitten by this too often to think manufacturers won't
throw a completely non compatible part in the middle of a wild
card covered range.

> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> index 5d4ab701f51a..2e8857e104f5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: MediaTek MT6350 series PMIC AUXADC
> +title: MediaTek MT63xx series PMIC AUXADC
>  
>  maintainers:
>    - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

