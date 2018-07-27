From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 02/23] thermal: armada: remove useless register accesses
Date: Fri, 27 Jul 2018 17:56:21 +0200
Message-ID: <8b241e12-f7fe-1992-d634-0d38d956014f@linaro.org>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-3-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180716144206.30985-3-miquel.raynal@bootlin.com>
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
To: Miquel Raynal <miquel.raynal@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

T24gMTYvMDcvMjAxOCAxNjo0MSwgTWlxdWVsIFJheW5hbCB3cm90ZToKPiBQcmVwYXJlIHRoZSBt
aWdyYXRpb24gdG8gdXNlIHJlZ21hcHMgYnkgZmlyc3Qgc2ltcGxpZnlpbmcgdGhlCj4gaW5pdGlh
bGl6YXRpb24gZnVuY3Rpb25zOiBhdm9pZCB1bm5lY2Vzc2FyeSB3cml0ZS9yZWFkIGN5Y2xlcyBv
bgo+IGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBS
YXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+CgpHb29kIGNhdGNoLiBJJ20gd29uZGVy
aW5nIHdoeSBpdCB3YXMgZG9uZSB0aGlzIHdheSAuLi4KClJldmlld2VkLWJ5OiBEYW5pZWwgTGV6
Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4KCj4gLS0tCj4gIGRyaXZlcnMvdGhlcm1h
bC9hcm1hZGFfdGhlcm1hbC5jIHwgOCArKy0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJt
YWwvYXJtYWRhX3RoZXJtYWwuYyBiL2RyaXZlcnMvdGhlcm1hbC9hcm1hZGFfdGhlcm1hbC5jCj4g
aW5kZXggMDc3ZThlNTYyMzA2Li42ZmRiOTBiM2MwMDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy90
aGVybWFsL2FybWFkYV90aGVybWFsLmMKPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvYXJtYWRhX3Ro
ZXJtYWwuYwo+IEBAIC0xMDMsMTYgKzEwMywxMyBAQCBzdGF0aWMgdm9pZCBhcm1hZGF4cF9pbml0
X3NlbnNvcihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LAo+ICAKPiAgCXJlZyA9IHJlYWRs
X3JlbGF4ZWQocHJpdi0+Y29udHJvbDEpOwo+ICAJcmVnIHw9IFBNVV9UREMwX09URl9DQUxfTUFT
SzsKPiAtCXdyaXRlbChyZWcsIHByaXYtPmNvbnRyb2wxKTsKPiAgCj4gIAkvKiBSZWZlcmVuY2Ug
Y2FsaWJyYXRpb24gdmFsdWUgKi8KPiAgCXJlZyAmPSB+UE1VX1REQzBfUkVGX0NBTF9DTlRfTUFT
SzsKPiAgCXJlZyB8PSAoMHhmMSA8PCBQTVVfVERDMF9SRUZfQ0FMX0NOVF9PRkZTKTsKPiAtCXdy
aXRlbChyZWcsIHByaXYtPmNvbnRyb2wxKTsKPiAgCj4gIAkvKiBSZXNldCB0aGUgc2Vuc29yICov
Cj4gLQlyZWcgPSByZWFkbF9yZWxheGVkKHByaXYtPmNvbnRyb2wxKTsKPiAtCXdyaXRlbCgocmVn
IHwgUE1VX1REQzBfU1dfUlNUX01BU0spLCBwcml2LT5jb250cm9sMSk7Cj4gKwlyZWcgfD0gUE1V
X1REQzBfU1dfUlNUX01BU0s7Cj4gIAo+ICAJd3JpdGVsKHJlZywgcHJpdi0+Y29udHJvbDEpOwo+
ICAKPiBAQCAtMTI5LDE0ICsxMjYsMTMgQEAgc3RhdGljIHZvaWQgYXJtYWRhMzcwX2luaXRfc2Vu
c29yKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCj4gIAo+ICAJcmVnID0gcmVhZGxfcmVs
YXhlZChwcml2LT5jb250cm9sMSk7Cj4gIAlyZWcgfD0gUE1VX1REQzBfT1RGX0NBTF9NQVNLOwo+
IC0Jd3JpdGVsKHJlZywgcHJpdi0+Y29udHJvbDEpOwo+ICAKPiAgCS8qIFJlZmVyZW5jZSBjYWxp
YnJhdGlvbiB2YWx1ZSAqLwo+ICAJcmVnICY9IH5QTVVfVERDMF9SRUZfQ0FMX0NOVF9NQVNLOwo+
ICAJcmVnIHw9ICgweGYxIDw8IFBNVV9UREMwX1JFRl9DQUxfQ05UX09GRlMpOwo+IC0Jd3JpdGVs
KHJlZywgcHJpdi0+Y29udHJvbDEpOwo+ICAKPiAgCXJlZyAmPSB+UE1VX1REQzBfU1RBUlRfQ0FM
X01BU0s7Cj4gKwo+ICAJd3JpdGVsKHJlZywgcHJpdi0+Y29udHJvbDEpOwo+ICAKPiAgCW1zbGVl
cCgxMCk7Cj4gCgoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIg
T3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6
Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0
ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGlu
YXJvLWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
