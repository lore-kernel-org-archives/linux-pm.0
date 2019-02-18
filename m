From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
Date: Mon, 18 Feb 2019 09:38:03 +0900
Message-ID: <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
 <CGME20190216151918epcas1p25c2971b063cc66981fda6a67a8276585@epcas1p2.samsung.com>
 <20190216151826.11584-4-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190216151826.11584-4-tiny.windzz@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

T24gMTkuIDIuIDE3LiDsmKTsoIQgMTI6MTgsIFlhbmd0YW8gTGkgd3JvdGU6Cj4gVGhpcyB2YXJp
YWJsZSBpcyBub3QgdXNlZCBhZnRlciBpbml0aWFsaXphdGlvbiwgc28KPiByZW1vdmUgaXQuIEFu
ZCBpbiBvcmRlciB0byB1bmlmeSB0aGUgY29kZSBzdHlsZSwKPiBtb3ZlIHRoZSBsb2NhdGlvbiB3
aGVyZSB0aGUgZGV2X2dldF9kcnZkYXRhIGlzIGNhbGxlZAo+IGJ5IHRoZSB3YXkuCj4gCj4gU2ln
bmVkLW9mZi1ieTogWWFuZ3RhbyBMaSA8dGlueS53aW5kenpAZ21haWwuY29tPgo+IC0tLQo+ICBk
cml2ZXJzL2RldmZyZXEvdGVncmEtZGV2ZnJlcS5jIHwgNyArKy0tLS0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZGV2ZnJlcS90ZWdyYS1kZXZmcmVxLmMgYi9kcml2ZXJzL2RldmZyZXEvdGVncmEtZGV2
ZnJlcS5jCj4gaW5kZXggYzU5ZDJlZWU1ZDMwLi5jODliYTdiODM0ZmYgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9kZXZmcmVxL3RlZ3JhLWRldmZyZXEuYwo+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS90
ZWdyYS1kZXZmcmVxLmMKPiBAQCAtNTczLDEwICs1NzMsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX2dv
dmVybm9yX2dldF90YXJnZXQoc3RydWN0IGRldmZyZXEgKmRldmZyZXEsCj4gIHN0YXRpYyBpbnQg
dGVncmFfZ292ZXJub3JfZXZlbnRfaGFuZGxlcihzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSwKPiAg
CQkJCQl1bnNpZ25lZCBpbnQgZXZlbnQsIHZvaWQgKmRhdGEpCj4gIHsKPiAtCXN0cnVjdCB0ZWdy
YV9kZXZmcmVxICp0ZWdyYTsKPiAtCWludCByZXQgPSAwOwo+IC0KPiAtCXRlZ3JhID0gZGV2X2dl
dF9kcnZkYXRhKGRldmZyZXEtPmRldi5wYXJlbnQpOwo+ICsJc3RydWN0IHRlZ3JhX2RldmZyZXEg
KnRlZ3JhID0gZGV2X2dldF9kcnZkYXRhKGRldmZyZXEtPmRldi5wYXJlbnQpOwo+ICAKPiAgCXN3
aXRjaCAoZXZlbnQpIHsKPiAgCWNhc2UgREVWRlJFUV9HT1ZfU1RBUlQ6Cj4gQEAgLTYwMCw3ICs1
OTcsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX2dvdmVybm9yX2V2ZW50X2hhbmRsZXIoc3RydWN0IGRl
dmZyZXEgKmRldmZyZXEsCj4gIAkJYnJlYWs7Cj4gIAl9Cj4gIAo+IC0JcmV0dXJuIHJldDsKPiAr
CXJldHVybiAwOwo+ICB9Cj4gIAo+ICBzdGF0aWMgc3RydWN0IGRldmZyZXFfZ292ZXJub3IgdGVn
cmFfZGV2ZnJlcV9nb3Zlcm5vciA9IHsKPiAKClJldmlld2VkLWJ5OiBDaGFud29vIENob2kgPGN3
MDAuY2hvaUBzYW1zdW5nLmNvbT4KCi0tIApCZXN0IFJlZ2FyZHMsCkNoYW53b28gQ2hvaQpTYW1z
dW5nIEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
