From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3] thermal: tango: add resume support
Date: Fri, 19 Aug 2016 19:29:56 +0800
Message-ID: <1471606196.2691.58.camel@intel.com>
References: <57726196.5060909@free.fr> <4062048.3qHsMMf8fO@wuerfel>
 <5795E07F.6010506@free.fr> <8406200.nXRkviT67W@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8406200.nXRkviT67W@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Sebastian Frias <sf84@laposte.net>, linux-pm <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, Mason <slash.tmp@free.fr>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pm@vger.kernel.org

T24g5LqMLCAyMDE2LTA3LTI2IGF0IDE0OjEzICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+
IE9uIE1vbmRheSwgSnVseSAyNSwgMjAxNiAxMTo0ODo0NyBBTSBDRVNUIE1hc29uIHdyb3RlOgo+
ID4gCj4gPiBPbiAyNS8wNy8yMDE2IDEwOjUyLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+ID4gCj4g
PiA+IAo+ID4gPiBPbiBNb25kYXksIEp1bHkgMjUsIDIwMTYgMTA6MTg6MjIgQU0gQ0VTVCBNYXNv
biB3cm90ZToKPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gTW92aW5nIHRoZSBTSU1QTEVfREVWX1BN
X09QUyBtYWNybyBvdXRzaWRlIHRoZSBDT05GSUdfUE1fU0xFRVAKPiA+ID4gPiBndWFyZAo+ID4g
PiA+IHdvdWxkIHVuY29uZGl0aW9uYWxseSBkZWZpbmUgYSBzdHJ1Y3QgZGV2X3BtX29wcywgd2hp
Y2gganVzdAo+ID4gPiA+IHdhc3Rlcwo+ID4gPiA+IHNwYWNlIHdoZW4gQ09ORklHX1BNX1NMRUVQ
IGlzIHVuZGVmaW5lZCAoaWYgSSdtIG5vdCBtaXN0YWtlbikuCj4gPiA+ID4gCj4gPiA+ID4gVGhh
dCdzIHdoeSBJIHB1dCBTSU1QTEVfREVWX1BNX09QUyBpbnNpZGUgdGhlIENPTkZJR19QTV9TTEVF
UAo+ID4gPiA+IGd1YXJkLgo+ID4gPiBJZiB5b3Ugd2FudCB0byBhdm9pZCB0aGUgZXh0cmEgZmV3
IGJ5dGVzLCBqdXN0IHVzZSB0aGUgdHJpY2sgSQo+ID4gPiBzdWdnZXN0ZWQ6Cj4gPiA+IAo+ID4g
PiDCoMKgwqDCoMKgwqAucG0gPSBJU19FTkFCTEVEKENPTkZJR19QTV9TTEVFUCkgPyAmdGFuZ29f
dGhlcm1hbF9wbSA6Cj4gPiA+IE5VTEwsCj4gPiBUaGlzIHdvdWxkIGFjaGlldmUgdGhlIHNhbWUg
cmVzdWx0IGFzIHRoZSBzb2x1dGlvbiBJIHByb3Bvc2VkCj4gPiBpbiBteSB2MiBwYXRjaCwgcmln
aHQ/Cj4gPiAKPiA+IFNvIHlvdSdyZSBzYXlpbmcgeW91IHByZWZlciB0aGUgSVNfRU5BQkxFRCBt
YWNybyBvdmVyIHVzaW5nCj4gPiAjaWZkZWYgLi4uICNlbHNlIGRlZmluZSBzdHVmZiBhcyBOVUxM
ICNlbmRpZgo+ID4gCj4gPiBEaWQgSSBnZXQgdGhhdCByaWdodD8KPiBZZXMsIGJ1dCBJJ2QgYWxz
byBwcmVmZXIgbm90IHRvIGhpZGUgdGhlIG9wZXJhdGlvbnMgc3RydWN0dXJlCj4gYXQgYWxsIGFu
ZCBqdXN0IHJlbHkgb24gdGhlIF9fbWF5YmVfdW51c2VkIChpZGVhbGx5KSBvcgo+ICNpZmRlZiAo
bm90IGFzIGdvb2QsIGJ1dCBjb21tb25seSB1c2VkKSB0byBsZWF2ZSBvdXQgdGhlCj4gZnVuY3Rp
b25zLgo+IApJTU8sIHRoZSB0eXBpY2FsIHdheSBpcyB0byB1c2UgI2lmZGVmIGZvciB0aGUgcG0g
Y2FsbGJhY2tzLCBhbmQgbGVhdmUKU0lNUExFX0RFVl9QTV9PUFMgb3V0c2lkZSB0aGUgI2lmZGVm
LgpGb3IgZXhhbXBsZSzCoGRyaXZlcnMvYXRhL2FoY2lfaW14LmMuCgp0aGFua3MsCnJ1aQo+ID4g
Cj4gPiBFZHVhcmRvLCBaaGFuZywgd2hhdCBkbyB0aGVybWFsIG1haW50YWluZXJzIHByZWZlcj8K
PiA+IAo+ID4gPiAKPiA+ID4gWW91IHNob3VsZCBiYXNpY2FsbHkgbmV2ZXIgaGF2ZSB0aGF0ICNp
ZmRlZiBpbnNpZGUgb2YgdGhlCj4gPiA+IHBsYXRmb3JtX2RyaXZlciBkZWZpbml0aW9uLgo+ID4g
RXhjZXB0IHdoZW4gdGhlIGZpZWxkcyBkb24ndCBleGlzdCwgbGlrZSB0aGUgYnVnIEkgaW50cm9k
dWNlZAo+ID4gaW4gc3RydWN0IHNtcF9vcGVyYXRpb25zICh3aGljaCB5b3UgZml4ZWQpLgo+IFJp
Z2h0Lgo+IAo+IAlBcm5kCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
