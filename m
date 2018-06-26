From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 06/23] thermal: armada: convert driver to syscon
 register accesses
Date: Tue, 26 Jun 2018 09:29:31 +0200
Message-ID: <20180626092931.7f0f0ad4@xps13>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-7-miquel.raynal@bootlin.com>
 <20180626033724.q7radxgjeqtsl7ae@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180626033724.q7radxgjeqtsl7ae@tarshish>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgQmFydWNoLAoKT24gVHVlLCAyNiBKdW4gMjAxOCAwNjozNzoyNCArMDMwMCwgQmFydWNoIFNp
YWNoIDxiYXJ1Y2hAdGtvcy5jby5pbD4Kd3JvdGU6Cgo+IEhpIE1pcXVlbCwKPiAKPiBPbiBNb24s
IEp1biAyNSwgMjAxOCBhdCAwNToxMjoyMlBNICswMjAwLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+
ID4gVW50aWwgcmVjZW50bHksIG9ubHkgb25lIHJlZ2lzdGVyIHdhcyByZWZlcmVuY2VkIGluIE1W
RUJVIHRoZXJtYWwgSVAKPiA+IG5vZGUuIFJlY2VudCBjaGFuZ2VzIGFkZGVkIGEgc2Vjb25kIGVu
dHJ5IHBvaW50aW5nIHRvIGFub3RoZXIKPiA+IHJlZ2lzdGVyIHJpZ2h0IG5leHQgdG8gaXQuIFdl
IGNhbm5vdCBrbm93IGZvciBzdXJlIHRoYXQgd2Ugd2lsbCBub3QKPiA+IGhhdmUgdG8gYWNjZXNz
IG90aGVyIHJlZ2lzdGVycy4gVGhhdCB3aWxsIGJlIGFjdHVhbGx5IHRoZSBjYXNlIHdoZW4KPiA+
IG92ZXJoZWF0IGludGVycnVwdCBmZWF0dXJlIHdpbGwgY29tZSwgd2hlcmUgaXQgd2lsbCBiZSBu
ZWVkZWQgdG8gYWNjZXNzCj4gPiBERlggcmVnaXN0ZXJzIGluIHRoZSBzYW1lIGFyZWEuCj4gPiAK
PiA+IFRoaXMgYXBwcm9hY2ggaXMgbm90IHNjYWxhYmxlIHNvIGludGVhZCBvZiBhZGRpbmcgY29u
c2ludW91c2x5IG1lbW9yeQo+ID4gYXJlYXMgaW4gdGhlIERUIChhbmQgY2hhbmdlIGRlIERUIGJp
bmRpbmdzLCB3aGlsZSBrZWVwaW5nIGJhY2t3YXJkICAKPiAKPiBzL2RlL3RoZS8KCk9oIGFuZCBz
L2ludGVhZC9pbnN0ZWFkLyB0b28uCgpUaGFua3MgZm9yIHBvaW50aW5nIGl0LApNaXF1w6hsCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
