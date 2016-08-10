From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v12] acpi, apei, arm64: APEI initial support for aarch64.
Date: Wed, 10 Aug 2016 13:10:05 +0200
Message-ID: <20160810111005.GD16664@nazgul.tnic>
References: <1469782664-12611-1-git-send-email-fu.wei@linaro.org>
 <20160804094838.GB8093@nazgul.tnic>
 <CADyBb7ujfaXPP_CUB66_E53fY9MeEbt6EhOaCzf+hoDCGYD+dw@mail.gmail.com>
 <20160810104513.GB16664@nazgul.tnic>
 <CADyBb7uW2-jh8UBLXZ03p1y9SMP7M3z6eULwV2DYhWXEqTm2Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CADyBb7uW2-jh8UBLXZ03p1y9SMP7M3z6eULwV2DYhWXEqTm2Rw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fu Wei <fu.wei@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, pavel@ucw.cz, hpa@zytor.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, mingo@redhat.com, len.brown@intel.com, linux-pm@vger.kernel.org, Marc Zyngier <Marc.Zyngier@arm.com>, Jon Masters <jcm@redhat.com>, matt.fleming@intel.com, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Jonathan Zhang <jon.zhixiong.zhang@gmail.com>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCBBdWcgMTAsIDIwMTYgYXQgMDc6MDE6MDVQTSArMDgwMCwgRnUgV2VpIHdyb3RlOgo+
IC0gaWYgKCFhY3BpX2Rpc2FibGVfY21jZmYpCj4gLSBhcGVpX2hlc3RfcGFyc2UoaGVzdF9wYXJz
ZV9jbWMsIE5VTEwpOwo+ICsgcmMgPWFwZWlfaGVzdF9wYXJzZShoZXN0X3BhcnNlX2NtYywgTlVM
TCk7Cj4gKyBpZiAocmMpCj4gKyBnb3RvIGVycjsKPiAKPiAgIGlmICghZ2hlc19kaXNhYmxlKSB7
Cj4gICByYyA9IGFwZWlfaGVzdF9wYXJzZShoZXN0X3BhcnNlX2doZXNfY291bnQsICZnaGVzX2Nv
dW50KTsKPiAKPiBEbyB5b3UgaGF2ZSBvdGhlciBzdWdnZXN0aW9uPyB0aGVuIEkgY2FuIHBvc3Qg
djE0IHRvIGZpeCBpdCA6LSkKCk5haCwgbG9va3MgZ29vZCA6KQoKTGV0J3Mga2VlcCBpdCBzaW1w
bGUgYW5kIGFkZCBtb3JlIGludm9sdmVkIGhhbmRsaW5nIHdoZW4gaXQgaXMgcmVhbGx5Cm5lZWRl
ZC4gVGhhbmtzIQoKQnR3LCB0aGF0IGNvbW1lbnQ6CgorLyoKKyAqIGFjcGlfZGlzYWJsZV9jbWNm
ZiBpcyB1c2VkIGluIGRyaXZlcnMvYWNwaS9hcGVpL2hlc3QuYyBmb3IgZGlzYWJsaW5nCisgKiBJ
QS0zMiBBcmNoaXRlY3R1cmUgQ29ycmVjdGVkIE1hY2hpbmUgQ2hlY2t4KGNtYykgRklSTVdBUkVf
RklSU1QgbW9kZSBieQorICogYm9vdCBwYXJhbWV0ZXIoYWNwaT1ub2NtY2ZmKS4gQnV0IHdlIGRv
bid0IGhhdmUgdGhpcyBJQS0zMiBzcGVjaWZpYworICogZmVhdHVyZSBvbiBBUk02NCwgdGhpcyBk
ZWZpbml0aW9uIGlzIG9ubHkgZm9yIGNvbXBhdGliaWxpdHkuCisgKi8KKyNkZWZpbmUgYWNwaV9k
aXNhYmxlX2NtY2ZmIDEKCmxvb2tzIG9rLCBleGNlcHQgdGhlIHNtYWxsIHR5cG86CgpBcmNoaXRl
Y3R1cmUgQ29ycmVjdGVkIE1hY2hpbmUgQ2hlY2t4KGNtYykKCQkJCSAgICBeCk1ha2UgdGhhdAoK
IklBLTMyIEFyY2hpdGVjdHVyZSBDb3JyZWN0ZWQgTWFjaGluZSBDaGVjayAoQ01DKSBGaXJtd2Fy
ZS1GaXJzdCBtb2RlIgoKVGhhbmtzLgoKLS0gClJlZ2FyZHMvR3J1c3MsCiAgICBCb3Jpcy4KCkVD
TyB0aXAgIzEwMTogVHJpbSB5b3VyIG1haWxzIHdoZW4geW91IHJlcGx5LgoKU1VTRSBMaW51eCBH
bWJILCBHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBKYW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9u
LCBIUkIgMjEyODQgKEFHIE7DvHJuYmVyZykKLS0KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
