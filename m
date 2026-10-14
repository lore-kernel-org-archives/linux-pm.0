Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9CB27AC31;
	Wed, 14 Oct 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990662; cv=none; b=FeGDuIse4vdHPr3F8DDGevd1scRhJ+gq1U/i30ox2ByCSrcAGc1ZUNeb2ab6YTe/eV6zPfHFv0CIv8iQLdn2YzLU8opQMJ+Z6Lynrk4nMsTY5vSIjHRnvDtTMK6pECAWovRB7TnGegR/XOyG5L8taDRN4kcwJPNi9kpHfGc9hOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990662; c=relaxed/simple;
	bh=6B/PIgAI8MOwb2IncWXzxVzT+pQ2Zikdt4155BXTSrc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gPZF8GTjdwlfk31XnJDwjWt7C7cJaoUIzcseHvU9zQhVxBPsahjZ2aIixyW/JyJLf1H9TVIfC2qlTqpsrE1Im2de9wLGukVCKph+R0oYoqY1MBC3gMNUVxe478StnLRTuAvFh1AatKKXLb7bYk9RSMCPtc2/AfXknDq5tYXCr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXPRJogg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXPRJogg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D99A1F000C4;
	Wed, 14 Oct 2026 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990660;
	bh=2YlEgaPd6Z9fewZ7p5vLaAWBLu4XzO4vJo9oCsPW9P8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eXPRJoggwj6+DA4iIScqU4MtBIaL6nrzRe984mex7+vl4pDsGwdQT7xoHxuSz9SMH
	 eZMrxgsaVQzgkLdRZW8g0JOdt+gEx0jjsk/MTAZz6d59buSDsb3Ozm+Jh80V8PGe6j
	 ppd1a98OQmjrcO+ZoTQ9T0/eg5n3tT6ePG/0+91m1+WdQXP5Jm/Jer2gfOToQ8XY1s
	 XQdCXlIa9CIVAkuoTSA5Y8UKbz7wcohIo3e8DGbZzAgDzhdpRtC9aTzEhbK8FlUtRc
	 bsrqSV1eViV7HkfoRSER/LE95izqw96AF0rbAAs18FwOKrMXWMbCiOmt/Ol2yFwk7P
	 GcZbxtpzuME8w==
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
 Ben Grisdale <bengris32@protonmail.ch>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260921-mt6323-nvmem-v5-1-2f5d308369f0@protonmail.com>
References: <20260921-mt6323-nvmem-v5-1-2f5d308369f0@protonmail.com>
Subject: Re: (subset) [PATCH v5 1/3] dt-bindings: mfd: mediatek: mt6397:
 add mt6323 PMIC EFUSE
Message-Id: <179199065731.1183599.12412463994737288833.b4-ty@b4>
Date: Wed, 14 Oct 2026 16:10:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 21 Sep 2026 10:50:02 +0300, Roman Vivchar wrote:
> The MediaTek mt6323 PMIC includes an EFUSE used for storing calibration
> data.
> 
> Add the devicetree binding documentation for the MediaTek mt6323 EFUSE.

Applied, thanks!

[1/3] dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC EFUSE
      commit: 017b13566a0dd41188ccea52f9c7cb0074ad8cdc

--
Lee Jones [李琼斯]

