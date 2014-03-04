From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Rewrite devfreq_update_status() to fix
 multiple bugs
Date: Tue, 04 Mar 2014 10:06:17 +0000 (GMT)
Message-ID: <8984550.302431393927576253.JavaMail.weblogic@epv6ml05>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:63425 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452AbaCDKGS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Mar 2014 05:06:18 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1W00JCFPEHME20@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 04 Mar 2014 19:06:17 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>, =?euc-kr?Q?=B9=DA=B0=E6=B9=CE?= <kyungmin.park@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

PiBUaGUgY3VycmVudCBkZXZmcmVxX3VwZGF0ZV9zdGF0dXMoKSBoYXMgdGhlIGZvbGxvd2luZyBi
dWdzOg0KPiAtIElmIHByZXZpb3VzIGZyZXF1ZW5jeSBkb2Vzbid0IGhhdmUgYSB2YWxpZCBsZXZl
bCwgaXQgZG9lcyBhbiBvdXQgb2YgYm91bmRzDQo+ICAgYWNjZXNzIGludG8gdGhlIHRyYW5zX3Rh
YmxlIGFuZCBjYXVzZXMgbWVtb3J5IGNvcnJ1cHRpb24uDQo+IC0gV2hlbiB0aGUgbmV3IGZyZXF1
ZW5jeSBkb2Vzbid0IGhhdmUgYSB2YWxpZCBsZXZlbCwgdGhlIHRpbWUgc3BlbnQgaW4gdGhlDQo+
ICAgbmV3IGZyZXF1ZW5jeSBpcyBjb3VudGVkIHRvd2FyZHMgdGhlIG5leHQgdmFsaWQgZnJlcXVl
bmN5IHN3aXRjaCBpbnN0ZWFkIG9mDQo+ICAgYmVpbmcgaWdub3JlZC4NCj4gLSBUaGUgdGltZSBz
cGVudCBvbiB0aGUgcHJldmlvdXMgZnJlcXVlbmN5IGlzIGFkZGVkIHRvIHRoZSBuZXcgZnJlcXVl
bmN5J3MNCj4gICBzdGF0cyBpbnN0ZWFkIG9mIHRoZSBwcmV2aW91cyBmcmVxdWVuY3kncyBzdGF0
cy4NCj4gDQo+IFRoaXMgcGF0Y2ggZml4ZXMgYWxsIG9mIHRoaXMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBTYXJhdmFuYSBLYW5uYW4gPHNrYW5uYW5AY29kZWF1cm9yYS5vcmc+DQoNCk1lcmdlZC4N
Cg0KSXQgYXBwZWFycyB0byBiZSBHcmVnJ3MgTFRTIG1hdGVyaWFsIGFzIHdlbGwuDQoNCg0KQ2hl
ZXJzLA0KTXl1bmdKb28NCg0K


