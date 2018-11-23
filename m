From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/6] Add hw overheat IRQ support to Marvell thermal driver
Date: Fri, 23 Nov 2018 17:17:24 +0100
Message-ID: <20181123161730.11289-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Marc Zyngier <marc.zyngier@arm.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

SGVsbG8sCgpUaGlzIGlzIHRoZSBsYXN0IGJhdGNoIG9mIHBhdGNoZXMgYWJvdXQgdGhlIHRoZXJt
YWwgZHJpdmVyIHRoYXQgd2FzCnN1c3BlbmRlZCwgd2FpdGluZyBmb3IgdGhlIElDVS9TRUkgc2Vy
aWVzIHRvIGJlIG1lcmdlZC4gTm93IHRoYXQKZXZlcnl0aGluZyBpcyByZWFkeSBpbiBtYWlubGlu
ZSwgbGV0J3MgYWRkIGhhcmR3YXJlIG92ZXJoZWF0IGludGVycnVwdApzdXBwb3J0IHRvIHRoaXMg
ZHJpdmVyLgoKQmluZGluZ3MgYW5kIERUIGFyZSB1cGRhdGVkIGFjY29yZGluZ2x5LiBUaGUgaW50
ZXJydXB0IHdpbGwgb25seSBiZQp0cmlnZ2VyZWQgaWYgdGhlIHBsYXRmb3JtIGdvZXMgYWJvdmUg
MTAywrBDICh0aHJlc2hvbGQgc2V0IHRvIDEwMMKwQywKaHlzdGVyZXNpcyB0byA+IDLCsEMpLiBU
aGUgaW50ZXJydXB0IHByb3BlcnR5IGlzIG9mIGNvdXJzZSBub3QKbWFuZGF0b3J5LgoKSW4gdGhl
IG1lYW4gdGltZSwgSSBhZGQgbXlzZWxmIHRvIHRoZSBNQUlOVEFJTkVSUyBmaWxlIHRvIHJlY2Vp
dmUgYW5kCnJldmlldyBwb3NzaWJsZSBmaXhlcy9uZXcgZmVhdHVyZXMuCgpDb21tZW50cyBhcmUg
d2VsY29tZS4KClRoYW5rcywKTWlxdcOobAoKCkNoYW5nZXMgc2luY2UgdjE6Cj09PT09PT09PT09
PT09PT09CiogVXNlIGEgdGhyZWFkZWQgSVJRIGhhbmRsZXIgdG8gYXZvaWQgYSBwb3RlbnRpYWwg
bG9jayBkZXBlbmN5IHdoZW4KICBub3RpZnlpbmcgdGhlIGNvcmUgb2YgYW4gb3ZlcmhlYXQgc2l0
dWF0aW9uLgoKCk1pcXVlbCBSYXluYWwgKDYpOgogIHRoZXJtYWw6IGFybWFkYTogYWRkIG92ZXJo
ZWF0IGludGVycnVwdCBzdXBwb3J0CiAgTUFJTlRBSU5FUlM6IHRoZXJtYWw6IGFkZCBlbnRyeSBm
b3IgTWFydmVsbCBNVkVCVSB0aGVybWFsIGRyaXZlcgogIGR0LWJpbmRpbmdzOiBhcDgwNjogZG9j
dW1lbnQgdGhlIHRoZXJtYWwgaW50ZXJydXB0IGNhcGFiaWxpdGllcwogIGR0LWJpbmRpbmdzOiBj
cDExMDogZG9jdW1lbnQgdGhlIHRoZXJtYWwgaW50ZXJydXB0IGNhcGFiaWxpdGllcwogIGFybTY0
OiBkdHM6IG1hcnZlbGw6IGFkZCBpbnRlcnJ1cHQgc3VwcG9ydCB0byBhcDgwNiB0aGVybWFsIG5v
ZGUKICBhcm02NDogZHRzOiBtYXJ2ZWxsOiBhZGQgaW50ZXJydXB0IHN1cHBvcnQgdG8gY3AxMTAg
dGhlcm1hbCBub2RlCgogLi4uL2FybS9tYXJ2ZWxsL2FwODA2LXN5c3RlbS1jb250cm9sbGVyLnR4
dCAgIHwgICA4ICsKIC4uLi9hcm0vbWFydmVsbC9jcDExMC1zeXN0ZW0tY29udHJvbGxlci50eHQg
ICB8ICAgOSArCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDUgKwogYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1hcDgwNi5kdHNpIHwg
IDE4ICstCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWNwMTEwLmR0c2kgfCAg
MTUgKy0KIGRyaXZlcnMvdGhlcm1hbC9hcm1hZGFfdGhlcm1hbC5jICAgICAgICAgICAgICB8IDI3
MCArKysrKysrKysrKysrKysrKy0KIDYgZmlsZXMgY2hhbmdlZCwgMzE4IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pCgotLSAKMi4xOS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
