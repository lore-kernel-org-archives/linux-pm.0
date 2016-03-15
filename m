From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/2] vga_switcheroo: add power support for windows 10
 machines.
Date: Tue, 15 Mar 2016 14:39:58 +0100
Message-ID: <20160315133958.GA27793@wunner.de>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
 <2736217.utxPzJExd5@vostro.rjw.lan>
 <20160311105815.GS1796@lahna.fi.intel.com>
 <2759763.dR5D0KopkA@vostro.rjw.lan>
 <CAPM=9txo4aOOa-CS-mnyQe+vYDtAOCm1bzAgfMzwJJS8ZuYmwQ@mail.gmail.com>
 <20160314094335.GE1796@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20160314094335.GE1796@lahna.fi.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

SGkgTWlrYSwKCk9uIE1vbiwgTWFyIDE0LCAyMDE2IGF0IDExOjQzOjM1QU0gKzAyMDAsIE1pa2Eg
V2VzdGVyYmVyZyB3cm90ZToKPiBPbiBNb24sIE1hciAxNCwgMjAxNiBhdCAxMjoxOToxNFBNICsx
MDAwLCBEYXZlIEFpcmxpZSB3cm90ZToKPiA+IE9uIDExIE1hcmNoIDIwMTYgYXQgMjM6NDUsIFJh
ZmFlbCBKLiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5ldD4gd3JvdGU6Cj4gPiA+IE9uIEZyaWRh
eSwgTWFyY2ggMTEsIDIwMTYgMTI6NTg6MTUgUE0gTWlrYSBXZXN0ZXJiZXJnIHdyb3RlOgo+ID4g
Pj4gT24gVGh1LCBNYXIgMTAsIDIwMTYgYXQgMDk6NTc6MDlQTSArMDEwMCwgUmFmYWVsIEouIFd5
c29ja2kgd3JvdGU6Cj4gPiA+PiA+ID4gSXQgZG9lc24ndCBzZWVtIHRvIGRvIGFueSBydW50aW1l
IFBNLAo+ID4gPj4gPiA+IEkgZG8gd29uZGVyIGlmIHBjaWVwb3J0IHNob3VsZCBiZSBkb2luZyBp
dCdzIG93biBydW50aW1lIFBNIGhhbmRsaW5nLAo+ID4gPj4gPiA+IGJ1dCB0aGF0IGlzIGEKPiA+
ID4+ID4gPiBsYXJnZXIgdGFzayB0aGFuIEknbSB0aGlua2luZyB0byB0YWNrbGUgaGVyZS4KPiA+
ID4+ID4KPiA+ID4+ID4gUENJZSBwb3J0cyBkb24ndCBkbyBQTSAtIHlldC4gIE1pa2EgaGFzIHBv
c3RlZCBhIHNlcmllcyBvZiBwYXRjaGVzIHRvIGltcGxlbWVudAo+ID4gPj4gPiB0aGF0LCBob3dl
dmVyLCB0aGF0IGFyZSB3YWl0aW5nIGZvciBjb21tZW50cyBub3c6Cj4gPiA+PiA+Cj4gPiA+PiA+
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvODQ1MzMxMS8KPiA+ID4+ID4gaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC84NDUzMzgxLwo+ID4gPj4gPiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzg0NTMzOTEvCj4gPiA+PiA+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvODQ1MzQxMS8KPiA+ID4+ID4gaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wYXRjaC84NDUzMzcxLwo+ID4gPj4gPiBodHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3BhdGNoLzg0NTMzNTEvCgpJZiBhIHBjaWVocCBwb3J0IGlzIHJ1bnRpbWUgc3Vz
cGVuZGVkIGFuZCBwY2llaHBfcG9sbF9tb2RlIGlzIGVuYWJsZWQsCnRoZSBwb2xsIHRpbWVyIG5l
ZWRzIHRvIGJlIGRpc2FibGVkIGFuZCBsYXRlciByZWVuYWJsZWQgb24gcnVudGltZSByZXN1bWUu
CgpEb24ndCB3ZSBuZWVkIHRvIGFkZCBydW50aW1lIHBtIGNhbGxiYWNrcyB0byBzdHJ1Y3QgcGNp
ZV9wb3J0X3NlcnZpY2VfZHJpdmVyCmZvciB0aGF0LCBhbmQgY2FsbCB0aGVtIGZyb20gcGNpZV9w
b3J0X3J1bnRpbWVfKigpPwoKQmVzdCByZWdhcmRzLAoKTHVrYXMKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
