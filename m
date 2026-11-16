Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822628;
	b=GlNQFOlE8kAglAEg63xxpEjZsJAgo8MG9+ODoKvllkrOHrlJ/wjMe+Ns+y74vOdUt2tY
	 LDknJnzNVZaIcCN2n2EeDRIA5AcQPafg3N7osy9GKkRqBpeAgXZpQJp8872iSq16+q9Z5
	 DjwB0pDQJC0WInuVts5szd5RPv4x/DdaUNAZKLiaxLHiAfhJgT0tQmpQQpX7ORDo8x53M
	 nm/wyhPmlxVOsfhUWE/jXIkHec6hhiKVzZyxvIUtm76jXyC1aCJTJT+zSBbmoD3ex+rP+
	 NtV2zxYmY1W3urcZ5Fbm5/hO6zf6/vVFshho65mYjpQHiJ53fj6YB9OaC0WCG6KbFlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822628;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=BG9vJP4tPF33GEesGxkQcQ8KBC+vLwkbRWXpiUkIsag=;
	b=B9RDKacwrkAXbtj+H1OkIPSPQ4IFQ+qBbYx/F/GQehN+RQUiP5/4PJnV/sMnhopQcc3C
	 FCqxaqr6VTDGH7OAyCG/Ic4iKbhfZPou7WcKGDE+3q/XUNZmugEoL01Mz3gvLInBITxDL
	 zlZJImWehE4h24JgTCH1j9rD0WTuuAoKfTF3C5KWQq2cSBp9eFWlSGr1s4sivQLhq3u0T
	 lJJTS/Oj12Y4wN2LRIDH0+CfQ/Na8F63aEA041GtlRZqp1l/76behtsxEdZf+NMHUPSrc
	 544dNMh/iVL7wpbpzs/dGYZLSS9PpiuQWWmFImbwWLlxgtSVE+NSO27b8LxE8/hMxXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=uU1F9f6f;
	arc=none smtp.remote-ip=203.205.221.192
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088A606A331;
	Mon, 16 Nov 2026 09:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B088A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=uU1F9f6f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794822617; bh=BG9vJP4tPF33GEesGxkQcQ8KBC+vLwkbRWXpiUkIsag=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=uU1F9f6fgn50NRe1QH6NcXZLTLRzjM3FhCPH0gq0PUfijZzImgudFgQb0K1OKxp9/
	 oGSlBG5Lf4aSN32U3Bl0dGHjQTbFMel5i+QWBzbtiCX/Ep87yBw/EaCU205K0wBkIW
	 xqrg7OCfoEfJtCkN/XjA+lmv8T0HxYYfZwE0CQdo=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: ObW7A5NPm3QRMO90WM0usk29kMol3NnPdW4jMcsZIk9TY6yhskAj4Fwsllv7h5
	 FdEyXo/oLqUejn5vFTMNz5ipMZNTjnWEth3088lDHKRJX9R6fPQiUhILx1bbGbL8xI+Cus45XAEuW
	 4kskzm3c/uMykjHGhIqo/BYXwP1N731DD5ICqZQSbwXleVQIn+uUEDk+mw5oW6Ww7qHf6zDwUGAbx
	 3s1Hh5fCw6nYA32qdJXy+lbuX6L716oLK+L6r/scInFG8XuqjcSDwzssEC8RWezZuOQROwTgcPdrz
	 LboUNIh2RmS0z6J3E+59bDsBWckP6sCrCTxXO/bUAiXET+shI9CetLJ/+6VXglGPfMMdxgiwmhaNB
	 EZzmTLw9GfmXb2x0du7oidjju4H9IyO9jnTeNsJd9orm94+xoNdprXvRU8lU9aY+X+AGPtLadzVtx
	 LdvA94+EWbzcWK9vxh5HqjBCzJ1EUUl4VeXt2lRARSKQROrYFy3uk1aOhi9wDAfa5YNgxzgTY8O4Q
	 eTSjPa5/pZ5ebyLRf6KkFzNF1vQnAQRchPLvn1zdAnbVqdrl6EAdeI1CZeOkjKwFS4ce8R0ou25tZ
	 gvVT5OfTUQhqPfG6O7QoShgQK+++n/YFyqvfjge6tnuLH9f0ffOOYDNiV1IKcBjWS8L3hivAM372F
	 mlPuUZzOh98nTRPErE/2siIPaR/Y6d/Ye2nzrw4HG+r/quZZO43qWS9yQwb42BcP/bu35Dwqy+s4+
	 4GOlqlbE67pmr09g7BHt2gF5Aa8dqNKf8OOYqzkksiPI+sXuvo+Qk9wFxTY1wgnDDxdhrYdzoYmz+
	 gyKbJa7CpB4THFTAONun+R/c9E/FlhkB7/FNguxVbPI0RrLUlThpABTGeh6Ogm888DxlqDBap5aps
	 y5N/AN7q2oBYUQ1RL2AuGV6xCg561ddt8iSWR3qb4w6u1TPrRFHd3n4WyrwKhiG+2KYd+PmOF/shU
	 tADDln39WtQn6NMCTnhYPMu59iJutv2Fqcp2TaC76byd5ek1vgGXLOPLVQOEQgD0Z0vLnuFI9ZxgU
	 uaWB2CDaR2MeljI//A1gbU+0CJEHFFD5qKFXzffGPLQM8nNvE6VFQ5IytkIq2p0+Kb4GZWrc9SymJ
	 0NjzUuF7j6lhTA==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?VWxmIEhhbnNzb24=?=" <ulf.hansson@oss.qualcomm.com>
Cc: "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?RWxhaW5lIFpoYW5n?=" <zhangqing@rock-chips.com>, "=?utf-8?B?VWxmIEhhbnNzb24=?=" <ulfh@kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtcG0=?=" <linux-pm@vger.kernel.org>, "=?utf-8?B?RmlubGV5IFhpYW8=?=" <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v4 0/2] pmdomain: rockchip: Add RK3572 power domains
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
Date: Mon, 16 Nov 2026 17:50:15 +0800
X-Priority: 3
Message-ID: <tencent_E7CC6902FE0862400DA2B35F4B93210D9606@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261104-add-board-ok3572-c-pmdomain-v4-0-15cf8b5a6e59@qq.com>
	<CAPx+jO_88-xLLiPeE1QPjceCBpBuX0ZXsB=-vVVcGmx_6vnWCA@mail.gmail.com>
In-Reply-To: <CAPx+jO_88-xLLiPeE1QPjceCBpBuX0ZXsB=-vVVcGmx_6vnWCA@mail.gmail.com>
X-QQ-mid: xmsezb41-0t1794822615t6y0ziur8

SGksCgo+IFRoZXJlwqBhcmXCoHF1aXRlwqBhwqBsb3TCoG9mwqBwYXRjaGVzwqBvbsKgdGhl
wqByb2NrY2hpcMKgcG93ZXLCoGRvbWFpbsKgZHJpdmVyCj4gaW7CoHRoZcKgcGlwZS7CoE9u
wqBtecKgZW5kLMKgScKgY2FuwqBvbmx5wqB0cnnCoHRvwqBhcHBsecKgcGllY2VzwqBiecKg
cGllY2UswqBidXQKPiBpdMKgd291bGTCoGJlwqBuaWNlwqBpZsKgeW91wqBjb3VsZMKgc3Rh
cnTCoHJldmlld2luZ8KgZWFjaMKgb3RoZXInc8KgcGF0Y2hlc8KgdG8KPiBoZWxwwqBjb29y
ZGluYXRlwqB0aGlzwqBiaXQuCj4gCj4gQW55d2F5LMKgdGhpc8Kgc2VyaWVzwqBuZWVkc8Kg
dG/CoGJlwqByZWJhc2VkwqBvbsKgdG9wwqBvZsKgdGhlwqBsYXRlc3TCoGNoYW5nZXMKPiB0
aGF0wqBJwqBoYXZlwqBxdWV1ZWTCoGZvcsKgbmV4dC7CoEnCoHdpbGzCoGhhdmXCoGHCoGxv
b2vCoHdoZW7CoHRoYXQnc8KgZG9uZS4KCkkgaGF2ZSByZWJhc2VkIHRoaXMgc2VyaWVzIGFu
ZCBpdHMgcHJlcmVxdWlzaXRlIHBvd2VyLW9uIHJvbGxiYWNrCmZpeCBbMV0gb250byB5b3Vy
IGxhdGVzdCBuZXh0IGJyYW5jaCAoNmY1YzhlYzkzMDJjKS4gQm90aCByZWJhc2VkCmNsZWFu
bHksIHdpdGggbm8gY29uZmxpY3RzIG9yIGZ1bmN0aW9uYWwgY2hhbmdlcy4KClNob3VsZCBJ
IHNlbmQgbmV3IHJldmlzaW9ucyBvZiBib3RoICh2NSBmb3IgdGhpcyBzZXJpZXMgYW5kIHYy
IGZvcgp0aGUgcm9sbGJhY2sgZml4KT8KClsxXSBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsv
MjAyNjExMDEtZml4LXJvY2tjaGlwLXBtZG9tYWluLXBvd2VyLW9uLXJvbGxiYWNrLXYxLTEt
NTlhNDU3ODNlMzNlQHFxLmNvbQoKQmVzdCByZWdhcmRzLApDdW5oYW8gTHU=

