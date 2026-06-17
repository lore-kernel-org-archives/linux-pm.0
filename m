Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8C49691F;
	Wed, 17 Jun 2026 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711217; cv=none; b=Cn+L9iNm7SOucTlGyDEvcyYcQDv8KJgme7thdSpUlXFldV71tLl6OPPXvzzl3mp0anGhkcaNUdTp/YK0djIkCx1UQn8dt8oYLhANECtTyrZprKT+Ivytc/lTsf9+GHvvtXj3zU/LdzR+/K2SDHlGwGXFyrTMRGoLANQMDQJIyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711217; c=relaxed/simple;
	bh=KD+ic09IUS7K4Ihsm+3yRFq3l+LDGaDVW17aCqgjLIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VdtxiwxuGjD182jWY8rDR5J7e1m06ea8/rOBLfnaq00oCwHRtHWspsfeqBAesDQvgMIhIbz1Ud8BqfaahnqutxyCjjUOaXzUcGLUd71AJKgCGMWnbko/4pJXtRhvymxA3gFN/3xDVpmnhYWG3jxNjsUHc2f0rVetOUHu7OtXD4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9ORgys/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9ORgys/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECF01F000E9;
	Wed, 17 Jun 2026 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781711204;
	bh=MHJXgDZdrQXug3OSJET//w33iY1x+Rusb29X/DZT8Gw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=J9ORgys/GhA4HTpeMpHgnGulykS+dtFlH7f0szkpPPkby4tQweo00ZhBanut5hmLg
	 fNX92VTENgJ4Cvw/1D7CROusIoLImwfPeS2X791tVdGt0PBJMmQnHo/UtoFcm5ltjA
	 9D/uzTlaY3VTCW6IRlpfbM5cx7Mugmdjcjq5z5Y433wiyyvG/wkAQVtj+jq/qKWAGo
	 cHeLPXq40QNIZG/IzTns47XdF/Js1hfgdLnWW2r5/7sb5IltfGS8iTpTEF7cEidqRh
	 sPZnB2lmALqkxRnhnVRSjSa1vQ+0Or6ZUgmEph+zDmmQTOAQ6b2yGgMkZCOQ07tpcb
	 P/Xj6GFDm6scA==
From: Lee Jones <lee@kernel.org>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ben Grisdale <bengris32@protonmail.ch>
In-Reply-To: <20260617-mt6323-nvmem-v2-3-4f30e36aa0f4@protonmail.com>
References: <20260617-mt6323-nvmem-v2-3-4f30e36aa0f4@protonmail.com>
Subject: Re: (subset) [PATCH v2 3/4] mfd: mt6397-core: add mt6323 EFUSE
 support
Message-Id: <178171120126.1657680.13074561200311670232.b4-ty@b4>
Date: Wed, 17 Jun 2026 16:46:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 17 Jun 2026 12:48:46 +0300, Roman Vivchar wrote:
> The mt6323 PMIC includes an EFUSE. Register the EFUSE in the mt6323
> devices array to allow the corresponding driver to probe using compatible
> string.

Applied, thanks!

[3/4] mfd: mt6397-core: add mt6323 EFUSE support
      commit: f5ce60535d04ca21799d558cfa13ba91bbe714b5

--
Lee Jones [李琼斯]

