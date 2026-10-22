Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651064;
	b=AQijbpKl2F722ILBGovQ2tGoeRlHzD/20WMiZDnKh2Gp8E5CPmU8bflhe6i9xQoaA6OJ
	 t1QL4Ghed4Bn7XvFGV5JOiisLh7QWjENizlnYBVr737MvjW5ydq5huLlZnLDi52UwwepA
	 Ey1PLDbIKJS0PECFF+/wp+PScCcjD0f8DTnDlPt4vaSZuNNnswJ1EZ/onaJr3Gs90slWz
	 EXcekWHJEYjovJuJQ/2lfK+KRO5TakC4Cb+Klx5yTkZm8ZoV/ZVB7xp0gP1+5vsgKyjZS
	 jA6Jq4J/IJqwiOi462NUBkUbkXAyhz/T9FT+k6FqKHG/UiTcplOzZ31Gi/y949ueFoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651064;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=VQFTusPZWZAQO9ncVP5/pVATTKlUKVRB9FJ/9plts7M=;
	b=qxsERAmFXfrWt3rPadL929akjVfzIviyF6nO/RjFScZUdqbbvQeH8+KIUGj/67ZdMAh0
	 NKReBPUjAoqFfMcBQecTbssQiGFUxD71F4PxfP0aZHxXe4vcAhLUayiuSGVatSIllDeGj
	 mnJy3o0vMvJgM80ck6ujDurBr2v0PZiW5ojtikuaaHNiNaep3kBMdhhuYTPzE3apc3Q+L
	 ocvZ7RYL9Vn48n1tCU0z6uSRWwXAIQj+u6Af5bjacVKcG7CjATg1+SP+7liunfk1JjEbP
	 UnXTovOPvsM3dQdtzSYPiDlGk2HIRBJEbXPe66BRAsvFVRJUKwdShXae8r3wddZlo5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GmTf6oYL;
	arc=none smtp.remote-ip=43.163.128.47
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DCC606A323;
	Thu, 22 Oct 2026 06:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68DCC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GmTf6oYL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792651052; bh=VQFTusPZWZAQO9ncVP5/pVATTKlUKVRB9FJ/9plts7M=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=GmTf6oYL8AKlduANqJiMvZbkQOf7gKp/zQwFXmoaknAFcT1VltESHTOaOrg1fcjsW
	 ooQVtPfnStMG4UMWTARNwo+QdJW0/ktwQv7oAfnOSn7krkbD0yr8PCfT2j9MVsT4Ld
	 a+4EUQyPnJwSlLkvXFQ17TUOpHSAfKWsStATXj6U=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-XMAILINFO: N6vT1niysq6m+dolIeSRQmZ0Z/lSCBqEUxgMgKnhlcqyDzFYwRYb/nFI862AH8
	 hx16FZ7vQ76yOO4KNrAZLP9nGxJ89E38Vmc3rNG+xB70iOUAV7wSRAQwTihTOulk5fqrM0fPZ230B
	 KEjiMz7HM7L4qzHyBVCqvG9OHxF9AE9K5R4nq44q5B5A5vDvoF2e6N2kZaxF1Xwl7qyXn0HPU+w0q
	 jx+hU0FDBXH84DVvxXpEVC45nfZW7RE5b4cT+s2JTCz893w+J65yZGKPYhKhbfVjLu1uzs423rZHF
	 YhpWLoHB7Z5iyFTSqhVekL+bsNuil22wBS381bllGmpRd0Z5eGD8IpYIPKcsKtvIw3suSvGWztqCp
	 ZGnIzV/u3oZCv65hNU2vXGJYFoE1CwNhDvwyxZLhcqUptZfdM3alzxLkTi4sZcGcAkl0YQLxv0wcs
	 xDYdGeTy4dt8w7sun/yBo2hbrgzaosoCMO9RohKNuUElD6qUPsPbWHI0n7ImrN45HY2QPGs1bCvVk
	 MWSRQYnB5gBQQseXW+2S7fzKMYfLxHzAz/06wSHooNP221o35sl8hHLxnG+gxrgIhpp8SEAZcRLdv
	 wttYLqc66aRhuxibq6faN+1fdUvvf0l4cS04L724Xdz7CC95Ngz5WGvieS2ipVQY1PH3RPEC0SCQc
	 LLZDi4lUTEtGHPpV3lXVwSsXOJZKBClnzlse4Bo/O+ZEZSX8poOOa0aS22M1U1Gi0XNUU8VxABkh2
	 bEmFwFeuf6x8bwc+bj+CMBVRMOBbJozHjSlFbbqRMjHcly44ucpG1KRKT5UmvuIARe2VdvezT5O6l
	 4AjpimmT+Wwm48X5K++Szf3pWy8brWR888+n7HrXrJNl+S1bpTLclyQC60yZO5MIsRD1+1zgcsxEy
	 Y16MLptC3/0G6NBTSzeoOt/17k+XaE4mdHZh69reiQfF1CWqaBhKA87ASDRQ945nLDYWOlNQ6C5AI
	 wOHX74OkmtP7bfnjvPr48Afne4f9RYdonvRTS0CxUYkICRgEbasogiv1kyvxnWGZzdyciyj+lRx9T
	 ZTKQ1aSJt3odwsS1uNe1fIHMqU8WkURomskKvfn9JQJrjd4w=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?U2hhd24gTGlu?=" <shawn.lin@rock-chips.com>
Cc: "=?utf-8?B?c2hhd24ubGlu?=" <shawn.lin@rock-chips.com>, "=?utf-8?B?bGludXgtY2xr?=" <linux-clk@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bWZk?=" <mfd@lists.linux.dev>, "=?utf-8?B?bGludXgtZ3Bpbw==?=" <linux-gpio@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgtcG0=?=" <linux-pm@vger.kernel.org>, "=?utf-8?B?bGludXgtaTJj?=" <linux-i2c@vger.kernel.org>, "=?utf-8?B?bGludXgtc2VyaWFs?=" <linux-serial@vger.kernel.org>, "=?utf-8?B?bGludXgtbW1j?=" <linux-mmc@vger.kernel.org>, 
	"=?utf-8?B?bGludXgtc3RtMzI=?=" <linux-stm32@st-md-mailman.stormreply.com>, "=?utf-8?B?bGludXgtcGh5?=" <linux-phy@lists.infradead.org>, "=?utf-8?B?bGludXgtdXNi?=" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 00/27] rockchip: Add RK3572 and Forlinx OK3572-C support
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 22 Oct 2026 14:37:30 +0800
X-Priority: 3
Message-ID: <tencent_1468586598128C460803261171FD769AA209@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
	<7fa26028-5c7c-4c5d-8cc5-3116b2e51cc0@rock-chips.com>
In-Reply-To: <7fa26028-5c7c-4c5d-8cc5-3116b2e51cc0@rock-chips.com>
X-QQ-mid: xmsezb41-0t1792651050t9mjujcfl

SGksCgo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaGVzLiBUeXBpY2FsbHksIGEgc2VyaWVzIG9m
IHRoaXMgc2l6ZSBjb3ZlcmluZyBTb0MKPiBzdXBwb3J0IHNob3VsZCBiZSBzcGxpdCBieSBz
dWJzeXN0ZW3vvIxmb3IgaW5zdGFuY2UsIHNlcGFyYXRlIERUIGJpbmRpbmcKPiBhbmQgZHJp
dmVyIHBhdGNoZXMgZm9yIGVhY2ggc3Vic3lzdGVt77yMYW5kIG9ubHkgQ0MgdGhlIHJlbGV2
YW50Cj4gbWFpbnRhaW5lcnMgYW5kIG1haWxpbmcgbGlzdHMuIFRoZSBEVFMgcGF0Y2ggY2Fu
IGZvbGxvdyBhZnRlcndhcmRzLgoKVGhhbmsgeW91IGZvciB0aGUgZ3VpZGFuY2UuIEkgYXBv
bG9naXplIGZvciB0aGUgaW5jb252ZW5pZW5jZS4gSSdsbCBzcGxpdAp2MiBieSBzdWJzeXN0
ZW0uCgpCZXN0IHJlZ2FyZHMsCkN1bmhhbw==

