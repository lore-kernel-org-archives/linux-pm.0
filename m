Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA2F3E172F;
	Tue, 12 May 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605480; cv=none; b=lLTRNX2aVHv6CWXHZW7xL282FXmjeHTXFaxZIMeXzWA9EXfkZF2tQ7tCAMM3yztgUrnY7g3tRv72arO1IXIGbBESwrZVxEVoBkl6pXzJsia+RLA3LYe3DtyK3o2K495vetfEm1qq/d/2llY3SDJlaue16KNcwMHE+aLYGNbxpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605480; c=relaxed/simple;
	bh=9Vq8ijFk8qJn7DB2+1iE5j4p/FmaoDocX6KgE6Vblx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuzQMTrREMPQ8CqYSrMkzuIEvhZ27SDCyDJIWpb8wH0F6sH8AJnRozJMfnPbzSoqaa2jBruY9dqzoUIKZwtbp1RyPevQjDIjw4sFAw6hSUR77XfdEzC8n7cm58llWhB6/4PeoLCp8s7WwxwOknqOC5G3g2HHgVA4+TfSXYcoXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckw8o3o0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckw8o3o0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5208EC2BCB0;
	Tue, 12 May 2026 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778605480;
	bh=9Vq8ijFk8qJn7DB2+1iE5j4p/FmaoDocX6KgE6Vblx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ckw8o3o0c0PfAJEyLSntxYwVU4AbfEuak91RBXrwRvyzNAIe4jv8elNEjpfjPY0PC
	 MkPhOUg9mXjl6MShmhGCSrJ1Wi/YbhNZMV3OMkrZet37w7P7c78VHtD1BGnMduHl3w
	 Tfmm5P5b4C7uOR4xgLVhKFhG4y+fiIzmQsbSbfBFORbEv6M6VS4q5qdE8n9xOg7185
	 EfetoI9BoCOmRvpEw9cIDscSQ9sDtGLuvMyEGuMv9xXcpM4MH3RfGamDSrXuarfIWb
	 B+x8jICCR3r04yE5fHgTYsCHm293bLNlNn46JSSWtoyneqS57vFmlHFeOUhd9JC/Zs
	 Zp9b3Kve5z4jA==
Date: Tue, 12 May 2026 18:04:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen
 Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, Srinivas Kandagatla
 <srini@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 05/16] iio: adc: mediatek: add mt6323 PMIC AUXADC
 driver
Message-ID: <20260512180426.04677461@jic23-huawei>
In-Reply-To: <gWxamwTKyUeOF4QCsiIsrnh7DSWzIKFaY0h83qKq_0vg786xv1uFYhypix7BVO_ruG_vw3DrIsRhIKv5NAzl8hK72rjzPAjwAGU-rhkMgeA=@protonmail.com>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
	<20260512-mt6323-v2-5-3efcba579e88@protonmail.com>
	<20260512142932.5c6801d1@jic23-huawei>
	<gWxamwTKyUeOF4QCsiIsrnh7DSWzIKFaY0h83qKq_0vg786xv1uFYhypix7BVO_ruG_vw3DrIsRhIKv5NAzl8hK72rjzPAjwAGU-rhkMgeA=@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 14:34:55 +0000
Roman Vivchar <rva333@protonmail.com> wrote:

> On Tuesday, May 12th, 2026 at 4:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 12 May 2026 08:18:19 +0300
> > Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:  
> 
> ...
> 
> > > +#define VOLTAGE_FULL_RANGE	1800  
> > Probably better to have this inline - however if you do keep it
> > prefix t he define  VOLTAGE_FULL_RANGE sounds too generic!
> >   
> > > +#define AUXADC_PRECISE		32768  
> > I'd put that inline.  Little benefit it in having it up here...  
> 
> There was a mention about magic values in the v1 for the thermal patch [1].
> Andy, would it be better to use an inline style or a #define here?
> If the former, I'll rename the first constant to something like
> AUXADC_VOLTAGE_FULL_RANGE.
FWIW that isn't a magic value - it's 2**resolution and the one is  a voltage
in mV.  Those aren't normally the ones people care about defines for - those
apply when they are weird and wonderful things not related directly to physical
quantities.

Jonathan
> 
> [1]: https://lore.kernel.org/linux-mediatek/afmnUG8dG0N0HpV6@ashevche-desk.local/
> 
> Best regards,
> Roman

