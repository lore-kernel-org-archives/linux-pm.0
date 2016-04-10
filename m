From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [regression] cross core scheduling frequency drop bisected to
 0c313cb20732
Date: Sun, 10 Apr 2016 11:35:12 +0200
Message-ID: <1460280912.4251.27.camel@gmail.com>
References: <1460092854.4051.1.camel@gmail.com>
	 <20160408064510.GK3448@twins.programming.kicks-ass.net>
	 <1460098254.5582.17.camel@gmail.com> <2428384.mEkP3EOpsR@vostro.rjw.lan>
	 <1460184056.3765.160.camel@gmail.com>
	 <CAJZ5v0ig1qTTMw5GHO_-vuyETD46tin8bS2deyvtw0OvuDSCng@mail.gmail.com>
	 <1460214622.3714.8.camel@gmail.com> <1460219974.3700.39.camel@gmail.com>
	 <CAJZ5v0hDe=pNmWFC6fYADi=vP+WFN+7yvwOZvq_pRMARzUnoiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+mPqGqRbFkKsG8+AZvW8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hDe=pNmWFC6fYADi=vP+WFN+7yvwOZvq_pRMARzUnoiw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org


--=-+mPqGqRbFkKsG8+AZvW8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2016-04-10 at 05:44 +0200, Rafael J. Wysocki wrote:
> On Sat, Apr 9, 2016 at 6:39 PM, Mike Galbraith <
> umgwanakikbuti@gmail.com> wrote:
> > 
> > Hm, setting gov=performance, and taking the average of 3 30 second
> > interval PkgWatt samples as pipe-test runs..
> > 
> > 714KHz/28.03Ws = 25.46
> > 877KHz/30.28Ws = 28.96
> > 
> > ..for pipe-test, the tradeoff look a bit more like red than green.
> 
> Well, fair enough, but that's just pipe-test, and what about the
> people who don't see the performance gain and see the energy loss,
> like Doug?

Perhaps Doug sees increased power because he's not throttling no_hz,
whereas I am, so he burns more power getting _to_ idle?  Dunno, maybe
he'll try the attached.  If it's a general case energy loser, so be it,
numbers talk, bs walks and all that ;-)

> Essentially, this trades performance gains in somewhat special
> workloads for increased energy consumption in idle.  Those workloads
> need not be run by everybody, but idle is.

Cross core scheduling is routine business, we do truckloads of that for
good reason, and lots of stuff does wakeups at high frequency.

> That said I applied the patch you're complaining about mostly because
> the commit that introduced the change in question in 4.5 claimed that
> it wouldn't affect idle power on systems with reasonably fast C1, but
> that didn't pass the reality test.  I'm not totally against restoring
> that change, but it would need to be based on very solid evidence.

Understood.  My box seems to be saying we can hug the trees hardest by
telling the CPU get work done as quickly as possible, but I don't have
much experience at tree hugging measurement.  Performance wise, tasks
talking via localhost is definitely not special.

tbench     1      2      4     8
base     752   1283   2250  3362

select_idle_sibling() off
         735   1344   2080  2884
delta   .977  1.047   .924  .857

select_idle_sibling() on, 0c313cb20732 reverted
         816   1317   2240  3388
delta  1.085  1.026   .995 1.007 vs base
delta  1.110   .979  1.076 1.174 vs off
               (^hm)

	-Mike
--=-+mPqGqRbFkKsG8+AZvW8
Content-Disposition: attachment; filename="sched-throttle-nohz.patch"
Content-Type: text/x-patch; name="sched-throttle-nohz.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

c2NoZWQ6IHJhdGVsaW1pdCBub2h6CgpFbnRlcmluZyBub2h6IGNvZGUgb24gZXZlcnkgbWljcm8t
aWRsZSBpcyB0b28gZXhwZW5zaXZlIHRvIGJlYXIuCgpTaWduZWQtb2ZmLWJ5OiBNaWtlIEdhbGJy
YWl0aCA8ZWZhdWx0QGdteC5kZT4KLS0tCiBpbmNsdWRlL2xpbnV4L3NjaGVkLmggICAgfCAgICA1
ICsrKysrCiBrZXJuZWwvc2NoZWQvY29yZS5jICAgICAgfCAgICA4ICsrKysrKysrCiBrZXJuZWwv
dGltZS90aWNrLXNjaGVkLmMgfCAgICAyICstCiAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCi0tLSBhL2luY2x1ZGUvbGludXgvc2NoZWQuaAorKysgYi9p
bmNsdWRlL2xpbnV4L3NjaGVkLmgKQEAgLTIyODYsNiArMjI4NiwxMSBAQCBzdGF0aWMgaW5saW5l
IGludCBzZXRfY3B1c19hbGxvd2VkX3B0cihzCiAjaWZkZWYgQ09ORklHX05PX0haX0NPTU1PTgog
dm9pZCBjYWxjX2xvYWRfZW50ZXJfaWRsZSh2b2lkKTsKIHZvaWQgY2FsY19sb2FkX2V4aXRfaWRs
ZSh2b2lkKTsKKyNpZmRlZiBDT05GSUdfU01QCitleHRlcm4gaW50IHNjaGVkX25lZWRzX2NwdShp
bnQgY3B1KTsKKyNlbHNlCitzdGF0aWMgaW5saW5lIGludCBzY2hlZF9uZWVkc19jcHUoaW50IGNw
dSkgeyByZXR1cm4gMDsgfQorI2VuZGlmCiAjZWxzZQogc3RhdGljIGlubGluZSB2b2lkIGNhbGNf
bG9hZF9lbnRlcl9pZGxlKHZvaWQpIHsgfQogc3RhdGljIGlubGluZSB2b2lkIGNhbGNfbG9hZF9l
eGl0X2lkbGUodm9pZCkgeyB9Ci0tLSBhL2tlcm5lbC9zY2hlZC9jb3JlLmMKKysrIGIva2VybmVs
L3NjaGVkL2NvcmUuYwpAQCAtNTc3LDYgKzU3NywxNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgZ290
X25vaHpfaWRsZV9raWNrKHZvCiAJcmV0dXJuIGZhbHNlOwogfQogCitpbnQgc2NoZWRfbmVlZHNf
Y3B1KGludCBjcHUpCit7CisJaWYgKHRpY2tfbm9oel9mdWxsX2NwdShjcHUpKQorCQlyZXR1cm4g
MDsKKworCXJldHVybiAgY3B1X3JxKGNwdSktPmF2Z19pZGxlIDwgc3lzY3RsX3NjaGVkX21pZ3Jh
dGlvbl9jb3N0OworfQorCiAjZWxzZSAvKiBDT05GSUdfTk9fSFpfQ09NTU9OICovCiAKIHN0YXRp
YyBpbmxpbmUgYm9vbCBnb3Rfbm9oel9pZGxlX2tpY2sodm9pZCkKLS0tIGEva2VybmVsL3RpbWUv
dGljay1zY2hlZC5jCisrKyBiL2tlcm5lbC90aW1lL3RpY2stc2NoZWQuYwpAQCAtNjc2LDcgKzY3
Niw3IEBAIHN0YXRpYyBrdGltZV90IHRpY2tfbm9oel9zdG9wX3NjaGVkX3RpY2sKIAl9IHdoaWxl
IChyZWFkX3NlcXJldHJ5KCZqaWZmaWVzX2xvY2ssIHNlcSkpOwogCXRzLT5sYXN0X2ppZmZpZXMg
PSBiYXNlamlmZjsKIAotCWlmIChyY3VfbmVlZHNfY3B1KGJhc2Vtb25vLCAmbmV4dF9yY3UpIHx8
CisJaWYgKHNjaGVkX25lZWRzX2NwdShjcHUpIHx8IHJjdV9uZWVkc19jcHUoYmFzZW1vbm8sICZu
ZXh0X3JjdSkgfHwKIAkgICAgYXJjaF9uZWVkc19jcHUoKSB8fCBpcnFfd29ya19uZWVkc19jcHUo
KSkgewogCQluZXh0X3RpY2sgPSBiYXNlbW9ubyArIFRJQ0tfTlNFQzsKIAl9IGVsc2Ugewo=


--=-+mPqGqRbFkKsG8+AZvW8--
