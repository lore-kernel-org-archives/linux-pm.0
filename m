Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3170E4963A9;
	Thu, 23 Jul 2026 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823406; cv=none; b=aKzN3vIvp9PtiJ1kpB4yxI0mdEzDfIfTw6xrPDh+xgALPMkYZcMNlOdmgSZYlvC5yXJs+M4K1fqYXwhoy8pJhe3LdxAopSYouRDpP7FRrh3V4hbqaVtsX7OYiib2TwnyCdk+P6u85UR+8wul7W1+YN39vBjeTB8czEOugyaicZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823406; c=relaxed/simple;
	bh=r50T2MhBYrVuycRIdrfmAMALY4mxSQ0LJC3LFARhy8E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIr8XzHVG5SPK0ACHMUQEDSAwhx/F84DFv79QPa2/hFP1B35Td2wkkuaRbxN3DxA++lQYlAbFVu1bviu2hhE/stoGG4EeLTG0kpC8y8OLig3JbNXt7bywBB/E53n5HC6tbUPC1IWkRP8+K6Od/PfjClLf2P+Luc+djBg5ijoijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xlNYzpBi; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xlNYzpBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1784823392; x=1785082592;
	bh=lHj2JaKn6I/rJijt+vIp+5NEvZ+qxwlBgSIZwX/C1FU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xlNYzpBieqQuUSccbe6VE+8q6ZS1yleTG5agbdXP6hhaIWGPxJ07RGkAQukayfpiv
	 BEGrE/J0I5mpcDeDRYHa56Dc3m6URjULGPV+4K6pZMM9xUC22iSZ00c1ZFmJ1JwF/x
	 xUNisBiFtg1WIUiLbsixtqWYBGpu3eyC3tnWqRzQONnTMG/Rp8T5wbq9oRlntbGFn/
	 bYkBwh8RwRAKffdSITgRtvSxrVvY3bmdLZtPnmQ2gnP/VMCqCrfyRqh/syYaVjmHK3
	 QuxUf453uyasa4YaClzO1aoC4i4UlBpqD17MJEyrsC2EyY47Vy/lR3+vlDdwRqzxxf
	 Cv28wlJOzyiNw==
Date: Thu, 23 Jul 2026 16:16:24 +0000
To: Lee Jones <lee@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Srinivas Kandagatla <srini@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC EFUSE
Message-ID: <ZNHaOI0ufFpvkyR3fCOd7I-CO8x9-adM0bJfk2U_TGsQrUGvhUV_8oXVnGWaS3bt9AuhxjXfcJGVtFFFg2X7FOWVcMf1sLK6OpRbtYe9BlQ=@protonmail.com>
In-Reply-To: <20260723160059.GB3526803@google.com>
References: <20260713-mt6323-nvmem-v3-0-205c39267a24@protonmail.com> <20260713-mt6323-nvmem-v3-1-205c39267a24@protonmail.com> <20260723160059.GB3526803@google.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: e13033346bb107811f977e1b6967b3e0e4fc03a8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Thursday, July 23rd, 2026 at 7:01 PM, Lee Jones <lee@kernel.org> wrote:

> On Mon, 13 Jul 2026, Roman Vivchar via B4 Relay wrote:

...

> > +        efuse {
> > +          compatible =3D "mediatek,mt6323-efuse";
>=20
> Nit: This tabbing looks off to me.
>=20
> The example below uses 4-spaces, this uses 2.

Oops, you're right... Good catch :)

We had some troubles with driver merge, so it was dropped from the nvmem
tree for now. I will resend it with fixes (and spacing) when dependencies
arrive.

Best regards,
Roman
