Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182851;
	b=kcVSoiTN3i8TXbqWhWf3DPfLYMYlMzOEYRtQ3EHm4B0QVynwW4N3rYrRkg/dtrF8wkEA
	 kaVqUQJRVBq3Y6gYfaqfbav5I5qCr3cQ7ii2yyykUo9EqvYnnbzNrXd1HVNFDRwFCTBZg
	 Ha8/ivI1IrBIH1c+4+60Zj697XwkFWa0j2i9TOgD7GjIxl0CXy0lgJKyiTGnn9GGxTo9i
	 LJ8SZr/0WDZYxMHy2clceHHyENq27UyTTOtjU2BkC06W8h0G7zLGe0NsNNxrcqVPP0iPj
	 Nr28WcTtke4TRmK4S2aMICqkNt32NPwX3Tp5J3wxR5lT0taQGx66wzZsv4Fy0bI+kNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182851;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=JvKgGTjq2BPEe61GwX/IAd5voKriY1si3N+Q1SQuS+8=;
	b=RfU/YzHMsEyfsw7xiiLKqgk7YuXYsTKXTYEiPWA46laJusgqEG8regiyh9X4QdbR2xZH
	 BoQkUC7ktMaUG78+0Tw+9bxcYgYBlZg7rAt+6WL7pwy2EAPu63sRMmZ+ExWx8OmtfU0lO
	 xiGga3SV8I1rdH1AIaebdsWGOt1UR3YFezCA1l2d9YC0GlCgVb6aEnl0ggvSlhepD5Omo
	 jfbVu43gmP7cFlZpPYgfGg/3hNW060d0GAOn63cp8UeD/6ATje5D9xTgnlLHNvMahNTMs
	 CWaGjfIxfp1OKIo2EhsMNhRe6JhG+S7ejFoMV/5tPf20kkMU8jBtf8ODIvg6qbOz6cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=avxULmTp;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA8606A332
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 13:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ABA8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=avxULmTp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795182840; bh=JvKgGTjq2BPEe61GwX/IAd5voKriY1si3N+Q1SQuS+8=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=avxULmTpzYlINMYMerBM8KO0ptt/FuqSFGc8Nvesy/uIg+2oRARAUR8EfBYiazqx1
	 2BeuOfaIqGXlYGL05H++5xKwa2BFu+nPfyPYOAAPGxmNyLFedVjxjG2D9RROMbDXF1
	 4IUU8S2vwn88T4XCjw8TJ45yZu+FyvdkhaRWhqfU=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: OTkXlZHit/HDYSOMMYUSEEaFDIssz1W9vtk4QajQI2ZSIDw6z3e3/fziSn1gxD
	 NRzOwWA0EKV5Xs+u57yAudQ/ZR+h/8ZQ2O1AUpRdZGuBGoLSIniCUhxiNX60gGQBeU/s7BVNMeoDK
	 6sQTLDQAQvtnsKWBuEa8O2bR9X6uLK3NdiBgHKpcgVyp/dqCOE9FZsnvH+Nh7TABBd4s+RjqnLpzo
	 kX0WwTvW0pry+FPxjPfTFI5bDKsWLCNfU9b7rQs0QEMCX+yjXJF3pXLY5INZt1PRaeiYIm980EC+i
	 ksbMOELwGQyLAsjY1g5aniNmIS+geQlR2jwJniCicFcpInkrFLuerPKM/r7Uc98T/fvCoTUrxSbHe
	 8W67anNj909GuWCLJnvyzj9VKlcT/fMW4SgyQ8g1AjRjVve1raT93B6AoJRaskEg6NfIYLFNflEcT
	 iZrnjeqQKB4VWhI+jVbUjca1TGGFOod6sMcR5YNTJTH9u693e5BXglWXTSkr+MsYa8zB+pv9V1jpD
	 MjDcJhgl5yVjqOWyWxYtDdh7WHUJkVdiIlAgw0ZQtr+Cj8u/CiW1d16CsnX2zzj5GLAaduahoxfyM
	 TCEkmm432ee+WSri6RKBSVM/ktHFXJCli1M/Hk4E6cqeWfk0BqBsxH8VRQ/ihT1ahdqfyvzYLJZEp
	 t4q4/A6Tj8UGgn909/LVRfKN2IikVmwqK8AJfyFcBMoHvxT3TM/Z4dcuj/AaFZHSDd6L9BRYNMB5m
	 F6HKoDrSPC+sX/x48Nu3RsE5fI/fZN/QHNO9LSEB4uLbomRE99gOdW/9ewDWlEPYEb5r16UQ2oOuM
	 +FJvdsW+5wvlJ9rFoEhFMIQ8PjOK2p6G2Lf1G2jsd8EnrSlYbnzyTKkfkiU0QIzVZAblvQQLUGwoJ
	 rfycw2PefoJtR3rtCuqN7jF7II9g0Xb5Xbp9LjMhSY7FY2cbWxZJzTqoD5p6QGQ2lrXTRIy433COB
	 HF0W0RuPpgEDtZXbMBRLnVBbS/AMYrm0k5Gz4MUiuX19nwNerN+cqUrNj/gU4WqwYcbNpRx7XBtiQ
	 9obkPQmlblrCQuSR8D8yRDCao9KM8Hq4xYqZQFtwvq3/NJG9iEXLhe13raQMjUOpe5jpnPM45cZ1A
	 8alZDdwOwNZLX9K2Udy1Vu9Vfn88od9O75+eVdokKCqFJTvDITj3pAe+
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?SGVpa28gU3TDvGJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?RWxhaW5lIFpoYW5n?=" <zhangqing@rock-chips.com>, "=?utf-8?B?VWxmIEhhbnNzb24=?=" <ulfh@kernel.org>
Cc: "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtcG0=?=" <linux-pm@vger.kernel.org>, "=?utf-8?B?U2ViYXN0aWFuIFJlaWNoZWw=?=" <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v5 2/2] pmdomain: rockchip: Add RK3572 power domains
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
Date: Fri, 20 Nov 2026 21:53:58 +0800
X-Priority: 3
Message-ID: <tencent_DFB6F95537CDD14CC97C26B08CE407F4210A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261118-add-board-ok3572-c-pmdomain-v5-0-f1af919dd434@qq.com>
 <20261118-add-board-ok3572-c-pmdomain-v5-2-f1af919dd434@qq.com>
	<z4ZFdDPMSaWK2zh19ZM7pA@sntech.de>
In-Reply-To: <z4ZFdDPMSaWK2zh19ZM7pA@sntech.de>
X-QQ-mid: xmsezb41-0t1795182838tuf7c54wx

SGkgSGVpa28sCgo+IEkgZ3Vlc3MgdGhlIGZpcnN0IHF1ZXN0aW9uIGlzLCB3aHkgZG8geW91
IG5lZWQgdGhhdD8KPiBUaGUgVFJNcyBvZiBib3RoIFJLMzU3MiBhbmQgUkszNTg4IGhhdmUg
dGhlIHZvbHRhZ2UtZG9tYWluIHBvd2VyLWNvbnRyb2wKPiByZWdpc3RlcnMsIGJ1dCB3aHkg
ZG8geW91IG5lZWQgdG8gY29udHJvbCB0aGVtIG5vdz8KPgo+IFNpZGUtcXVlc3Rpb24sIGhv
dyBhcmUgdm9sdGFnZS1kb21haW5zIGhhbmRsZWQgb24gdGhlIG90aGVyIFNvQ3MuCj4gVGhl
IFJLMzU4OCBhbHNvIGhhcyB0aGUgUE1VX1ZPTF9HQVRFX0NPTnggcmVnaXN0ZXJzLCBzbyBJ
IGd1ZXNzCj4gdGhleSBjb3VsZCBhbHNvIGJlIHR1cm5lZCBvZmY/CgpJbiBoaXMgdjMgcmV2
aWV3IFsxXSwgRmlubGV5IFhpYW8sIGFuIGVuZ2luZWVyIGF0IFJvY2tjaGlwLCBhc2tlZCBt
ZQp0byBpbmNsdWRlIFJvY2tjaGlwJ3Mgdm9sdGFnZS1kb21haW4gaGFuZHNoYWtlIHdoZW4g
YWRkaW5nIFJLMzU3MiBOUFUKc3VwcG9ydC4gU3BlY2lmaWNhbGx5LCBoZSBhc2tlZCBtZSB0
byBjYWxsIHJvY2tjaGlwX3BtdV92ZF9vbigpIHRvCnJlcXVlc3QgVkRfTlBVIGJlZm9yZSBh
c2tpbmcgdGhlIFBNVSB0byBwb3dlciB1cCBQRF9OUFUuCgpTbyBmYXIgSSd2ZSBvbmx5IHRl
c3RlZCBiYXNpYyBOUFUgcG93ZXIgbWFuYWdlbWVudCBvbiBSSzM1NzIuIEkgaGF2ZW4ndApy
dW4gYSBjb21wdXRlIHdvcmtsb2FkLCBzbyBJIGNhbid0IHNheSB3aGljaCBOUFUgZnVuY3Rp
b25zLCBpZiBhbnksCndvdWxkIGJlIGFmZmVjdGVkIGJ5IG9taXR0aW5nIHRoZSBWRCByZXF1
ZXN0LgoKSSBjb21wYXJlZCB0aGUgdXBzdHJlYW0gYW5kIFJvY2tjaGlwIGRyaXZlcnMgZm9y
IFJLMzU4OC4gQm90aCBzd2l0Y2gKdGhlIHRvcC1sZXZlbCBOUFUgZG9tYWluIHVzaW5nIGJp
dCAxIG9mIFBNVV9QV1JfR0FURV9TRlRDT04wIFsyXS4KTmVpdGhlciB3cml0ZXMgUE1VX1ZP
TF9HQVRFX0NPTjAgZHVyaW5nIG5vcm1hbCBOUFUgZG9tYWluIHRyYW5zaXRpb25zLgoKU2hv
dWxkIEkga2VlcCB0aGUgVkRfTlBVIHJlcXVlc3QgYmVmb3JlIHBvd2VyaW5nIHVwIFBEX05Q
VSBvbiBSSzM1NzIKaW4gdjY/Cgo+IEJ1dCBpbiBnZW5lcmFsLCBpZiB5b3UgbmVlZCB0byBl
bmFibGUgdGhlIHZvbHRhZ2UtZG9tYWluIHRvIGVuYWJsZSB0aGUKPiBwb3dlci1kb21haW4g
aW5zaWRlIGl0LCB0aGlzIHJlYWxseSBzb3VuZHMgbW9yZSBsaWtlIGEgcG93ZXItZG9tYWlu
IG9mCj4gYSBkaWZmZXJlbnQgdHlwZSAtIGJlY2F1c2UgdGhlIHdpZ2dsaW5nIGluc2lkZSB0
aGUgcG93ZXItZG9tYWluCj4gaGFuZGxpbmcgYmVsb3cgbG9va3Mgc3RyYW5nZSwgYW5kIHdl
IGFscmVhZHkgYXJlIGhhbmRsaW5nIGRvbWFpbgo+IHRyZWVzLgoKSSBjaGVja2VkIFJvY2tj
aGlwJ3Mga2VybmVsIGFuZCB0aGUgUkszNTcyIGRvY3VtZW50YXRpb24sIGJ1dCBJIGNvdWxk
bid0CmZpbmQgYSBzZXBhcmF0ZSBzdGF0dXMgYml0IGZvciBWRF9OUFUuIElmIEkgbW9kZWwg
aXQgYXMgYSBwYXJlbnQKZG9tYWluLCB3b3VsZCBpdCBtYWtlIHNlbnNlIHRvIHRyYWNrIGl0
cyBzdGF0ZSBpbiBzb2Z0d2FyZT8KCj4+IC0JaW50IGNsa191bmdhdGVfd19tYXNrID0gcGRf
aW5mby0+Y2xrX3VuZ2F0ZV9tYXNrIDw8IDE2Owo+PiArCXUzMiBjbGtfdW5nYXRlX3dfbWFz
ayA9ICh1MzIpcGRfaW5mby0+Y2xrX3VuZ2F0ZV9tYXNrIDw8IDE2Owo+Cj4gd2h5IGRvZXMg
aXQgbmVlZCB0byBiZSB1MzIgbm93Pwo+IFllcywgdGhlIG1hc2sgc2hvdWxkIHByb2JhYmx5
IGJlIHUzMiwgYnV0IHdoeSBub3QgY2hhbmdlIHNpbXBseSBjaGFuZ2UKPiB0aGUgZ2xvYmFs
IHR5cGUgdGhlbj8KCkknbGwgbWFrZSBjbGtfdW5nYXRlX21hc2sgaXRzZWxmIHUzMiBpbiB2
NiBhbmQgZHJvcCB0aGUgY2FzdC4KCj4gYm90aCB0aGUgY2xrX3VuZ2F0ZV9vZmZzZXQgKyBz
dGF0dXNfb2Zmc2V0IGFkZGl0aW9uIHNob3VsZCBwcm9iYWJseSBiZQo+IHNlcGFyYXRlIHBh
dGNoZXMsIGFzIHRoZXkgc2hvdWxkIGdldCBhIGRlc2NyaXB0aXZlIGNvbW1pdCBtZXNzYWdl
IG9uCj4gd2h5IHRoZXkgYXJlIG5lZWRlZC4KPgo+PiArCWlmIChwbXUtPmluZm8tPmNoYWlu
X3N0YXR1c19pbnZlcnRlZCkKPj4gKwkJcmV0dXJuICEodmFsICYgcGQtPmluZm8tPm1lbV9z
dGF0dXNfbWFzayk7Cj4KPiBhZ2FpbiwgaW50cm9kdWNpbmcgdGhpcyBuZXcgcGFyYW1ldGVy
IHNob3VsZCBnZXQgaXRzIG93biBjb21taXQgYW5kCj4gZGVzY3JpcHRpdmUgbWVzc2FnZSBv
biB3aGF0IHRoaXMgZG9lcy4KCkknbGwgc3BsaXQgdGhlc2UuCgo+PiArCXJldHVybiByZWdt
YXBfcmVhZF9wb2xsX3RpbWVvdXQocG11LT5ncmYsIHBtdS0+aW5mby0+Zndfc3RhdHVzX29m
ZnNldCwKPj4gKwkJCQkgICAgICAgdmFsLCAodmFsICYgbWFzaykgPT0gbWFzaywgMCwgMTAw
MDApOwo+PiArfQo+Cj4gdGhpcyBkZWZpbml0bHkgYWxzbyBuZWVkcyB3YXkgbW9yZSBleHBs
YW5hdGlvbgoKVW5kZXJzdG9vZC4KClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MThmY2ZlN2EtZTI1YS00NTE2LTgxMGYtZDc4N2I3Nzk5MTRkQHJvY2stY2hpcHMuY29tLwpb
Ml0gUkszNTg4IFRSTSwgUGFydCAxLCB2MS4xLCBjaGFwdGVyIDcsIGVzcGVjaWFsbHkgc2Vj
dGlvbiA3LjUuNToKICAgIGh0dHBzOi8vZGwubmFtdHNvLmNvbS9wcm9kdWN0cy9hMTAvYTEw
LTM1ODgvZGF0YXNoZWV0cy9yb2NrY2hpcC1yazM1ODgtdHJtLXYxLjEtcGFydDEucGRmCgpC
ZXN0IHJlZ2FyZHMsCkN1bmhhbyBMdQoKcHctYm90OiBjcgo=

