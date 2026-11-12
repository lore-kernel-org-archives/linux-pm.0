Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459390;
	b=X6Uf8e+Y8pf6w5bnyYz0yQPXJSlZYB9VDb9IBGOw5Liq3F1cLYIHDF1M5lMlYQbHMF5Q
	 bHUZXmNhSCANw/nfP0q9cop0EkD+AUpdsuD910Dc+QdEjRv3B3SeD8ANPpMC+TCVIig6C
	 HVO0/utdTCr9DVbTqj6MxwNvbVgj3xW0gb2minY14JNtEqQJ9NP6Y6wu8Tk6VllrchUoi
	 1Gj9JOIFVP4aDTK39Sui8TWFSFcqWli39zRBW7iy5K/hYF6X5LHtWMchSpe0bX0TwWqZB
	 wCTH4YkaPj3mJA63thi+AQZv5+kxht3szm/0AEaiGXM2KBsSNwILX8n5rtbZzAx8jyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459390;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:Message-ID:
	 References:X-Pmail-ID:From:To:Cc:Subject:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=Q1rbgVKVyvSxLpe93nEfXpS3xxVAJMIczVR08si5z58=;
	b=WA8ZFP4N2Iof3vip10S9+yAC8fZmsgz8Q2uh8PAhrgTR3n4etSkOckkIIRcTevoU7r54
	 fL0oJBYEF5zq2Qa196p/mj6Ym165hhJIIVNaHvK2/GjM1ZdXWuPnH68GOUz4uzyfTfc52
	 TUlW5TRIY2VVvHhYLCHUXm4s+PSTKSq6QAV5BUJxs0xFzyChuSUmh+1RDZE9wQRVpfJ6y
	 +XeL5BxrO2QEgLxEW3UAkn6IKAIvAQ8OFGpcprHHFjcspDLMDhhW9F5Itb1M4qBbRn64r
	 XkUA/uozu+kuLO+hDfJ7CmDis73qPpHf+fwjxhvAvQ4i64Su9nJ25/mWRT19YEAkS9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=brar.si;
	spf=pass smtp.mailfrom=rsend.brar.si;
	dkim=pass header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=Af7TODiB;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=mMvswtux;
	arc=none smtp.remote-ip=23.251.234.54
Received: from e234-54.smtp-out.ap-northeast-1.amazonses.com (e234-54.smtp-out.ap-northeast-1.amazonses.com [23.251.234.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E030606A321;
	Thu, 12 Nov 2026 04:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E030606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brar.si
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsend.brar.si
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=Af7TODiB;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=mMvswtux
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=brar.si; t=1794459388;
	h=In-Reply-To:Message-ID:References:From:To:Cc:Subject:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=hqpDdIUJjjOih1dA6yXpKW8zONvOpjnNAKL20f2cAtg=;
	b=Af7TODiBmaooroEgOtetU4rXexs7uvDwKShRRXmYVVQYN4gydEVv2Kq2Ye8x31rN
	FerXQ6A0IyT7qrI50ooSGuXRcyrmEG2u1RJiom13VsD2IthcMEmqOTL0+yYZ4mOAzVI
	fxppEBM5M/fxVBms/D3HnFyGYvbOwA+SDqJhFg6o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1794459388;
	h=In-Reply-To:Message-ID:References:From:To:Cc:Subject:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=hqpDdIUJjjOih1dA6yXpKW8zONvOpjnNAKL20f2cAtg=;
	b=mMvswtux5JuzzuunQucOE57LRO0G6qwL7rhUI4AI33nP3xOFzNMk0DL2bBJgljPc
	X24MuzP7W58j+cj3lQ0zDUBhJEyozkP5E12La9c7+6Yjr2PdV8HlvsAyuUpdyVBSrua
	bwU6GjPO5d1vBzSAfl5wdAmmzHJxeV/58qbEI/Eo=
In-Reply-To:
 <010601a190662577-fd93bfc1-739a-45ce-9847-727776271c84-000000@ap-northeast-1.amazonses.com>
Message-ID: <010601a1ce1d4a7f-b86fd687-39b4-43bb-a9c2-b438b92418e3-000000@ap-northeast-1.amazonses.com>
References: <20261027-icc-sm7250-v4-0-f9bdaa3c1c7b@brar.si>
 <010601a17d6212dc-ed028a84-ea72-48e7-a4d8-fea315dc42cc-000000@ap-northeast-1.amazonses.com>
 <20261028-classic-sloppy-harrier-72dfcf@quoll>
 <b0d99121-06a2-4674-bbc0-0edeb426e072@kernel.org>
 <010601a190662577-fd93bfc1-739a-45ce-9847-727776271c84-000000@ap-northeast-1.amazonses.com>
X-Pmail-ID: <1794459387709.d8761bad7b35@brar.si>
From: Ishu Brar <patches@brar.si>
To: patches@brar.si
Cc: krzk@kernel.org, djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, konradybcio@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: qcom: Add SM7250
 RPMh NoC
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:56:28 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.5YL5VvZ+qZ0e19wo5UdMspzrKjMAjMWs/SlfuwHJq77JVCQWpVGwyETo7FaXf+sztO4bYMxF6WHssrYHSY+K7X2T1EZhOskwm44pQQStdKG0Jdj3d5ybzIXFkMTcPBXllY63oWIrFhJN26LFqLzTuHiXuqj9UCHxIuFhxi7IM0GCfceBHtKocmWdFsR9dK9X:1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.11.12-23.251.234.54

On Sat, 31 Oct 2026 05:19:35 +0000, Ishu Brar wrote:
> On Wed, 28 Oct 2026 09:10:21 +0100, Krzysztof Kozlowski wrote:
>> On 28/10/2026 08:59, Krzysztof Kozlowski wrote:
>>>> +  clocks:
>>>> +    items:
>>>> +      - description: aggre UFS PHY AXI clock
>>>> +      - description: aggre USB3 PRIM AXI clock
>>>> +
>>>> +patternProperties:
>>>> +  '^interconnect-[0-9]+$':
>>>=20
>>> We actually do not need to enforce -0: '^interconnect(-[0-9]+)?$'
>>
>> Actually is this really a pattern? How many children are there?
>
> No, not a pattern. there is at most one child per provider:
> 	aggre2-noc  -> compute-noc
> 	gem-noc     -> mc-virt
> 	system-noc  -> qup-virt
>
> The other providers have no child. v5 would =
replace the pattern with a
> single fixed "interconnect" child node.
>
> Should the binding also allow the child only under these three
> providers (and "interconnect: false" for the rest), or is the plain
> child node enough?

 Gentle ping on the question above. If the plain =
child node is enough, I'll send v5 with it.
