Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E93D9667;
	Tue, 12 May 2026 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605601; cv=none; b=ZnINAflkOYoPgLwS9WqEQuzuAZo/4cBCx0f4e6B3sT6Yckm6ub+Ciyn3UUApE9LlpCLJpRhtFUyDry6dgaOpzpHYELmPWeynQD0mc2rD+bfRE0KB4e/qw67Z3IeVr1fGdfmjF1Pc+6FPj6hL/zXA+uchljiPbUyCWHOpiXpR+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605601; c=relaxed/simple;
	bh=ezfbGln1rAFroxwiTMHKaOWp+LJnHoZZM/cVb1R4ihY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/XTXLlnD8qNffwra/JEbqwm+l7/d6R5bRCIkjTxH1unzYesQNC30Z7fU6Yk4jBQ5eprTK0w6vj7YoNKrZMnDR0sO61raS/AJsmTW0R+EsupUf9R3EsTNSfVkye+S3JHuQumWE5HwMcdRAp8GGx/pfgQqMt8Wuuyi3a6zFXcNHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjHtIXK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjHtIXK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70055C2BCFB;
	Tue, 12 May 2026 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778605601;
	bh=ezfbGln1rAFroxwiTMHKaOWp+LJnHoZZM/cVb1R4ihY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jjHtIXK/1Reia9zFkZTv+Z8tndN2U01vImsudjV7gF3/4f5idlLEdWLA+ghnm/BRs
	 doE0D43i3whpEKjdR/XEiMshzPFWw/6CDnVtU3Ss3bPeMc1Ijgn3vxiPctQtAXDhjs
	 TYDyMF3beTwh9NqzTZqIlQfXrVe5cjDbsrMXkSurImJesRAQFXiPjE10gga6OLzPNJ
	 IrWk58KY8jc6Jb58ACPLiXiTq1JKU6iHbyQNjGgGIYeRxw/QAWgXtWUtuOa8Wium/K
	 0MAZuM5Et2YgPuan1t5AkZMvKMtwKH1cZAovmO+uEN/O3GO9+g0gEeBMFXWeDtDAQ/
	 mmu33be+Bphkg==
Date: Tue, 12 May 2026 18:06:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen
 Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, Srinivas Kandagatla
 <srini@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 01/16] dt-bindings: iio: adc: mt6359: generalize
 description for mt63xx series
Message-ID: <20260512180627.7301b0af@jic23-huawei>
In-Reply-To: <wTd36596tJhd0sPk-1MSi79xz14IBgTKXpD25tnKuRXLfGywkoenZ-wIDtOvRxEZL8xpqijZ0nxMsCFTOJgJq__y26VzCpe_9f0JQGWrJVo=@protonmail.com>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
	<20260512-mt6323-v2-1-3efcba579e88@protonmail.com>
	<20260512141313.425535d9@jic23-huawei>
	<wTd36596tJhd0sPk-1MSi79xz14IBgTKXpD25tnKuRXLfGywkoenZ-wIDtOvRxEZL8xpqijZ0nxMsCFTOJgJq__y26VzCpe_9f0JQGWrJVo=@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 13:55:26 +0000
Roman Vivchar <rva333@protonmail.com> wrote:

> On Tuesday, May 12th, 2026 at 4:13 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 12 May 2026 08:18:15 +0300
> > Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:
> >   
> > > From: Roman Vivchar <rva333@protonmail.com>
> > >
> > > Update binding title to the MT63xx, since the list of compatibles already
> > > includes mt6363 and mt6373 which don't belong to the mt6350 family.  
> > Hi Roman,
> > 
> > Wild cards have a nasty habit of going wrong.  I'd prefer to see
> > language like: MT6359 and similar PMIC AUXADC  
> 
> Hi Jonathan,
> 
> I agree that it would be better to specify the exact PMIC models, however
> 'similar' wording might be a bit misleading here. As far as I know,
> the mt6363 and mt6373 use SPMI, while mt635x (and older models, like
> most of the mt63xx series) use PWRAP (a custom SPI-based protocol).
> The mt6323 has an older AUXADC revision which is not compatible
> with the mt635x driver.
> 
> Would you prefer more explicit list like 'MT6323, MT6350 series, MT6363
> and MT6373 PMIC AUXADC'? It's a bit mess because some mt63xx
> (like mt6333) are sub-PMICs and use I2C instead of PWRAP.
Complete lists don't work because sooner or later they become too long
for a title (though they should be there elsewhere in the dt-binding!)

Perhaps something around: mt6359 and similar SoC ADCs including those accessed via ....
 
> 
> > It is less important here than in many other places because the
> > file has an explicit list soon after this, but none the less
> > we've been bitten by this too often to think manufacturers won't
> > throw a completely non compatible part in the middle of a wild
> > card covered range.
> >   
> 
> Best regards,
> Roman

