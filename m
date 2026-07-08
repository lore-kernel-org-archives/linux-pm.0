Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C273E8346;
	Wed,  8 Jul 2026 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494316; cv=none; b=tvC1g7w7VS1lMuE2wNmFoZnmK6QmmnZdUMEoEmIafuYDxGEAHcJTUdvmgXwj+k7JzWG+7DgtMwJ/5CZ548tu256l1DoXx3wZrVNuK/j4LDJWKdmVBlyl4LzRx8YaxS58Kbw65OxUKkYnTkOyB159uhUyR34gYIn1lWw0SKwHOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494316; c=relaxed/simple;
	bh=sTtDkbauuTT3a7DZ7U6d9xTz2Zyf1AVhprqSR1RmDGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aazLsVCx8RvRsPkYVOBNNRtsS6ym60HjnFsyYmHw3tmr3SEmNIP+RXIqUvAWS8B4Zbiw7zYo1HN/OrwvqfSj2BBDvA5fm5E2F5ijTSrS4C7Y09/XEHC/7njy750bbzmkAvL15091wPRCWUOT8otLtC7e0qKU86GFwKleI3bQYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db6dN4K1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db6dN4K1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DAA1F000E9;
	Wed,  8 Jul 2026 07:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783494293;
	bh=blQnLE3QF5OGl50/VGSrziVsUsYR4d4CLR+QxxJMASU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Db6dN4K1AdG21HPkpWzWQ0eFqmwQLsnC424gTKAuHfBxcTm1bqcX+NfJWjpWojk6c
	 FJXPhJVoa9oLvP373F02aYAhcQYxvuZTvhG4eyuB6h3NXZaJmdj+Q86WhIKoT56nuC
	 WRHVD6CmkAXdR6i+OJs4T4wFfHJqHB4/KSoKqPnPxXGtaqVOte3QZ0zNadqm4iSMaQ
	 ZX1hHbT5E6fQkkZcJ/b5rVm/SThbozAz7BjvLmX4gbL3t098nmtc2BXsUHDDZajoJ2
	 pECPGKxGIc76g6sySi7ZqMJlVC2u3ftXJ+4jFZ8D++wpvdLTBJkJoGdtAC6MoYysCw
	 tlPcRdwJcGEgQ==
Date: Wed, 8 Jul 2026 09:04:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, nfraprado@collabora.com, 
	irving-ch.lin@mediatek.com, macpaul.lin@mediatek.com, aford173@gmail.com, mbrugger@suse.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, justin.yeh@mediatek.com, 
	kernel@collabora.com
Subject: Re: [PATCH v2 1/4] dt-bindings: power: mediatek: Add support for
 MT8196 direct HFRP
Message-ID: <20260708-poetic-ebony-tanuki-dbdbe6@quoll>
References: <20260707155535.199383-1-angelogioacchino.delregno@collabora.com>
 <20260707155535.199383-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707155535.199383-2-angelogioacchino.delregno@collabora.com>

On Tue, Jul 07, 2026 at 05:55:32PM +0200, AngeloGioacchino Del Regno wrote:
> Add support for the HFRPSYS direct control power domains in the
> MT8196 SoC, controlling power for the DisplayPort and for the
> Embedded DisplayPort Transmitter IPs.
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/power/mediatek,power-controller.yaml  | 1 +
>  include/dt-bindings/power/mediatek,mt8196-power.h             | 4 ++++
>  2 files changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

