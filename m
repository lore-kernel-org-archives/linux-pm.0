From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v12] acpi, apei, arm64: APEI initial support for aarch64.
Date: Wed, 10 Aug 2016 21:05:27 +0800
Message-ID: <CADyBb7vPhbhGZU+UB7JcP_okA0XV+-yPZe0ass67TZWBMpNRBA@mail.gmail.com>
References: <1469782664-12611-1-git-send-email-fu.wei@linaro.org>
 <20160804094838.GB8093@nazgul.tnic>
 <CADyBb7ujfaXPP_CUB66_E53fY9MeEbt6EhOaCzf+hoDCGYD+dw@mail.gmail.com>
 <20160810104513.GB16664@nazgul.tnic>
 <CADyBb7uW2-jh8UBLXZ03p1y9SMP7M3z6eULwV2DYhWXEqTm2Rw@mail.gmail.com>
 <20160810111005.GD16664@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160810111005.GD16664@nazgul.tnic>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Borislav Petkov <bp@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, pavel@ucw.cz, hpa@zytor.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, mingo@redhat.com, len.brown@intel.com, linux-pm@vger.kernel.org, Marc Zyngier <Marc.Zyngier@arm.com>, Jon Masters <jcm@redhat.com>, matt.fleming@intel.com, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Jonathan Zhang <jon.zhixiong.zhang@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgQm9yaXNsYXYsCgpPbiAxMCBBdWd1c3QgMjAxNiBhdCAxOToxMCwgQm9yaXNsYXYgUGV0a292
IDxicEBzdXNlLmRlPiB3cm90ZToKPiBPbiBXZWQsIEF1ZyAxMCwgMjAxNiBhdCAwNzowMTowNVBN
ICswODAwLCBGdSBXZWkgd3JvdGU6Cj4+IC0gaWYgKCFhY3BpX2Rpc2FibGVfY21jZmYpCj4+IC0g
YXBlaV9oZXN0X3BhcnNlKGhlc3RfcGFyc2VfY21jLCBOVUxMKTsKPj4gKyByYyA9YXBlaV9oZXN0
X3BhcnNlKGhlc3RfcGFyc2VfY21jLCBOVUxMKTsKPj4gKyBpZiAocmMpCj4+ICsgZ290byBlcnI7
Cj4+Cj4+ICAgaWYgKCFnaGVzX2Rpc2FibGUpIHsKPj4gICByYyA9IGFwZWlfaGVzdF9wYXJzZSho
ZXN0X3BhcnNlX2doZXNfY291bnQsICZnaGVzX2NvdW50KTsKPj4KPj4gRG8geW91IGhhdmUgb3Ro
ZXIgc3VnZ2VzdGlvbj8gdGhlbiBJIGNhbiBwb3N0IHYxNCB0byBmaXggaXQgOi0pCj4KPiBOYWgs
IGxvb2tzIGdvb2QgOikKPgo+IExldCdzIGtlZXAgaXQgc2ltcGxlIGFuZCBhZGQgbW9yZSBpbnZv
bHZlZCBoYW5kbGluZyB3aGVuIGl0IGlzIHJlYWxseQo+IG5lZWRlZC4gVGhhbmtzIQoKVGhhbmtz
IGZvciB5b3VyIGhlbHAsIHRoaXMgaGF2ZSBiZWVuIGZpeGVkIGluIHYxNChqdXN0IHBvc3RlZCku
Cgo+Cj4gQnR3LCB0aGF0IGNvbW1lbnQ6Cj4KPiArLyoKPiArICogYWNwaV9kaXNhYmxlX2NtY2Zm
IGlzIHVzZWQgaW4gZHJpdmVycy9hY3BpL2FwZWkvaGVzdC5jIGZvciBkaXNhYmxpbmcKPiArICog
SUEtMzIgQXJjaGl0ZWN0dXJlIENvcnJlY3RlZCBNYWNoaW5lIENoZWNreChjbWMpIEZJUk1XQVJF
X0ZJUlNUIG1vZGUgYnkKPiArICogYm9vdCBwYXJhbWV0ZXIoYWNwaT1ub2NtY2ZmKS4gQnV0IHdl
IGRvbid0IGhhdmUgdGhpcyBJQS0zMiBzcGVjaWZpYwo+ICsgKiBmZWF0dXJlIG9uIEFSTTY0LCB0
aGlzIGRlZmluaXRpb24gaXMgb25seSBmb3IgY29tcGF0aWJpbGl0eS4KPiArICovCj4gKyNkZWZp
bmUgYWNwaV9kaXNhYmxlX2NtY2ZmIDEKPgo+IGxvb2tzIG9rLCBleGNlcHQgdGhlIHNtYWxsIHR5
cG86Cj4KPiBBcmNoaXRlY3R1cmUgQ29ycmVjdGVkIE1hY2hpbmUgQ2hlY2t4KGNtYykKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCj4gTWFrZSB0aGF0Cj4KPiAiSUEtMzIg
QXJjaGl0ZWN0dXJlIENvcnJlY3RlZCBNYWNoaW5lIENoZWNrIChDTUMpIEZpcm13YXJlLUZpcnN0
IG1vZGUiCgpEb25lISBUaGFua3MgOi0pCgo+Cj4gVGhhbmtzLgo+Cj4gLS0KPiBSZWdhcmRzL0dy
dXNzLAo+ICAgICBCb3Jpcy4KPgo+IEVDTyB0aXAgIzEwMTogVHJpbSB5b3VyIG1haWxzIHdoZW4g
eW91IHJlcGx5Lgo+Cj4gU1VTRSBMaW51eCBHbWJILCBHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBK
YW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9uLCBIUkIgMjEyODQgKEFHIE7DvHJuYmVyZykKPiAt
LQoKCgotLSAKQmVzdCByZWdhcmRzLAoKRnUgV2VpClNvZnR3YXJlIEVuZ2luZWVyClJlZCBIYXQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
