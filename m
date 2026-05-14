Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0B3C0A0B;
	Thu, 14 May 2026 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763784; cv=none; b=ufI1YpvhiZVRpfWEhjNOv1y63r43aT0o08FwlBgACwRSnH84R5s1nsgVeaA1Qx4w5XuUvAQ1hp2c7rez8WGhHZHQAhrnuWAPzNQmKb3CIYmN0oTdcqPaCnD5CwM8D4/srZ+INaLh7OqszrmtOuQDXHLjnDQlS53jjhri3F4LpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763784; c=relaxed/simple;
	bh=esmD5ZlFatNDDQ2YdV8QKifdxwq20DRFXsWE4S5ByrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9CAtgL5pp/V0n91oTIWYuA/chUEAK++3T7NtHqHGI5qjzSWGwckJaZCkHtUeHYqNa+wC3jKHyC4AP77wb91yCshTLnHwZOjVM8kkr6hrBw4XlPju3wI4pMAJ34HaQIzm7slxZ6cM7YsTMftRpGFpe8BHi3XrsHT0SQOwU4XWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSOtra3a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSOtra3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03376C2BCB3;
	Thu, 14 May 2026 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778763783;
	bh=esmD5ZlFatNDDQ2YdV8QKifdxwq20DRFXsWE4S5ByrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSOtra3amH98ML2nsdTRfc9GkKHQf/NG1SRcC5xBBbhdVLToWw7QeW2O40zNleM/I
	 I99kb6XciHwEKgmvBPyUhUXcpqDQQGmGGYaJVBiNDJgVXRAMZymfq+mhXL7QPK/FO8
	 krbnGesieD3ZimI8Fe1E43peO4qBcos9j+CUaTqhEsBaciFx9qwit7nale3P9qpFNr
	 iTOsmWRYmA/eq0YJQCEJZr9gvGVatXzJqfS3ezKzxHjkZQ3eLB8Hi01fKXFR9FoV6L
	 34n53iKYgpwIP0J7zZPeHV8LhYpe8SpwINlGDEXxEW/Psx6OS0hrS47wA4eGzdcV5y
	 OLBtsScdLhpXQ==
Date: Thu, 14 May 2026 15:03:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 16/16] MAINTAINERS: add MediaTek mt6323 PMIC thermal
 driver maintainer
Message-ID: <20260514-sweet-electric-buffalo-841c18@quoll>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
 <20260512-mt6323-v2-16-3efcba579e88@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512-mt6323-v2-16-3efcba579e88@protonmail.com>

On Tue, May 12, 2026 at 08:18:30AM +0300, Roman Vivchar wrote:
> Add myself as MediaTek mt6323 thermal driver maintainer.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf2e066f377d..3001a713b083 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16355,6 +16355,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
>  F:	drivers/leds/leds-mt6323.c
>  
> +MEDIATEK PMIC THERMAL DRIVER
> +M:	Roman Vivchar <rva333@protonmail.com>
> +S:	Odd Fixes

Odd Fixes means driver is half-abandonded, so please explain in the
commit msg why you add yourself as maintainer but not really committed.
Such entry makes more sense for subsystems, but if individual driver has
odd-fixes stage, shouldn't we just remove this maintainer entry? If so,
why adding it in the first place?

> +F:	drivers/thermal/mediatek/mtk_pmic_thermal.c

Best regards,
Krzysztof

