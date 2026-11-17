Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927029;
	b=wvqCcXe+sJ8TGzIyb/bjjTGCIr2RyJPnKGfmnGrclYVf0GS4kxcv3tux0+lvpdkdXlaO
	 AdnRIdsoLrKoBFR9UaxD/dhxGxK6kHKbHoP0HwVtKnBb7CN4dZwB3zGgc2+TvyuKrudLH
	 ZWxtwqgiJ7NXsk0bf5tLguswV/vWGf3TTvUIceJmy4My55OtVO9kElnt3ZzGymiZjcklh
	 ca6h7JiZbn39DOZqVBrRfr9AWKcBdxx/e/v4kGJMfOvFc6jLpsqFcAx/Z+9FvYZ8mIcNb
	 4huJWBGVoh6I1srSWEYvAMnwQpDAwM+4wahav11DFqU9kbDSDJfTcBydkitZvWJyfRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927029;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=i4kIoepEeLRtySE2Wy1kjNABPsmPrG3mk9cqlfxlUpQ=;
	b=wN9APS7QSmSTVLKJhe3vuc64rNlBh+0ZSez6omzARINGr3Lo4IPGsa/i4OE2a6SyB6Zw
	 iv9fs0qQNuqxucegsFn9n3eqBUDpqdI8WfSu5Z5frTtlHCi00k8UbIUMcJ4V7jVKjfKui
	 QehyQwYBAo1Nd+/UQYvLi6Gp8VgE3CEZwlBlmGKrpSiVeymj5PhiXXZHsECG9bTqopm/3
	 qnBMGYJB7wIMSf0R1wkPyUh/sdVEsvkCmyaiLWZen/jM6rFD8f4oxjwtijxC8RWYwpa+H
	 Ld+RBIojca+5qPndsKMdWCtYAfRO+Srvdp4jOZNHcP9z9JvVOPw7/mXiT3yN0SuTp3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hR7WH4UO;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AF606A331;
	Tue, 17 Nov 2026 14:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 674AF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hR7WH4UO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794927026;
	bh=J8ZRNMTFNqyR2sjoXv+dmK7HteE5JTl6kweYDLFKZi8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hR7WH4UOxBlCLvCpuMGcw9Hykv46PwXBjhpdiTDpfkejhrTsaE0jHDbw3d8PXVGTn
	 OdOyDFrUIO3mQY9hZQawDypS8OJrQALxZM9Miq+hnpDA7UK7xvlcl8dEEeHVQwD1TN
	 6kXNqutgUAyzfLb4L/TbXZQAuIWze9W2PhEj7gesOd/QBqsHat0gVV5fLHeRNLHLts
	 9D+9f002rp0pisAB/0D91XF1ra1a4PK/Qm4LKWH/2H0TYX5qaTwGzxhU81lARAInGh
	 Zv52rolneURu85pn7A7S+7R7geOXDRFmTs8KyTlztVv9ohWjyasOqQWxxipKas8H14
	 CPYuMzgp77Jng==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E03F317E0069;
	Tue, 17 Nov 2026 15:50:25 +0100 (CET)
Message-ID: <3fa52671-642d-49cb-8323-8e9b4066a06d@collabora.com>
Date: Tue, 17 Nov 2026 15:50:25 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] ARM: dts: mediatek: mt6323: add EFUSE support
To: Roman Vivchar <rva333@protonmail.com>
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Srinivas Kandagatla <srini@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ben Grisdale <bengris32@protonmail.ch>
References: <20260921-mt6323-nvmem-v5-0-2f5d308369f0@protonmail.com>
 <20260921-mt6323-nvmem-v5-3-2f5d308369f0@protonmail.com>
 <hfElNICOLYWph6ayG04s_yQbkHLXmu6qzdWeR5ObRNxVsBtq86bjnERSJx427OwwrZYipLAOrUGBU8zvYtXEV1ixQ3YBzAZYQ3ypouA66T8=@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <hfElNICOLYWph6ayG04s_yQbkHLXmu6qzdWeR5ObRNxVsBtq86bjnERSJx427OwwrZYipLAOrUGBU8zvYtXEV1ixQ3YBzAZYQ3ypouA66T8=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 15:43, Roman Vivchar wrote:
> Hi Angelo,
> 
> Could you please take a look at this patch when you have some free time?
> All other patches were applied by mfd and nvmem maintainers. This patch
> will be required for enabling thermal on the mt6323 PMIC.
> 
> Thanks,
> Roman


Hey,
thanks for the ping - sometimes I just lose track of patches around - so don't
worry and keep doing that.

For this patch in particular, nice job about adding the efuse support, but now that
you have it... well, adding the compatible to a devicetree alone makes it probe, ok
but then what?

You're not using it for anything, right?
So those 3 lines are "useless" on their own...!

If you also add a user (someone reading an efuse from this controller) I'll be
truly happy to pick your additions ;-)

This fuse array stores thermal calibration as far as I can see, so I guess that the
user will be the thermal node?

Thanks again!

Cheers,
Angelo
