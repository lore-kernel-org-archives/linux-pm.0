Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098269;
	b=aCuto1tfD/nvcofx4pSq5r7waJmwEhNS8l6mKzx9XtGsgNDP/m0epnd54/Stid6beRxP
	 4Le9J6iFNiNGW0qHYGe43U50pZN36qebTT97Jo7Lw4ToK8uD1JuyTXZzQuwYCQ86g8I2p
	 wIjrC6y1N8cMW1dx26dKxLNVkryLwAMWLX+2Sigvd2IgSq+jkCS4vEjyxLFWz9cMDbAH2
	 +LThfs3FwGc5BnI8iDPDLGdsncyFXtYB6Bh/teMVgJdxYv73PaNxtVQKSroUfG/ijxePc
	 2rYpiYYoMBdGuEZI1hOqLBB+SckY6AzMNVMvIWW1jAhpl+GgxXCB/C6DuJr+BMzqtzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098269;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=Vli6xhlC+1tOZxNe6ZiuhYi3OuRNx6a1ew5ibReVdb0=;
	b=lSov+rVLzIETc0G34pSTSRzcHziDyBauwwmBrOQllCFxYYbS+RA1FiBryhjXI2u4zmjL
	 wX7Xp+P68qoEefFyoXT0f1qISoN7wcwZYHWplVy5YsMML103IIBnl6qGdscpHdOOUFm/x
	 I0zMdcTeRtpyrIOCCowHq4o+fAQwPmLIX2uEcGZymTsAeuw7V4OoAzatZaZ0uTXeUYtUd
	 lUScrSJV6Z3dRfVt0Wct5aSrBCWCY7VesdRARzLBfc34/lxqlX7n3hSAqQbPlZWBeydvu
	 hPt5p6NUaUJCG2htkv0Mh9EDq3+Knetb8lbluRgLrXszKhq2wLltU18D6OMWGw0EMvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=S4AnkzfZ;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9B606E79C;
	Tue, 27 Oct 2026 10:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74A9B606E79C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=S4AnkzfZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793098263; bh=Vli6xhlC+1tOZxNe6ZiuhYi3OuRNx6a1ew5ibReVdb0=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=S4AnkzfZku23PdSmTG9Izg/xiFNGHIQMr0PN+fpullXpH2RZpxBrz4lSsPi2euNsJ
	 dboYPfMCHbYuckAzsUsgIitUQVtAZ7rA7RKmWY5+6esOpxzV1bO55/CO89/Lj+NLtY
	 YsHGDhQtael+DsgR8jg0FWC5dQiok9lC3ttDyzqA=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-XMAILINFO: OeJOoYd4plGbllljkz+rlLNlYfGojr+DRpXa6DK1UZUUeq0G1YqjFr1mfYZ6tA
	 noFoR74yrCt9wMum5OZv3pqTnamcaj61G0mws81BlcNgHwy5gAjmA10sh12h8oGwEPHFYCaw6/NoB
	 ScAjs94IUOYQmEDQkVlQgpNFcPPLKGxhHJSIujBa48NLo5FBhZM5w2Loq6/ViubVkQZ9mSn1EjvdN
	 EDco+I2rB/MFfOQWAJSZM8N7zeXBenXSR74eskCcq6fhJ+HNWkvct0Qfq3lQy15FRYhRFdQFLZ77s
	 KSFXfi9dTSoWcXpk+GPUZShWPEaJ+9Wg+Ym1PR1D+//x0lue0DGdhlguqkXC5NDYqoGN9oJCd/kq9
	 wd1H4GZLI9mMwIfPZN/0oTdB1H3L9jxnHUGrzMUQuoRYM8HPzO8d4rcp+O9KFILn0ZuyYAkiVovFp
	 81VnbQXu8J7qZj0c13Fw+UnkMdjYZfajU4iljjeY+PlCGGamWqOf6sPVqpX8HFwmefud3DRjrwYmC
	 FdWfO7uw1XFGzW4t6mT4pCHR3nEkjkyq6MmPiaKKf+A0Zoi+X6ucWoQT5PpSkd4rbenb+a7CbCAhu
	 NN/hhOgSazCSAhFaWMmn0iyU++kbe4ua7YhUhwpmnn2GRtN8i3MbkoH0Enaos+J7G4U/l6J5VWzpM
	 c56cl42aRQIhbOz7EcQEeQkqbLlx6o7SVDC5tgox9+GEHup55Ntv/7mJ3aQhPi1p61pmR7EM/Lidi
	 sjAjAcmm36RbC6nWBfe56gqF++IOcFwC+PNcngzGRiwgCsufUarVfd3JcpEiPoE4dHUMS+ZIoarCh
	 2r4PRZk9vqng30BHvZ5no+fvzDw53GQdEWbAJ6KCu00JbR8N3WJ/Gd652wHsJQlCZDKyJ7Z8ux67M
	 TlKHdHoFNWshL50mirk1dBJPKzTsgvJLx9jSGc8GRxwuFsQoM5p/JM8ZS/D+sYvN+YhcMcO3kGCir
	 2l37IOxLr8pg7EzA90qIVTpImO6SXul3RZAucSXHdUTuvoVyDVYssGGV4RbqxKqiRmjRSmMAZyO97
	 txGXWIuLUPWDddHYuKZo0M5d0tUWvXJOGjGMQmV0UPqZOfbXlUWOR7uXIlw==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk@kernel.org>
Cc: "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?RWxhaW5lIFpoYW5n?=" <zhangqing@rock-chips.com>, "=?utf-8?B?VWxmIEhhbnNzb24=?=" <ulfh@kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtcG0=?=" <linux-pm@vger.kernel.org>, "=?utf-8?B?RmlubGV5IFhpYW8=?=" <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: rockchip: Add RK3572 power domains
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
Date: Tue, 27 Oct 2026 18:51:01 +0800
X-Priority: 3
Message-ID: <tencent_0F101DFCE09BB069F66456125E460602F809@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261026-add-board-ok3572-c-pmdomain-v3-0-70d614d3d921@qq.com>
 <20261026-add-board-ok3572-c-pmdomain-v3-1-70d614d3d921@qq.com>
	<20261027-uptight-stalwart-roadrunner-339a8f@quoll>
In-Reply-To: <20261027-uptight-stalwart-roadrunner-339a8f@quoll>
X-QQ-mid: xmsezb41-0t1793098261tcq9nsxxk

SGkgS3J6eXN6dG9mLAoKPiBTb21lIG1lc3MgaGVyZS4gSSBkb24ndCBnZXQgd2hhdCdzIGFi
b3ZlLCBidXQgZG9lcyBub3QgZml0IGNvbW1pdCBtc2cuCj4gQWxzbyB0aGVyZSBhcmUgbm8g
Y29tbWl0IG1zZyBiZXR3ZWVuIHRoZSB0YWdzLgoKSSdtIHZlcnkgc29ycnkgZm9yIHRoZSBt
aXN0YWtlLiBJIHNob3VsZCBoYXZlIGtlcHQgb25seSB0aGUgc2lnbmlmaWNhbnQKY2hhbmdl
cyBpbiB0aG9zZSBub3RlcyBhbmQgZW5jbG9zZWQgdGhlbSBpbiBzcXVhcmUgYnJhY2tldHMg
W10uCgo+IFdoYXQgaXMgZmlyZXdhbGw/IElzIGl0IGZvciBhY2Nlc3MgY29udHJvbD8gSWYg
c28sIHdlIGhhdmUKPiBhY2Nlc3MtY29udHJvbGxlcnMgcHJvcGVydGllcy4KClNvcnJ5IGFi
b3V0IHRoaXMsIHRob3VnaCBJIGNvdWxkbid0IGhlbHAgbGF1Z2hpbmcgYXQgdGhlIG1pc3Rh
a2UgOkQKV2hpbGUgZm9sbG93aW5nIG15IGluc3RydWN0aW9ucyB0byBjbGVhbiB1cCBuYW1p
bmcgYW5kIGNvbW1lbnRzLCBteSBBSQphZ2VudCBpbmNvcnJlY3RseSBleHBhbmRlZCAiZnci
IHRvICJmaXJld2FsbCIuIEkgY2F1Z2h0IGFuZCBjb3JyZWN0ZWQgc29tZQpvZiB0aGVzZSBk
dXJpbmcgcmV2aWV3LCBidXQgYXBwYXJlbnRseSBtaXNzZWQgbWFueSBvdGhlcnMuCgpUaGF0
J3MgbXkgcmV2aWV3IG92ZXJzaWdodCwgYW5kIEknbGwgY2hlY2sgdGhlIHJlbWFpbmluZyBv
Y2N1cnJlbmNlcyBhbmQKZml4IHRoZSBkZXNjcmlwdGlvbi4KCkJlc3QgcmVnYXJkcywKQ3Vu
aGFvIEx1Cgpwdy1ib3Q6IGNy

