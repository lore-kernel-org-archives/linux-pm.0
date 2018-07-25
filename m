From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 00/23] Add multi-channel support to Armada thermal
 driver
Date: Wed, 25 Jul 2018 09:52:22 +0200
Message-ID: <20180725095222.054f1e80@xps13>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180718172849.30b7cec0@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180718172849.30b7cec0@xps13>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgRWR1YXJkbywgWmhhbmcsCgpNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4u
Y29tPiB3cm90ZSBvbiBXZWQsIDE4IEp1bCAyMDE4CjE3OjI4OjQ5ICswMjAwOgoKPiBIaSBFZHVh
cmRvLAo+IAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+IHdyb3Rl
IG9uIE1vbiwgMTYgSnVsIDIwMTgKPiAxNjo0MTo0MyArMDIwMDoKPiAKPiA+IFRoZSBvbmx5IGNh
cGFiaWxpdHkgb2YgdGhlIEFybWFkYSB0aGVybWFsIGRyaXZlciBpcyBjdXJyZW50bHkganVzdCB0
bwo+ID4gcmVhZCBvbmUgc2Vuc29yICh0aGUgZGVmYXVsdCBvbmUpIHBlciBBUCBhbmQgb25lIHBl
ciBDUC4gQWN0dWFsbHksCj4gPiB0aGVyZSBpcyBvbmUgc2Vuc29yIHBlciBjb3JlIGluIHRoZSBB
UDgwNiBwbHVzIG9uZSBzZW5zb3IgaW4gdGhlCj4gPiB0aGVybWFsIElQIGl0c2VsZi4gVGhlIENQ
MTEwIGp1c3QgZmVhdHVyZXMgb25lIHRoZXJtYWwgc2Vuc29yIGluIGl0cwo+ID4gb3duIHRoZXJt
YWwgSVAuCj4gPiAKPiA+IFRoaXMgc2VyaWVzIGZpcnN0IGltcHJvdmVzIHRoZSByZWFkYWJpbGl0
eSBvZiB0aGlzIGRyaXZlciwgdGhlbiBhZGRzCj4gPiBzdXBwb3J0IGZvciBtdWx0aS1jaGFubmVs
IHRoZXJtYWwgSVBzLiBUaGUgYmluZGluZ3MgYW5kIHRoZQo+ID4gZGV2aWNlLXRyZWVzIGFyZSB1
cGRhdGVkIGFjY29yZGluZ2x5Lgo+ID4gCj4gPiBUaGFuayB5b3UsCj4gPiBNaXF1w6hsICAKPiAK
PiBJIGtub3cgSSBzZW50IHRoaXMgc2VyaWVzIG9uIG1vbmRheSBidXQgdGhlcmUgd2FzIGFsbW9z
dCBubyBjaGFuZ2Ugb24KPiBpdCAoc2VlIGJlbG93KSwgZG8geW91IHRoaW5rIHlvdSB3aWxsIGhh
dmUgdGhlIHRpbWUgdG8gbG9vayBhdCBpdAo+IGJlZm9yZSBpdCdzIHRvbyBsYXRlIGZvciB0aGUg
bWVyZ2Ugd2luZG93PwoKSSBrbm93IGEgbGl0dGxlIGJpdCB3aGF0IGl0IGlzIHRvIGJlIG9uIHRo
ZSBtYWludGFpbmVyIHNpZGUgb2YgYQpzdWJzeXN0ZW0gYnV0IHRoZXNlIGNoYW5nZXMgYXJlIGxh
eWluZyBzaW5jZSBBcHJpbCwgMjFzdCBhbmQgSSByZWFsbHkKZXhwZWN0IHRvIGdldCB0aGVtIG1l
cmdlZC4gWmhhbmcsIGFzIEVkdWFyZG8gc2VlbXMgdG8gYmUgb3ZlcmxvYWRlZAp0aGlzIHJlbGVh
c2UsIGNvdWxkIHlvdSBwbGVhc2UgdGFrZSB0aGUgc2VyaWVzPwoKT2YgY291cnNlIGlmIHRoZXJl
IGFyZSB0aGluZ3MgdG8gYWRkcmVzcyBJJ2xsIGJlIGhhcHB5IHRvIGRvIHNvLgoKVGhhbmtzLApN
aXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
