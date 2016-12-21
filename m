From: Matthew Wilcox <mawilcox@microsoft.com>
Subject: RE: [PATCH 2/5] thermal: share get_ida()/release_ida() for other
 thermal ida users
Date: Wed, 21 Dec 2016 15:54:05 +0000
Message-ID: <BY2PR21MB0036286C1DBA879B9FC1B919CB930@BY2PR21MB0036.namprd21.prod.outlook.com>
References: <1482285855-2974-1-git-send-email-rui.zhang@intel.com>
 <1482285855-2974-3-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:44433
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757050AbcLUWZV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Dec 2016 17:25:21 -0500
In-Reply-To: <1482285855-2974-3-git-send-email-rui.zhang@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

RnJvbTogWmhhbmcgUnVpIFttYWlsdG86cnVpLnpoYW5nQGludGVsLmNvbV0NCj4gICAqIC0gdGhl
cm1hbCB6b25lIGRldmljZXMgbGlmZWN5Y2xlOiByZWdpc3RyYXRpb24sIHVucmVnaXN0cmF0aW9u
LA0KPiAgICoJCQkJICAgICBiaW5kaW5nLCBhbmQgdW5iaW5kaW5nLg0KPiAgICovDQo+IC1zdGF0
aWMgaW50IGdldF9pZGEoc3RydWN0IGlkYSAqaWRhLCBzdHJ1Y3QgbXV0ZXggKmxvY2ssIGludCAq
aWQpDQo+ICtpbnQgZ2V0X2lkYShzdHJ1Y3QgaWRhICppZGEsIHN0cnVjdCBtdXRleCAqbG9jaywg
aW50ICppZCkNCg0KSSBkb24ndCBsaWtlIG1ha2luZyBhIGZ1bmN0aW9uIGFzIGdlbmVyaWNhbGx5
IG5hbWVkIGFzICJnZXRfaWRhIiBub24tc3RhdGljLiAgVW5sZXNzIGl0J3MgcGFydCBvZiB0aGUg
SURBIGNvZGUgOi0pICBJbiBhbnkgY2FzZSwgSSBkb24ndCB0aGluayB0aGVzZSBkcml2ZXJzIG5l
ZWQgdGhlaXIgb3duIG11dGV4ZXMsIHNvIEkgc2VudCBhIHJlcGxhY2VtZW50IHNldCBvZiBwYXRj
aGVzLg0KDQo=
