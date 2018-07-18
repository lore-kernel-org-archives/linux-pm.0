From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 00/23] Add multi-channel support to Armada thermal
 driver
Date: Wed, 18 Jul 2018 17:28:49 +0200
Message-ID: <20180718172849.30b7cec0@xps13>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180716144206.30985-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgRWR1YXJkbywKCk1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+IHdy
b3RlIG9uIE1vbiwgMTYgSnVsIDIwMTgKMTY6NDE6NDMgKzAyMDA6Cgo+IFRoZSBvbmx5IGNhcGFi
aWxpdHkgb2YgdGhlIEFybWFkYSB0aGVybWFsIGRyaXZlciBpcyBjdXJyZW50bHkganVzdCB0bwo+
IHJlYWQgb25lIHNlbnNvciAodGhlIGRlZmF1bHQgb25lKSBwZXIgQVAgYW5kIG9uZSBwZXIgQ1Au
IEFjdHVhbGx5LAo+IHRoZXJlIGlzIG9uZSBzZW5zb3IgcGVyIGNvcmUgaW4gdGhlIEFQODA2IHBs
dXMgb25lIHNlbnNvciBpbiB0aGUKPiB0aGVybWFsIElQIGl0c2VsZi4gVGhlIENQMTEwIGp1c3Qg
ZmVhdHVyZXMgb25lIHRoZXJtYWwgc2Vuc29yIGluIGl0cwo+IG93biB0aGVybWFsIElQLgo+IAo+
IFRoaXMgc2VyaWVzIGZpcnN0IGltcHJvdmVzIHRoZSByZWFkYWJpbGl0eSBvZiB0aGlzIGRyaXZl
ciwgdGhlbiBhZGRzCj4gc3VwcG9ydCBmb3IgbXVsdGktY2hhbm5lbCB0aGVybWFsIElQcy4gVGhl
IGJpbmRpbmdzIGFuZCB0aGUKPiBkZXZpY2UtdHJlZXMgYXJlIHVwZGF0ZWQgYWNjb3JkaW5nbHku
Cj4gCj4gVGhhbmsgeW91LAo+IE1pcXXDqGwKCkkga25vdyBJIHNlbnQgdGhpcyBzZXJpZXMgb24g
bW9uZGF5IGJ1dCB0aGVyZSB3YXMgYWxtb3N0IG5vIGNoYW5nZSBvbgppdCAoc2VlIGJlbG93KSwg
ZG8geW91IHRoaW5rIHlvdSB3aWxsIGhhdmUgdGhlIHRpbWUgdG8gbG9vayBhdCBpdApiZWZvcmUg
aXQncyB0b28gbGF0ZSBmb3IgdGhlIG1lcmdlIHdpbmRvdz8KClRoYW5rIHlvdSwKTWlxdcOobAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
