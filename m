Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793423978;
	b=dEP72avJ2pPFFdLj6TFdWm5pxm39YJYJKmAL7pBT93URnNJ8x8m6fNlGUkfZnnGglG5D
	 jLBwri1W5RqOuphf6UgkSz5sGbkf7G6Hub3VTf40IR7lJMS0HMoBuDk8fc3ejnHflTP7B
	 UbbrL+elqaA1KjVS71WO6iBlFPDNLQEbnh9vc+l+lIZT7lB4UipZIMh0fY2TR3xWlhbWw
	 yz2muHVq6+Td2qVF5NPHnv/t+RMOc60BtVfxEIRdEs7PgjVoUmQdRT7xO/6ecMSWbic0X
	 frKHR0Xq8ECv0EOF7bPzJygJDljc8AWT/5DovGoHdDG4dP0kwZG7IWNQqFQcZhcf6Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793423978;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:Message-ID:
	 References:X-Pmail-ID:From:To:Cc:Subject:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=aTrjdhAZkYsM2rcSRWE3MAxfT10HTPL5Pfouv/xeRtw=;
	b=f0S8nEWynGFyXS922aitM0VPwRqEYJyZxxwLmgj/SDK4JWKiS+1k5xjyWUzqRTyBRD2i
	 SeDmgCQ59rkHihpPRloDQAgc759es7umptQpkti0fD9tNINorc8oIl0IM7VTjg2GQoCVM
	 0vn/dywhmqpDRxH5Hal5BtN9wFIOUeKaR3MDRKwkoyylElDmkd5EW+E49aawDdXLtfO5n
	 u9prep8mwPi42OW+VFjpdqkRLBW4ynVg8Yt0rmVMZyioaiL7q7hJxbamsWuOVnfj1fYFp
	 4Zc7viSpFVYhCOyyn427lPYdLKwg/kon3bZM0XtB7cOTG33jKzIyZ2A33z9R++KwBzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=brar.si;
	spf=pass smtp.mailfrom=rsend.brar.si;
	dkim=pass header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=CPXENnup;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=ZYZrUUFZ;
	arc=none smtp.remote-ip=23.251.234.51
Received: from e234-51.smtp-out.ap-northeast-1.amazonses.com (e234-51.smtp-out.ap-northeast-1.amazonses.com [23.251.234.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA79C606A31A;
	Sat, 31 Oct 2026 05:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA79C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brar.si
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsend.brar.si
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=CPXENnup;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=ZYZrUUFZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=brar.si; t=1793423976;
	h=In-Reply-To:Message-ID:References:From:To:Cc:Subject:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=j30RlGk9uaAKzG/CjGIFRv7T5BN+RZPMz5USnZpOEec=;
	b=CPXENnupum6hY+bn7mN2eUwZvZjAVrC2jL9X/1a2bASFFLwgflzsIgTVuNIfqSeo
	QsQpq8vxqMnjUNi2azN5fPGi9qBxHl2AtctcBv3pFbMYV3oDSKLpukptIMQ3D+2T6pF
	NnEYXZ5OxWTUloTydpiAugHL9en1zCLZeNUeScxQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793423976;
	h=In-Reply-To:Message-ID:References:From:To:Cc:Subject:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=j30RlGk9uaAKzG/CjGIFRv7T5BN+RZPMz5USnZpOEec=;
	b=ZYZrUUFZmhQR9dWjvM/194DChU2iHD/Hv22UGbmGybqsQf32WvNCUbsLL6V/AWSP
	Rld517D0varKE4USh6UwebHy9Msu0nR2V5ICIZlxCD+b4Dln9orTpbIucCf4RicFePC
	O3cODxPnfPP/3T7zeR0YEm+OXov1mViKmWN88uJI=
In-Reply-To: <b0d99121-06a2-4674-bbc0-0edeb426e072@kernel.org>
Message-ID: <010601a190662577-fd93bfc1-739a-45ce-9847-727776271c84-000000@ap-northeast-1.amazonses.com>
References: <20261027-icc-sm7250-v4-0-f9bdaa3c1c7b@brar.si>
 <010601a17d6212dc-ed028a84-ea72-48e7-a4d8-fea315dc42cc-000000@ap-northeast-1.amazonses.com>
 <20261028-classic-sloppy-harrier-72dfcf@quoll>
 <b0d99121-06a2-4674-bbc0-0edeb426e072@kernel.org>
X-Pmail-ID: <1793423974923.5b783470d46a@brar.si>
From: Ishu Brar <patches@brar.si>
To: krzk@kernel.org
Cc: djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, konradybcio@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: qcom: Add SM7250
 RPMh NoC
Content-Transfer-Encoding: 7bit
Date: Sat, 31 Oct 2026 05:19:35 +0000
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
X-SES-Outgoing: 2026.10.31-23.251.234.51

On Wed, 28 Oct 2026 09:10:21 +0100, Krzysztof Kozlowski wrote:
> On 28/10/2026 08:59, Krzysztof Kozlowski wrote:
>>> +  clocks:
>>> +    items:
>>> +      - description: aggre UFS PHY AXI clock
>>> +      - description: aggre USB3 PRIM AXI clock
>>> +
>>> +patternProperties:
>>> +  '^interconnect-[0-9]+$':
>> 
>> We actually do not need to enforce -0: '^interconnect(-[0-9]+)?$'
>
> Actually is this really a pattern? How many children are there?

No, not a pattern. there is at most one child per provider:
	aggre2-noc  -> compute-noc
	gem-noc     -> mc-virt
	system-noc  -> qup-virt

The other providers have no child. v5 would replace the pattern with a
single fixed "interconnect" child node.

Should the binding also allow the child only under these three
providers (and "interconnect: false" for the rest), or is the plain
child node enough?

Ishu Brar
