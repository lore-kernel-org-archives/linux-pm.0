From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: big.LITTLE: add Exynos5800 compatible string
Date: Thu, 21 Aug 2014 03:49:22 +0200
Message-ID: <53F55022.8020505@linaro.org>
References: <1407888665-24603-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1407888665-24603-1-git-send-email-khilman@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>
Cc: k.chander@samsung.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, CPUIDLE DRIVERS <linux-pm@vger.kernel.org>, t.figa@samsung.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, open list <linux-kernel@vger.kernel.org>, kgene.kim@samsung.com, "open list:CPUIDLE DRIVER -..." <linux-arm-kernel@lists.infradead.org>, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

T24gMDgvMTMvMjAxNCAwMjoxMSBBTSwgS2V2aW4gSGlsbWFuIHdyb3RlOgo+IEV4eW5vcyA1ODAw
IGlzIGJpZy5MSVRUTEUgU29DIGNvbXBhdGlibGUgd2l0aCB0aGUgNTQyMC4gIEFkZCB0aGUKPiBj
b21wYXRpYmxlIHN0cmluZyBzbyB0aGlzIGRyaXZlciB3b3JrcyBvbiB0aGUgNTgwMC4KPgo+IFRl
c3RlZCBvbiBleHlub3M1ODAwLXBlYWNoLXBpIChha2EgU2Ftc3VuZyBDaHJvbWVib29rMikKPgo+
IFNpZ25lZC1vZmYtYnk6IEtldmluIEhpbG1hbiA8a2hpbG1hbkBsaW5hcm8ub3JnPgo+IC0tLQoK
VGhhbmtzLgoKSSB3aWxsIGFwcGx5IGl0IHRvIG15IHRyZWUuCgo+ICAgZHJpdmVycy9jcHVpZGxl
L2NwdWlkbGUtYmlnX2xpdHRsZS5jIHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS1iaWdfbGl0dGxl
LmMgYi9kcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS1iaWdfbGl0dGxlLmMKPiBpbmRleCAwYTFmODI3
MzA4ZGIuLmJmM2FiNjZmZGFhZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2NwdWlkbGUvY3B1aWRs
ZS1iaWdfbGl0dGxlLmMKPiArKysgYi9kcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS1iaWdfbGl0dGxl
LmMKPiBAQCAtMTY2LDYgKzE2Niw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGJsX2lkbGVfZHJpdmVy
X2luaXQoc3RydWN0IGNwdWlkbGVfZHJpdmVyICpkcnYsIGludCBtYXRjaF9pZCkKPiAgIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGNvbXBhdGlibGVfbWFjaGluZV9tYXRjaFtdID0g
ewo+ICAgCXsgLmNvbXBhdGlibGUgPSAiYXJtLHZleHByZXNzLHYycC1jYTE1X2E3IiB9LAo+ICAg
CXsgLmNvbXBhdGlibGUgPSAic2Ftc3VuZyxleHlub3M1NDIwIiB9LAo+ICsJeyAuY29tcGF0aWJs
ZSA9ICJzYW1zdW5nLGV4eW5vczU4MDAiIH0sCj4gICAJe30sCj4gICB9Owo+Cj4KCgotLSAKICA8
aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdh
cmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29t
L3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29y
Zz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
