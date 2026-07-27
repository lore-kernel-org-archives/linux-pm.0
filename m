Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE217B50A;
	Mon, 27 Jul 2026 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149829; cv=none; b=pLM6Am5f4LwHVK9cthfFhGBP39DymvXSl7FHpGwCtdEKUFpmtXw2SUMXfCWjoALvI4LQTdPewhmLB0rY5L4TPu7X8WxJoe5b2TZSx4apkR67FbRsozAn+ROViuuxRYz300k+TcgTaqXomWQ/jYCnVbFt/UU7/5m3KRP/bzuF3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149829; c=relaxed/simple;
	bh=jQQ4etZmqiYuEsbm4/OMVb1AlonMQGwUbaT1/gx2CSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2VJQm81beLc0CS593uWA6rEw+gcEIxFakmofc7R/BdpvV+/8E6Aol/BQEB+mM3yxmh83nl597DY09MVbkLkmx0BsaGg2kjYeYFZn2sH2lD2N4vk+XkPPI0+gWaXF20NSHVroO7CZPAcuBcvwTqJRdWelUS9Cp3Z4au08sJ+7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=deJNRFHp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="deJNRFHp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785149825;
	bh=jQQ4etZmqiYuEsbm4/OMVb1AlonMQGwUbaT1/gx2CSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=deJNRFHpubJ3qKa4IjLG3bGKg52YdaXIC8Kl4L14FKOSOVSO3EfKTZEkKbDn7FCaF
	 hdpkfqLaI9+WDSpFLdTgfcmD5KTnPWxdz9WE+ppmY1ODOLP96ndh9jN+CH/8KlQq8o
	 JyAc+m2k/JblZnwgPHF8r/TFcNqcbTeThA2wP2SyMpiVlqJR3hJbi/N/dY33Du2AuX
	 rKJZ8HjVXuE9PlzJp1+0r1U2LhinBK9rOHv7asuUzHldDjx1dUmPxqASnIGkg5lPfg
	 Bdr4F1D8nq97uhtvfhhT5EAm85Iaywb9ocq/GpyDR+GiuofzsmRT4xfR/9aiErHvew
	 S4lfu/VbIwlZQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E18917E015B;
	Mon, 27 Jul 2026 12:57:05 +0200 (CEST)
Message-ID: <dd1e30ae-46fd-4083-a306-98e2d23be120@collabora.com>
Date: Mon, 27 Jul 2026 12:57:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] pmdomain: mediatek: Fix MT8183 hang on boot
To: Brady Norander <brady.norander@mainlining.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260722132729.302067-1-dmitry.osipenko@collabora.com>
 <fe909054-5c9d-42f5-bbc1-66ca0ace72de@mainlining.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <fe909054-5c9d-42f5-bbc1-66ca0ace72de@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/26 07:11, Brady Norander wrote:
> On 7/22/26 09:27, Dmitry Osipenko wrote:
>> Depending on firmware, part of the MFG domains may be left ON at boot
>> leaving only some MFG cores powered, to let the ACP to prefetch the GPU
>> region when the display controller is brought up. This doesn't play well
>> with an eventual delay in probing Panfrost when the display controller is
>> fully set up, as that would make genpd's sync_state() to power off the
>> domain while ACP tries to prefetch: this is causing an AXI stall,
>> effectively freezing the AP indefinitely. In order to prevent this from
>> happening, the sync_state() functionality must be obliterated on all of
>> the MFG domains: while this guarantees a power leakage if the bootloader
>> boots the kernel with MFG PDs partially powered on, this is the only way
>> to ensure stable operation of the SoC during boot on devices with such
>> firmware because, of course, those will never officially receive a
>> firmware update.
>>
>> Fixes Kappa Chromebook hanging during system boot.
> 
> I also saw this same issue on my MT8192 Hayato Chromebook, and I also saw an issue 
> on my MT8183 and MT8186 Chromebooks where the audio was broken. I fixed all of 
> those issues by setting the GENPD_FLAG_NO_STAY_ON flag on all domains. I held off 
> from submitting that change as I was unsure if it was the "correct" way to handle 
> it, but perhaps it is. Either way, this issue is not specific to only MT8183.

Audio is something a bit different I believe.

For MFG on MT8183 specifically (and potentially same generation or even slightly
older) there's an issue that is very specific and described in the description
of this commit.

So, specifically for audio, I think that there may be something else that is
wrong if you're seeing such a behavior - as in, some dependencies may be missing
from somewhere (some devicetree node), or something else.

In any case, I'm always open for discussion, of course.
