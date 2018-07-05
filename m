From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 06/23] thermal: armada: convert driver to syscon
 register accesses
Date: Thu, 5 Jul 2018 17:53:46 +0200
Message-ID: <20180705175346.0ff7a906@xps13>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-7-miquel.raynal@bootlin.com>
 <20180626033724.q7radxgjeqtsl7ae@tarshish>
 <20180626092931.7f0f0ad4@xps13>
 <20180702172918.GA28262@localhost.localdomain>
 <20180705144333.2cf0fe6a@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180705144333.2cf0fe6a@xps13>
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

SGkgRWR1YXJkbywKCk1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+IHdy
b3RlIG9uIFRodSwgNSBKdWwgMjAxOAoxNDo0MzozMyArMDIwMDoKCj4gSGkgRWR1YXJkbywKPiAK
PiBFZHVhcmRvIFZhbGVudGluIDxlZHViZXp2YWxAZ21haWwuY29tPiB3cm90ZSBvbiBNb24sIDIg
SnVsIDIwMTgKPiAxMDoyOToxOSAtMDcwMDoKPiAKPiA+IE1pcXVlbCwKPiA+IAo+ID4gT24gVHVl
LCBKdW4gMjYsIDIwMTggYXQgMDk6Mjk6MzFBTSArMDIwMCwgTWlxdWVsIFJheW5hbCB3cm90ZTog
IAo+ID4gPiBIaSBCYXJ1Y2gsCj4gPiA+IAo+ID4gPiBPbiBUdWUsIDI2IEp1biAyMDE4IDA2OjM3
OjI0ICswMzAwLCBCYXJ1Y2ggU2lhY2ggPGJhcnVjaEB0a29zLmNvLmlsPgo+ID4gPiB3cm90ZToK
PiA+ID4gICAgIAo+ID4gPiA+IEhpIE1pcXVlbCwKPiA+ID4gPiAKPiA+ID4gPiBPbiBNb24sIEp1
biAyNSwgMjAxOCBhdCAwNToxMjoyMlBNICswMjAwLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOiAgICAK
PiA+ID4gPiA+IFVudGlsIHJlY2VudGx5LCBvbmx5IG9uZSByZWdpc3RlciB3YXMgcmVmZXJlbmNl
ZCBpbiBNVkVCVSB0aGVybWFsIElQCj4gPiA+ID4gPiBub2RlLiBSZWNlbnQgY2hhbmdlcyBhZGRl
ZCBhIHNlY29uZCBlbnRyeSBwb2ludGluZyB0byBhbm90aGVyCj4gPiA+ID4gPiByZWdpc3RlciBy
aWdodCBuZXh0IHRvIGl0LiBXZSBjYW5ub3Qga25vdyBmb3Igc3VyZSB0aGF0IHdlIHdpbGwgbm90
Cj4gPiA+ID4gPiBoYXZlIHRvIGFjY2VzcyBvdGhlciByZWdpc3RlcnMuIFRoYXQgd2lsbCBiZSBh
Y3R1YWxseSB0aGUgY2FzZSB3aGVuCj4gPiA+ID4gPiBvdmVyaGVhdCBpbnRlcnJ1cHQgZmVhdHVy
ZSB3aWxsIGNvbWUsIHdoZXJlIGl0IHdpbGwgYmUgbmVlZGVkIHRvIGFjY2Vzcwo+ID4gPiA+ID4g
REZYIHJlZ2lzdGVycyBpbiB0aGUgc2FtZSBhcmVhLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBUaGlz
IGFwcHJvYWNoIGlzIG5vdCBzY2FsYWJsZSBzbyBpbnRlYWQgb2YgYWRkaW5nIGNvbnNpbnVvdXNs
eSBtZW1vcnkKPiA+ID4gPiA+IGFyZWFzIGluIHRoZSBEVCAoYW5kIGNoYW5nZSBkZSBEVCBiaW5k
aW5ncywgd2hpbGUga2VlcGluZyBiYWNrd2FyZCAgICAgIAo+ID4gPiA+IAo+ID4gPiA+IHMvZGUv
dGhlLyAgICAKPiA+ID4gCj4gPiA+IE9oIGFuZCBzL2ludGVhZC9pbnN0ZWFkLyB0b28uICAgIAo+
ID4gCj4gPiBDYW4geW91IHBsZWFzZSBmaXggdGhlIG1pbm9yIGFib3ZlIGFuZCBhbHNvIHJlZnJl
c2ggYWdhaW5zdCBsaW51cyBtYXN0ZXIKPiA+IGJyYW5jaD8gUGF0Y2ggZG9lcyBub3QgYXBwbHkg
Y2xlYW4gYW55bW9yZS4gIAo+IAo+IFN1cmUsIEknbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIHJlYmFz
ZWQgb24gdG9wIG9mIExpbnVzJ3MgbWFzdGVyIGJyYW5jaC4KCkFjdHVhbGx5IHRoaXMgc2VyaWVz
IHdhcyBiYXNlZCBvbiB2NC4xOC1yYzEuIFdoZW4gSSByZWJhc2VkIG9uIHRvcCBvZgpMaW51cydz
IG1hc3RlciBicmFuY2ggSSBoYWQgbm8gY29uZmxpY3RzIHRvIGZpeC4gSSB3aWxsIHJlcG9zdCBh
IHYzIGJ1dAppZiB0aGUgcHJvYmxlbSBwZXJzaXN0cyB5b3UgbWlnaHQgd2FudCB0byBzaGFyZSB0
aGUgY29uZmxpY3RzIG9yIGdpdmUKbWUgYSBicmFuY2ggb24gdG9wIG9mIHdoaWNoIEkgc2hvdWxk
IGJhc2UgdGhpcyB3b3JrLgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
