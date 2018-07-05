From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 06/23] thermal: armada: convert driver to syscon
 register accesses
Date: Thu, 5 Jul 2018 14:43:33 +0200
Message-ID: <20180705144333.2cf0fe6a@xps13>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-7-miquel.raynal@bootlin.com>
 <20180626033724.q7radxgjeqtsl7ae@tarshish>
 <20180626092931.7f0f0ad4@xps13>
 <20180702172918.GA28262@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180702172918.GA28262@localhost.localdomain>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgRWR1YXJkbywKCkVkdWFyZG8gVmFsZW50aW4gPGVkdWJlenZhbEBnbWFpbC5jb20+IHdyb3Rl
IG9uIE1vbiwgMiBKdWwgMjAxOAoxMDoyOToxOSAtMDcwMDoKCj4gTWlxdWVsLAo+IAo+IE9uIFR1
ZSwgSnVuIDI2LCAyMDE4IGF0IDA5OjI5OjMxQU0gKzAyMDAsIE1pcXVlbCBSYXluYWwgd3JvdGU6
Cj4gPiBIaSBCYXJ1Y2gsCj4gPiAKPiA+IE9uIFR1ZSwgMjYgSnVuIDIwMTggMDY6Mzc6MjQgKzAz
MDAsIEJhcnVjaCBTaWFjaCA8YmFydWNoQHRrb3MuY28uaWw+Cj4gPiB3cm90ZToKPiA+ICAgCj4g
PiA+IEhpIE1pcXVlbCwKPiA+ID4gCj4gPiA+IE9uIE1vbiwgSnVuIDI1LCAyMDE4IGF0IDA1OjEy
OjIyUE0gKzAyMDAsIE1pcXVlbCBSYXluYWwgd3JvdGU6ICAKPiA+ID4gPiBVbnRpbCByZWNlbnRs
eSwgb25seSBvbmUgcmVnaXN0ZXIgd2FzIHJlZmVyZW5jZWQgaW4gTVZFQlUgdGhlcm1hbCBJUAo+
ID4gPiA+IG5vZGUuIFJlY2VudCBjaGFuZ2VzIGFkZGVkIGEgc2Vjb25kIGVudHJ5IHBvaW50aW5n
IHRvIGFub3RoZXIKPiA+ID4gPiByZWdpc3RlciByaWdodCBuZXh0IHRvIGl0LiBXZSBjYW5ub3Qg
a25vdyBmb3Igc3VyZSB0aGF0IHdlIHdpbGwgbm90Cj4gPiA+ID4gaGF2ZSB0byBhY2Nlc3Mgb3Ro
ZXIgcmVnaXN0ZXJzLiBUaGF0IHdpbGwgYmUgYWN0dWFsbHkgdGhlIGNhc2Ugd2hlbgo+ID4gPiA+
IG92ZXJoZWF0IGludGVycnVwdCBmZWF0dXJlIHdpbGwgY29tZSwgd2hlcmUgaXQgd2lsbCBiZSBu
ZWVkZWQgdG8gYWNjZXNzCj4gPiA+ID4gREZYIHJlZ2lzdGVycyBpbiB0aGUgc2FtZSBhcmVhLgo+
ID4gPiA+IAo+ID4gPiA+IFRoaXMgYXBwcm9hY2ggaXMgbm90IHNjYWxhYmxlIHNvIGludGVhZCBv
ZiBhZGRpbmcgY29uc2ludW91c2x5IG1lbW9yeQo+ID4gPiA+IGFyZWFzIGluIHRoZSBEVCAoYW5k
IGNoYW5nZSBkZSBEVCBiaW5kaW5ncywgd2hpbGUga2VlcGluZyBiYWNrd2FyZCAgICAKPiA+ID4g
Cj4gPiA+IHMvZGUvdGhlLyAgCj4gPiAKPiA+IE9oIGFuZCBzL2ludGVhZC9pbnN0ZWFkLyB0b28u
ICAKPiAKPiBDYW4geW91IHBsZWFzZSBmaXggdGhlIG1pbm9yIGFib3ZlIGFuZCBhbHNvIHJlZnJl
c2ggYWdhaW5zdCBsaW51cyBtYXN0ZXIKPiBicmFuY2g/IFBhdGNoIGRvZXMgbm90IGFwcGx5IGNs
ZWFuIGFueW1vcmUuCgpTdXJlLCBJJ2xsIHNlbmQgYSBuZXcgdmVyc2lvbiByZWJhc2VkIG9uIHRv
cCBvZiBMaW51cydzIG1hc3RlciBicmFuY2guCgpUaGFua3MgZm9yIHRha2luZyB0aGUgdGltZSB0
byBjaGVjayB0aGUgc2VyaWVzLApNaXF1w6hsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
