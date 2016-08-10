From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v12] acpi, apei, arm64: APEI initial support for aarch64.
Date: Wed, 10 Aug 2016 12:45:13 +0200
Message-ID: <20160810104513.GB16664@nazgul.tnic>
References: <1469782664-12611-1-git-send-email-fu.wei@linaro.org>
 <20160804094838.GB8093@nazgul.tnic>
 <CADyBb7ujfaXPP_CUB66_E53fY9MeEbt6EhOaCzf+hoDCGYD+dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CADyBb7ujfaXPP_CUB66_E53fY9MeEbt6EhOaCzf+hoDCGYD+dw@mail.gmail.com>
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

T24gV2VkLCBBdWcgMTAsIDIwMTYgYXQgMDY6NDA6NTNQTSArMDgwMCwgRnUgV2VpIHdyb3RlOgo+
IEJ1dCB0aGUgcmVhc29uIGZvciBhICBzZXBhcmF0ZSBoZXN0X2lhMzJfaW5pdCgpIGlzOgo+IEZv
ciBub3coQUNQSSA2LjEpLCB3ZSBoYXZlIHRocmVlIElBLTMyIEFyY2hpdGVjdHVyZS1zcGVjaWZp
YyBlcnJvcgo+IHNvdXJjZSBzdHJ1Y3R1cmVzLCBtYXliZSB3ZSB3aWxsIHBhcnNlIHRoZW0gbGF0
ZXIuCj4gU28gSSBtYWRlIHRoaXMgaGVzdF9pYTMyX2luaXQoKSBmb3IgYWxsIHRoZXNlIHN0cnVj
dHVyZXMuIG1heWJlIHdlIGNhbiBkbyA6CgpTbyBJJ2QgbWFrZSBpdCBhcyBzaW1wbGUgYXMgcG9z
c2libGUgbm93IGFuZCBjcm9zcyB0aGF0IGJyaWRnZSBvbmx5IHdoZW4Kd2UgZ2V0IHRoZXJlLCBp
LmUuLCBvbmx5IHdoZW4geW91IGFyZSBhZGRpbmcgc3VwcG9ydCBmb3IgdGhvc2UgYW5kIG5vdApl
YXJsaWVyLgoKLS0gClJlZ2FyZHMvR3J1c3MsCiAgICBCb3Jpcy4KCkVDTyB0aXAgIzEwMTogVHJp
bSB5b3VyIG1haWxzIHdoZW4geW91IHJlcGx5LgoKU1VTRSBMaW51eCBHbWJILCBHRjogRmVsaXgg
SW1lbmTDtnJmZmVyLCBKYW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9uLCBIUkIgMjEyODQgKEFH
IE7DvHJuYmVyZykKLS0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
