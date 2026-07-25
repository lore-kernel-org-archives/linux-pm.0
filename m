Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB2317155;
	Sat, 25 Jul 2026 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784956422; cv=none; b=CDJkI9WkqrX6MkXtMcDlHGqR6Qr4IG+LrBiGD5+97QjieqyyfmP9dSLZUVpcr2qO/nuTF2zcQ5veVDotpXEK0JuyQuYfEWlzxLy/1w4nqXd4r57ONBQcPhYS9GdxOmQMwr5HNLHJECrl9y3P6+ZUGdVemG6TKnsq6HjvbZl9Hmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784956422; c=relaxed/simple;
	bh=6iy9lsLPSpj/4HvxSRR6kb/JyAeYR+VsJ4DFem29T4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e62QE8/NbuSvLIL4hNJdJjaiRgzkVVhJ2Z/0nWQ/DWVf+FqoH1WaOQbKjPPaccg8AdGKOuX6vJBJqghCWz2XBIRiBBYJ/SAgLD46+EqkIR3+xzkbB7FWv/h2N0JV+U1kJqgEMjHJD8QiXNXFRsA/71UXQZNFwuUPY8NuD0m5Jy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=L8KaAwyY; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=eGP4+POn; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="L8KaAwyY";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="eGP4+POn"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1784956270; bh=LQ0vET0CaLia9gd+nvryYFD
	7dX3p2pL0OWBdS444Dvk=; b=L8KaAwyYcqh4o0P5of7bWiO6qvpTwJdJODzZMca1fHGK7+SHnP
	90+TSUQZvaOfIMhdCYV3/AkYopDDM8SAcchdmt8brjzDewevYBc4MDK/YzbZBsRgEhu7Mvo1cje
	jansOoVRKQU19H4rjyy/7UWxlpqequuva55ZvwstpHI7WOinIh4L/N41167b8A/I7PsD0TByZWf
	OROkHnyPCTnu7w/QpywzgkG2wkEYhqqD2vAP3ExfljMRJ9Ncp8GzYCHpYDNLZyDPew/4dubCiX2
	nJSkVku1TpndH7ufVfY9wIrt7Vp6mCn/IrDQaqUhF7w/JXsKVPey5nZIgVKZ+JJbb4A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1784956270; bh=LQ0vET0CaLia9gd+nvryYFD
	7dX3p2pL0OWBdS444Dvk=; b=eGP4+POni7ZnQkrKwsV2A+5nml6A+0XXpyqrbBOycM6TUZEzBR
	pxonJHdx7/VB+KdmIkIcB2JJ2pr1E8hnE/Bg==;
Message-ID: <fe909054-5c9d-42f5-bbc1-66ca0ace72de@mainlining.org>
Date: Sat, 25 Jul 2026 01:11:07 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] pmdomain: mediatek: Fix MT8183 hang on boot
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260722132729.302067-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Brady Norander <brady.norander@mainlining.org>
In-Reply-To: <20260722132729.302067-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 09:27, Dmitry Osipenko wrote:
> Depending on firmware, part of the MFG domains may be left ON at boot
> leaving only some MFG cores powered, to let the ACP to prefetch the GPU
> region when the display controller is brought up. This doesn't play well
> with an eventual delay in probing Panfrost when the display controller is
> fully set up, as that would make genpd's sync_state() to power off the
> domain while ACP tries to prefetch: this is causing an AXI stall,
> effectively freezing the AP indefinitely. In order to prevent this from
> happening, the sync_state() functionality must be obliterated on all of
> the MFG domains: while this guarantees a power leakage if the bootloader
> boots the kernel with MFG PDs partially powered on, this is the only way
> to ensure stable operation of the SoC during boot on devices with such
> firmware because, of course, those will never officially receive a
> firmware update.
> 
> Fixes Kappa Chromebook hanging during system boot.

I also saw this same issue on my MT8192 Hayato Chromebook, and I also 
saw an issue on my MT8183 and MT8186 Chromebooks where the audio was 
broken. I fixed all of those issues by setting the GENPD_FLAG_NO_STAY_ON 
flag on all domains. I held off from submitting that change as I was 
unsure if it was the "correct" way to handle it, but perhaps it is. 
Either way, this issue is not specific to only MT8183.
