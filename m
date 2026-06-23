Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FE63C9893;
	Tue, 23 Jun 2026 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202001; cv=none; b=mjbx9w6g40LKdVrLBTHQ7u1RH2kKuWvs+nZvZG0+UQdemrvCNqZeqMCvOqO7uBguoxW9NSSBvvTG6ni57mCuV6yrjwR0PPmHlUdPcf+Hw9FwpxZAVuEW3S8ZzCnQ5N38ZiluUJtLfzm4McRFTWkLRuvTl7Vuw1fHoupAbLbnY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202001; c=relaxed/simple;
	bh=CFLoo+JElQcgGHIJ+5atyHGSTdHrRYHY0TXbGVskXGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yl19T9qu7iYWcpsEG+ZMF1UNVIlKk17MGvQDK4dcCeANyt96ooeAHerdqKHukxpEX160A9ahb7lzE/DINosoF3reNZwKYrWgcBwQFrIwNu0gmGOgehCH9fYrZWOK8RPjzU19u35ZFfkb3aa4HWTzlucSxO4ozaqlOx51nnC1DZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ATvV7J3P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ATvV7J3P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782201997;
	bh=CFLoo+JElQcgGHIJ+5atyHGSTdHrRYHY0TXbGVskXGE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ATvV7J3PTiZSoi1eS2Z0yf2PLjDqV+7SoTJH2wfImUJxkhPq9Mt6uh5KaKTYMpil8
	 EX2II1oU//x4nZgLUJot2ljtla8+/IJDMG0jypRnQDgN7cqk6g6e4nRMw+ulk2V67/
	 i42quZxP9GleHrukZo+loXRmxHOmE2MtnkhWWY2dJ5X9bGIMoLm033l10nxS/qwkoG
	 1vJfRl4HvceYfi5bGNEUGqmw1AJSbSNVo4et+8w/Mh13hA3jDcpGPIZMfv8H2NWO7g
	 4Ids1AOXreutLps+CXnaDBAv1ScEPR+K9oRBuNkxRzoRt3Abvf9yNOpfGdnSavP48x
	 KBlwfOwPgANsw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B91AE17E023C;
	Tue, 23 Jun 2026 10:06:36 +0200 (CEST)
Message-ID: <74f3eec2-278a-417e-b2af-42cb4c38fa94@collabora.com>
Date: Tue, 23 Jun 2026 10:06:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] pmdomain: mediatek: Enable module support for
 mtk-scpsys
To: Justin Yeh <justin.yeh@mediatek.com>, Ulf Hansson <ulfh@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260603051200.1163226-1-justin.yeh@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260603051200.1163226-1-justin.yeh@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/26 07:11, Justin Yeh wrote:
> This series enables the MTK_SCPSYS driver to be built as a loadable
> module for GKI (Generic Kernel Image) compliance.
> 
> This series depends on the following patches currently under review:
>    - soc: mediatek: Allow MTK_INFRACFG to be built as module
>    - soc: mediatek: mtk-infracfg: Export symbols for DDK modules
> 
> The MTK_SCPSYS driver depends on MTK_INFRACFG being available as a
> module, which is enabled by these prerequisite patches.
> 
> Patch 1 converts the Kconfig option from bool to tristate, allowing
> the driver to be built as either built-in or as a module.
> 
> Patch 2 adds MODULE_DESCRIPTION() and converts to module_platform_driver()
> to complete the modularization and silence modpost warnings.
> 
> Together these changes allow the MediaTek SCPSYS power domain driver
> to support modern Android GKI/vendor_dlkm module loading requirements
> while maintaining backward compatibility with the traditional built-in
> configuration.
> 

The mtk-scpsys driver should disappear, really.
This is something that was rewritten entirely and is called mtk-pm-domains now.

This driver still contains support for some very old SoCs that were not migrated
to the new mtk-pm-domains driver, but seriously, the strategy here should be to
migrate those and let the mtk-scpsys driver be there just as a legacy one to not
break the ABI for older devicetrees.

Converting this as a module is probably a bad idea, because this one didn't get
any real update for years now, and I'm not sure what is going to break by doing
so - neither I have any way of testing it.

I can say Reviewed-by if you can test booting MT2701, MT2712, MT7622, MT7623A
(all of them, really) on a build that has this driver as module and check that
all functionality is ok... but I guess you may also have difficulties in doing
that (do you even have access to old devices with those SoCs?).

Cheers,
Angelo

> Justin Yeh (2):
>    pmdomain: mediatek: Convert MTK_SCPSYS to tristate
>    pmdomain: mediatek: Add MODULE_DESCRIPTION to mtk-scpsys
> 
>   drivers/pmdomain/mediatek/Kconfig      | 2 +-
>   drivers/pmdomain/mediatek/mtk-scpsys.c | 5 ++++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 

