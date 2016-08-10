From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v12] acpi, apei, arm64: APEI initial support for aarch64.
Date: Wed, 10 Aug 2016 19:01:05 +0800
Message-ID: <CADyBb7uW2-jh8UBLXZ03p1y9SMP7M3z6eULwV2DYhWXEqTm2Rw@mail.gmail.com>
References: <1469782664-12611-1-git-send-email-fu.wei@linaro.org>
 <20160804094838.GB8093@nazgul.tnic>
 <CADyBb7ujfaXPP_CUB66_E53fY9MeEbt6EhOaCzf+hoDCGYD+dw@mail.gmail.com>
 <20160810104513.GB16664@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160810104513.GB16664@nazgul.tnic>
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

SGkgQm9yaXNsYXYsCgpPbiAxMCBBdWd1c3QgMjAxNiBhdCAxODo0NSwgQm9yaXNsYXYgUGV0a292
IDxicEBzdXNlLmRlPiB3cm90ZToKPiBPbiBXZWQsIEF1ZyAxMCwgMjAxNiBhdCAwNjo0MDo1M1BN
ICswODAwLCBGdSBXZWkgd3JvdGU6Cj4+IEJ1dCB0aGUgcmVhc29uIGZvciBhICBzZXBhcmF0ZSBo
ZXN0X2lhMzJfaW5pdCgpIGlzOgo+PiBGb3Igbm93KEFDUEkgNi4xKSwgd2UgaGF2ZSB0aHJlZSBJ
QS0zMiBBcmNoaXRlY3R1cmUtc3BlY2lmaWMgZXJyb3IKPj4gc291cmNlIHN0cnVjdHVyZXMsIG1h
eWJlIHdlIHdpbGwgcGFyc2UgdGhlbSBsYXRlci4KPj4gU28gSSBtYWRlIHRoaXMgaGVzdF9pYTMy
X2luaXQoKSBmb3IgYWxsIHRoZXNlIHN0cnVjdHVyZXMuIG1heWJlIHdlIGNhbiBkbyA6Cj4KPiBT
byBJJ2QgbWFrZSBpdCBhcyBzaW1wbGUgYXMgcG9zc2libGUgbm93IGFuZCBjcm9zcyB0aGF0IGJy
aWRnZSBvbmx5IHdoZW4KPiB3ZSBnZXQgdGhlcmUsIGkuZS4sIG9ubHkgd2hlbiB5b3UgYXJlIGFk
ZGluZyBzdXBwb3J0IGZvciB0aG9zZSBhbmQgbm90Cj4gZWFybGllci4KPgoKT0ssIGdvdCB5b3Vy
IHBvaW50LgpTb3JyeSBmb3Igc2VuZGluZyB2MTMgYmVmb3JlIGNoZWNraW5nIHRoaXMgd2l0aCB5
b3UuCgpzbyBJIHdpbGwgZG8gOgoKQEAgLTIzMiw4ICsyNDMsOSBAQCB2b2lkIF9faW5pdCBhY3Bp
X2hlc3RfaW5pdCh2b2lkKQogIGdvdG8gZXJyOwogIH0KCi0gaWYgKCFhY3BpX2Rpc2FibGVfY21j
ZmYpCi0gYXBlaV9oZXN0X3BhcnNlKGhlc3RfcGFyc2VfY21jLCBOVUxMKTsKKyByYyA9YXBlaV9o
ZXN0X3BhcnNlKGhlc3RfcGFyc2VfY21jLCBOVUxMKTsKKyBpZiAocmMpCisgZ290byBlcnI7Cgog
IGlmICghZ2hlc19kaXNhYmxlKSB7CiAgcmMgPSBhcGVpX2hlc3RfcGFyc2UoaGVzdF9wYXJzZV9n
aGVzX2NvdW50LCAmZ2hlc19jb3VudCk7CgpEbyB5b3UgaGF2ZSBvdGhlciBzdWdnZXN0aW9uPyB0
aGVuIEkgY2FuIHBvc3QgdjE0IHRvIGZpeCBpdCA6LSkKCj4gLS0KPiBSZWdhcmRzL0dydXNzLAo+
ICAgICBCb3Jpcy4KPgo+IEVDTyB0aXAgIzEwMTogVHJpbSB5b3VyIG1haWxzIHdoZW4geW91IHJl
cGx5Lgo+Cj4gU1VTRSBMaW51eCBHbWJILCBHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBKYW5lIFNt
aXRoYXJkLCBHcmFoYW0gTm9ydG9uLCBIUkIgMjEyODQgKEFHIE7DvHJuYmVyZykKPiAtLQoKCgot
LSAKQmVzdCByZWdhcmRzLAoKRnUgV2VpClNvZnR3YXJlIEVuZ2luZWVyClJlZCBIYXQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
