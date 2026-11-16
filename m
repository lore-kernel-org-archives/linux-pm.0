Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833242;
	b=Zpf2VOVYHDD9ZHsibkHbhAr/89P0iq3TnVP1/mPBktyWwwrPQ7chHMZSiNtgS6xODzsj
	 efCIDJURyTwKjkSxsEA2yoJPA6eDF1eqeia0/jrh2BR6QZGbu4N4KQ9yXUkVPKtvzmyrc
	 lUupPsaOEoOmS314x420DSEl3QAyKoOWneaSZiWHUZ0KYZjItM9/TcqeQE5hLI+90X59/
	 q16hPrwY6oXUyHplgZiZoIsG6Ht+rLdWpfI0B3ZBg6P8aOi9hHGVkp0F2ToNp5Kv+TmkT
	 wWnj4m4HB2qaixu5IWw8SiR23IMzvekf8vedHaVPJOdxVf03sRDAG0wyCuaCbI9X9Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833242;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NUiUgTi9wA7PEI92DOKS15QskouMnxo0HHKzo2bCrm0=;
	b=rX0CZbM1GENXNlRSm9lMaw6+3S6CJ3DYrztCp6kXER8uIX3BBl4wzd42eQH7ikg2rvzb
	 /kC+Ez13P4UbvEAqHPlw1b3NA8RpUf9RlXUbK//LyCKpiv6hKJ2Qs1KHPhtxcCKigegtD
	 wDNscBy77FkWL+jEaL51f0OHWvp71Z9yOgcJonfhFJ0MPKFo0+5rQpA1hctIrqEuo0cBP
	 2CltXghNOJuMo0GOTB0+c/dUnZsVNKLrn1QL2fE3aqZgHR6pshvwk3I/DEAvHcQD3uuqK
	 /6MUyclQ877O4rGHWGQ2cmDbadFOFeblPgowfBoix+J0ti75MgvQEFliivuPQNHkaTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6oNDrzY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F8606A31C;
	Mon, 16 Nov 2026 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6oNDrzY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176CE1F000C4;
	Mon, 16 Nov 2026 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833242;
	bh=NUiUgTi9wA7PEI92DOKS15QskouMnxo0HHKzo2bCrm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j6oNDrzY/QFTLmT4LN5cbHdvxqBU0xkgsTPREFIlOzk3IJOaq5UsPtKF6HN4R/DR6
	 3KyYSjchxwnWO5yO6x1NglTnQUG5AMxeHwPeeync1dBlBU4SLcLDf7ihuYXJTFuBUz
	 fVUXyCWPqZ7VU77Rz+3qZ2FlTFrfuhRqoUqhRpXt8eHauY/oSRm6SL32YXekLKaQg7
	 J+Bw0bcXM1sDCNRkDzWN1NNy9UW1/2SUxa9+pfFXMY6d0ueCmVHdUKrBAvLr09a0kx
	 cl+cc4KRZ8LFcZ2ROQGQYi23uXVVYWM/aOmP3FqNypkSi6hWiSuxmO51sQhi68KHZN
	 DzkxhLJVDqIVg==
Date: Mon, 16 Nov 2026 12:47:15 +0000
From: Lee Jones <lee@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-pm@vger.kernel.org, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: mt6397: provide the 32 kHz output as a clock
Message-ID: <20261116124715.GO6323@joneslee-macbookpro.roam.internal>
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
 <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-2-9758f38d7053@gmail.com>
 <20261113185047.GH6323@joneslee-macbookpro.roam.internal>
 <a6bc9228-8e81-4f16-bd26-2d9c72e9998b@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6bc9228-8e81-4f16-bd26-2d9c72e9998b@gmail.com>

On Fri, 13 Nov 2026, Ryan Brue wrote:

> On 11/13/26 12:50 PM, Lee Jones wrote:
> > On Sun, 01 Nov 2026, Ryan Brue wrote:
> > 
> > >   struct mtk_rtc_data {
> > >   	u32                     wrtgr;
> > > +	u32                     con;
> > These are terrible variable names.
> > 
> > The nomenclature should be self-describing.
> 
> Hi Lee, two things:
> 
> 1. I have a v2 out [1] from early November that fixed a null pointer
> dereference that Sashiko found. I can spin a v3 or resend v2 depending on
> the response to (2).

Happy with whatever makes sense.

> 2. would you like me to update wrtgr as well? I can add a patch to a v3 that
> changes that name in addition to con.

Yes please.

> [1] https://lore.kernel.org/all/20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com/
> 
> Thanks for the review,
> Ryan Brue

-- 
Lee Jones
