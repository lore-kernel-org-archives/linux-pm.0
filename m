Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C93603F8;
	Wed, 22 Jul 2026 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730680; cv=none; b=lA4cdWcg5oGt8sTeW3247G6+GBOwTnWtRvhbN/deJ0LkZYv3+JfQ3143PwQGsgp6c22FDW8KC48YdE+JuUoRzGqoXAZmnkq773s2HqE610AOZ9/NXpJYMXawwXU8iUZIlgtYDh9VeVqDjZY0cWx6BgA0KUufZvTTFKB6Qmzp+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730680; c=relaxed/simple;
	bh=Xy3tAVt5E7mi3XkBjs6KrEBelylsYHGiFrUqKz9Q8DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9Ebf8rdRfYkNFnqu5j4tO7J6cO1h/E9zgFqTzfEph/Ab9B4BYJ7rikmQm20CcCqC4gA79ATRQojbvm7Tb6hOJyHBxrWnZr+E39QI0Mh14FJku843w8ApqyWOVq9GsYq1bypl5LJMw+uRTfIHhRnpfzhjX6Pv0ApYzWWt/83KiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WmTjGMWk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WmTjGMWk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784730676;
	bh=Xy3tAVt5E7mi3XkBjs6KrEBelylsYHGiFrUqKz9Q8DQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WmTjGMWk9WtTkZLaRbY+SYDd9kDvymiWfkBTTg0DaReP6qlQWDho8rQo6cjQnW8s2
	 firq1bdfIvJYJcR82j3j/KGHxRKRvr2rfQ/yks/wXPHbazcn3vKQsDMuZp0/BuQpIk
	 REkG+DUjS33EryikB2yy5zARTD/e7pirB4kE6k4AZ/DZYnCSC1Svmjy4KwUyZJgnMv
	 sQ8UtcfR0rgqJrLbRAbAEZhtODn5i917tWCgG+rO12GGGA7ASQwIItT9/YnvzST1Y1
	 no+kl2yZpfEqAyqU++1ZFr8LYVunH9D13TzWjhEs5OeVHAyNBNzEPI0q02y1Q32Ksj
	 G0tGfjf46lOmg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 44AB317E023C;
	Wed, 22 Jul 2026 16:31:16 +0200 (CEST)
Message-ID: <84149703-21aa-4432-87e0-eeab49e0fa24@collabora.com>
Date: Wed, 22 Jul 2026 16:31:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] pmdomain: mediatek: Fix MT8183 hang on boot
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260722132729.302067-1-dmitry.osipenko@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260722132729.302067-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 15:27, Dmitry Osipenko wrote:
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
> 
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

