From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [Q] How to tell we're using the KMS (during
	suspend/resume) outside the graphics driver
Date: Tue, 6 Apr 2010 09:47:50 +0200
Message-ID: <q2xb170af451004060047t7b661f63p903d4bd7452a1e45__34986.3536227078$1270540262$gmane$org@mail.gmail.com>
References: <201003062236.09801.rjw@sisk.pl>
	<548cdfc21003100254t5c94aca5u5cf1e9eb29215325@mail.gmail.com>
	<20100310205618.GA28628@srcf.ucam.org>
	<201003102215.26232.rjw@sisk.pl>
	<20100310211704.GA29201@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100310211704.GA29201@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>, Pauli Nieminen <suokkos@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

MjAxMC8zLzEwIE1hdHRoZXcgR2FycmV0dCA8bWpnNTlAc3JjZi51Y2FtLm9yZz46Cj4gT24gV2Vk
LCBNYXIgMTAsIDIwMTAgYXQgMTA6MTU6MjZQTSArMDEwMCwgUmFmYWVsIEouIFd5c29ja2kgd3Jv
dGU6Cj4+IE9uIFdlZG5lc2RheSAxMCBNYXJjaCAyMDEwLCBNYXR0aGV3IEdhcnJldHQgd3JvdGU6
Cj4+ID4gQXMgZmFyIGFzIHRoZSBBQ1BJIHZpZGVvIGRyaXZlciBnb2VzLCBhY3BpX2dldF9waHlz
aWNhbF9wY2lfZGV2aWNlKCkKPj4gPiB3aWxsIGdpdmUgeW91IHNvbWV0aGluZyB0byB3b3JrIHdp
dGguCj4+Cj4+IEhtbS4gwqBEaWQgeW91IG1lYW4gYWNwaV9nZXRfcGh5c2ljYWxfZGV2aWNlKCk/
Cj4KPiBBaCwgbm8sIGFjcGlfZ2V0X3BjaV9kZXYuCgpTbywgQUZBSVUgYWNwaV9nZXRfcGNpX2Rl
diB3aWxsIGdpdmUgbWUgcG9pbnRlciB0byBzdHJ1Y3QgcGNpX2RldiBvZgp2aWRlbyBjYXJkLCB5
ZXM/CgpUaGVyZSBpcyBzb21lIHBhdGggSSBjb3VsZCB1c2UgdGhlbjoKCnN0cnVjdCBwY2lfZGV2
IHsKICAgIC4uLi4uCiAgICBzdHJ1Y3QgcGNpX2RyaXZlciAqZHJpdmVyOwkvKiB3aGljaCBkcml2
ZXIgaGFzIGFsbG9jYXRlZCB0aGlzIGRldmljZSAqLwogICAgLi4uLi4KfQoKc3RydWN0IHBjaV9k
cml2ZXIgewogICAgLi4uLi4KICAgIHN0cnVjdCBkZXZpY2VfZHJpdmVyCWRyaXZlcjsKICAgIC4u
Li4uCn0KCkZpbmFsbHksIHN0cnVjdCBkZXZpY2VfZHJpdmVyIGlzIGRlZmluZWQgaW4gZGV2aWNl
LmguIFNob3VsZCBJIGFkZCBmbGFnCmJvb2wgaXNfa21zCnRvIHRoaXMgc3RydWN0IHRoZW4/CgpB
RkFJSyB3ZSBjYW4gbm90IGRvIGFueXRoaW5nIHdpdGggc3RydWN0IGRyaXZlcl9wcml2YXRlICpw
Li4uIE9yIGlzCnRoZXJlIHVuaWZpZWQgc3RydWN0IGZvciB2aWRlbyBjYXJkIGRyaXZlcnM/IFdl
IGNvdWxkIHRoZW4gYWRkIGZsYWcKaXNfa21zIHRvIHNvbWUgc3RydWN0IHBvaW50ZWQgYnkgc3Ry
dWN0IGRyaXZlcl9wcml2YXRlICpwLgoKLS0gClJhZmHFggpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
