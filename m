Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808131EE7B7;
	Mon, 21 Sep 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983010; cv=none; b=drhoSmodTliIm6DWM15R5PxVL+rHscFMdZYZ5RzfswmpM+pQKWpSxjIFafDWQDzbj6lMhj9K7hvhufZNf3X5VuRgwAYr/qFZ36gEskcdSZf5oIF2kGktMmLJaPIrTJ5SFhycFvhXgqBwltMTxMcoIPPOxcUdGeORxM498ZmQLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983010; c=relaxed/simple;
	bh=+iFRmCim2bL/Hit6Ji1xAwG/vAEbkPWDxu96VVAUByk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q+mW+RbLVLLjmssCrR7zOf2g+kuapmThKRi0nGWCOA6PMaGyKUslcPCpiJqxzd9W78DQQSxcsLVd+jYRKMV+irsz09mHdz6SYaQfpoRKzCN6NFFAOIB6g+xVBSwGA4yRsgzOHQ7ejC8eMGDzuouvoWEpgXZgvgHXioWTPBiNR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6EkPaW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6EkPaW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA9E1F000FF;
	Mon, 21 Sep 2026 09:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789983009;
	bh=fDV7ej+Ox1nQKHx/ew3bMhanMK8N1Rijzwg3wqZsevM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=T6EkPaW8nl5RG/Vrh5zOqyl+8Ps/1gi42E+fU8sO/VxI5JycNTK5ponQGxnzZdn3L
	 DJZjxsqg5xDiRvEj3pZ9GKOV9t5nO7HjNpqnMw3x6TPbd+LP47KW4JmWdCtQlkaxTJ
	 1Cxhv7j78QOF/q3ohDJHw/DzfogmHEvUpte9i7vbKSI4O8ZRp+F5SOtkBLiUmBbvAg
	 zXsZvUwaL2X5+2bBwblJNxkEF8i7CLtp4v+8ehb1qu5LGVWlYxpAbdN91sALGYkflb
	 dsR6LY+He8uO1ODCjKpl2C+fAsZJ6eoY00roHxzQNufj8AJ+xdBcfYpW2PgqHrlRso
	 L/Tif4pXiKUkg==
From: Srinivas Kandagatla <srini@kernel.org>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ben Grisdale <bengris32@protonmail.ch>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260921-mt6323-nvmem-v5-0-2f5d308369f0@protonmail.com>
References: <20260921-mt6323-nvmem-v5-0-2f5d308369f0@protonmail.com>
Subject: Re: (subset) [PATCH v5 0/3] nvmem: add support for the MediaTek
 mt6323 PMIC
Message-Id: <178998300288.889964.6727834790176967515.b4-ty@kernel.org>
Date: Mon, 21 Sep 2026 10:30:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 21 Sep 2026 10:50:01 +0300, Roman Vivchar wrote:
> This series adds support for the EFUSE found on the MediaTek mt6323 PMIC.
> 
> Tested on the MediaTek mt6572 and mt8163 SoCs (Ben), both paired with a
> mt6323.
> 
> 

Applied, thanks!

[1/3] dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC EFUSE
      commit: c29abe7af10aa891da6c0b68274258232ee3a1a7
[2/3] nvmem: add mt6323 PMIC EFUSE driver
      commit: 70a3d85e936cb43165331b9ea470b311a5beeeaa

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

