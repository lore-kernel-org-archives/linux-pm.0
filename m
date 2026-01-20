Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834F318132;
	Tue, 20 Jan 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924584; cv=none; b=XRXrmVVYOdqwEBtcCGsf7M9dLVYtYflummgwLXoZrqvRnMhSUUTs0uiNVgVR9OSx4zrLQn3cB+cVdu0GJ/4/7gMOEoCbeQJi1HE3fzv1uQ3XE/o4+DqGdG4iMhqVn1y7HulNxq9dD9PXkWPUv4TIoF9qopPjPdYxTwFuK8vl+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924584; c=relaxed/simple;
	bh=rSnO2feB5EiBNnb+J7F2y47pDPabNMsyZVGuP2G3Me4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hgyM77ueFknrDf5ghP9GMlrsVkRmRJgOHaOpXl3lS/vsgfbW81CfJ/9bifGSkvAxRH8h1XTs9Ee6EfhCkB5U3HL36z7pt1xETbBZtOzMmR8SPAsj6nJHI3PJokiC9b53+KG4S44Z9L9w4zndneTrtjPPpOxS6I8qSWTcab+1BW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6w/78DN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6w/78DN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C92DC19422;
	Tue, 20 Jan 2026 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768924583;
	bh=rSnO2feB5EiBNnb+J7F2y47pDPabNMsyZVGuP2G3Me4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r6w/78DNUnD4q+ZazBqHFykSpmDASwle1jvKAY2RW9wyLAp/h8G9L5/tjcaI9R/jM
	 9pRu6XIQK58sNBOix3DUSxJAq7MGN3x7E8NTjrtIOI/uILhVnbs0VkuqcaXhSSbzSx
	 swptr9+aCpYx581VWAng2j1zVu/RRPFuuWnCouU8btpDxdR6WRbaoJr10df8ytCsFY
	 UkrqYgEkKKCWWIF25sQTEzeJKUEZJ3Dqe1gPvToi/kSr2kbxMprL3cXbeRU3Qhfmbo
	 qFnEWJIFDqk8tL7fjcl7l7VdEtHtZGx0jqyXBGygOjnA8UewhShmk7XC0A7k+OUeXr
	 NZ9th1dp5NoLw==
From: Lee Jones <lee@kernel.org>
To: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 sen.chu@mediatek.com, sean.wang@mediatek.com, macpaul.lin@mediatek.com, 
 lee@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com, 
 broonie@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com
In-Reply-To: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
References: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH 0/6] Fix dtbs_check warnings for MediaTek
 Helio X10 platform
Message-Id: <176892458032.2302579.3859197830409835881.b4-ty@kernel.org>
Date: Tue, 20 Jan 2026 15:56:20 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Tue, 13 Jan 2026 11:59:54 +0100, AngeloGioacchino Del Regno wrote:
> This series fixes various dtbs_check warnings happening on the MediaTek
> Helio X10 platform devicetrees.
> 
> Depending on correctness, either the bindings or the devicetree was
> changed as a dtbs_check warning fix.
> 
> AngeloGioacchino Del Regno (6):
>   dt-bindings: mfd: mediatek,mt8195-scpsys: Add mediatek,mt6795-scpsys
>   dt-bindings: mfd: mediatek: mt6397: Add missing MT6331 regulator
>     compat
>   dt-bindings: regulator: mediatek,mt6331: Add missing ldo-vio28 vreg
>   arm64: dts: mediatek: mt6331: Fix VCAM IO regulator name
>   arm64: dts: mediatek: mt6795: Fix issues in SCPSYS node
>   arm64: dts: mediatek: mt6795-xperia-m5: Rename PMIC leds node
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: mfd: mediatek,mt8195-scpsys: Add mediatek,mt6795-scpsys
      commit: bbdf8911f92c84c7ebd4a214200391748a1d2ff1
[2/6] dt-bindings: mfd: mediatek: mt6397: Add missing MT6331 regulator compat
      commit: cbc07585c95e08c7223bea753afba85fbe86e54a

--
Lee Jones [李琼斯]

