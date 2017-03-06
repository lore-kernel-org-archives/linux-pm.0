From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 01/10] x86: assembly, ENTRY for fn,
	GLOBAL for data
Date: Mon, 6 Mar 2017 15:09:28 +0100
Message-ID: <0e06bb66-9f48-a925-730b-cf71dd541a3b@suse.cz>
References: <20170217104757.28588-1-jslaby@suse.cz>
 <20170301093855.GA27152@gmail.com> <alpine.DEB.2.20.1703011108220.4005@nanos>
 <20170301102754.GA13374@gmail.com>
 <F37D3EC6-277C-4034-BB6A-B31695ADB358@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <F37D3EC6-277C-4034-BB6A-B31695ADB358@zytor.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: hpa@zytor.com, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-pm@vger.kernel.org, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mingo@redhat.com, Pavel Machek <pavel@ucw.cz>, jpoimboe@redhat.com, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

T24gMDMvMDMvMjAxNywgMDc6MjAgUE0sIGhwYUB6eXRvci5jb20gd3JvdGU6Cj4gT24gTWFyY2gg
MSwgMjAxNyAyOjI3OjU0IEFNIFBTVCwgSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+IHdy
b3RlOgo+Pgo+PiAqIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiB3cm90ZToK
Pj4KPj4+IE9uIFdlZCwgMSBNYXIgMjAxNywgSW5nbyBNb2xuYXIgd3JvdGU6Cj4+Pj4KPj4+PiAq
IEppcmkgU2xhYnkgPGpzbGFieUBzdXNlLmN6PiB3cm90ZToKPj4+Pgo+Pj4+PiBUaGlzIGlzIGEg
c3RhcnQgb2Ygc2VyaWVzIHRvIHVuaWZ5IHVzZSBvZiBFTlRSWSwgRU5EUFJPQywgR0xPQkFMLAo+
PiBFTkQsCj4+Pj4+IGFuZCBvdGhlciBtYWNyb3MgYWNyb3NzIHg4Ni4gV2hlbiB3ZSBoYXZlIGFs
bCB0aGlzIHNvcnRlZCBvdXQsCj4+IHRoaXMgd2lsbAo+Pj4+PiBoZWxwIHRvIGluamVjdCBEV0FS
RiB1bndpbmRpbmcgaW5mbyBieSBvYmp0b29sIGxhdGVyLgo+Pj4+Pgo+Pj4+PiBTbywgbGV0IHVz
IHVzZSB0aGUgbWFjcm9zIHRoaXMgd2F5Ogo+Pj4+PiAqIEVOVFJZIC0tIHN0YXJ0IG9mIGEgZ2xv
YmFsIGZ1bmN0aW9uCj4+Pj4+ICogRU5EUFJPQyAtLSBlbmQgb2YgYSBsb2NhbC9nbG9iYWwgZnVu
Y3Rpb24KPj4+Pj4gKiBHTE9CQUwgLS0gc3RhcnQgb2YgYSBnbG9iYWxseSB2aXNpYmxlIGRhdGEg
c3ltYm9sCj4+Pj4+ICogRU5EIC0tIGVuZCBvZiBsb2NhbC9nbG9iYWwgZGF0YSBzeW1ib2wKPj4+
Pgo+Pj4+IFNvIGhvdyBhYm91dCB1c2luZyBtYWNybyBuYW1lcyB0aGF0IGFjdHVhbGx5IHNob3cg
dGhlIHB1cnBvc2UsCj4+IGluc3RlYWQgb2YgCj4+Pj4gaW1wb3J0aW5nIGFsbCB0aGUgY3JhcHB5
LCBoaXN0b3JpYywgZXNzZW50aWFsbHkgcmFuZG9tbHkgY2hvc2VuCj4+IGRlYnVnIHN5bWJvbCBt
YWNybyAKPj4+PiBuYW1lcyBmcm9tIHRoZSBiaW51dGlscyBhbmQgb2xkZXIga2VybmVscz8KPj4+
Pgo+Pj4+IFNvbWV0aGluZyBzYW5lLCBsaWtlOgo+Pj4+Cj4+Pj4gCVNZTV9fRlVOQ1RJT05fU1RB
UlQKPj4+Cj4+PiBTYW5lIHdvdWxkIGJlOgo+Pj4KPj4+ICAgICAgCVNZTV9GVU5DVElPTl9TVEFS
VAo+Pj4KPj4+IFRoZSBkb3VibGUgdW5kZXJzY29yZSBpcyBqdXN0IG5vdCBnaXZpbmcgYW55IHZh
bHVlLgo+Pgo+PiBTbyB0aGUgZG91YmxlIHVuZGVyc2NvcmUgKGF0IGxlYXN0IGluIG15IHZpZXcp
IGhhcyB0d28gYWR2YW50YWdlczoKPj4KPj4gMSkgaXQgaGVscHMgc2VwYXJhdGUgdGhlIHByZWZp
eCBmcm9tIHRoZSBwb3N0Zml4Lgo+Pgo+PiBJLmUuIGl0J3MgYSAnc3ltYm9scycgbmFtZXNwYWNl
LCBhbmQgYSAnZnVuY3Rpb24gc3RhcnQnLCBub3QgdGhlCj4+ICdzdGFydCcgb2YgYSAKPj4gJ3N5
bWJvbCBmdW5jdGlvbicuCj4+Cj4+IDIpIEl0IGFsc28gaGVscHMgZWFzeSBncmVwcGFiaWxpdHku
Cj4+Cj4+IFRyeSB0aGlzIGluIGxhdGVzdCAtdGlwOgo+Pgo+PiAgZ2l0IGdyZXAgZTgyMF9fCj4+
Cj4+IFRvIHNlZSBhbGwgdGhlIEU4MjAgQVBJIGNhbGxzIC0gd2l0aCBubyBmYWxzZSBwb3NpdGl2
ZXMhCj4+Cj4+ICdnaXQgZ3JlcCBlODIwXycgb24gdGhlIG90aGVyIGhhbmQgaXMgYSBsb3QgbGVz
cyByZWxpYWJsZS4uLgo+Pgo+PiBCdXQgbm8gc3Ryb25nIGZlZWxpbmdzIGVpdGhlciB3YXksIEkg
anVzdCB0cnkgdG8gc25lYWsgaW4gdGhlc2Ugc21hbGwKPj4gbmFtZXNwYWNlIAo+PiBzdHJ1Y3R1
cmUgdHJpY2tzIHdoZW4gbm9ib2R5J3MgbG9va2luZyEgOy0pCj4+Cj4+IFRoYW5rcywKPj4KPj4g
CUluZ28KPiAKPiBUaGlzIHNlZW1zIG5lZWRsZXNzbHkgdmVyYm9zZSB0byBtZSBhbmQgY2x1dHRl
cnMgdGhlIGNvZGUuCj4gCj4gSG93IGFib3V0Ogo+IAo+IFBST0MuLkVORFBST0MsIExPQ0FMUFJP
Qy4uRU5EUFJPQyBhbmQgREFUQS4uRU5EREFUQS4gIENsZWFyLCB1bmFtYmlndW91cyBhbmQgYmFs
YW5jZWQuCgpJIHRyaWVkIHRoaXMsIGJ1dDoKYXJjaC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5l
bF82NC5TOjI3OjA6IHdhcm5pbmc6ICJEQVRBIiByZWRlZmluZWQKICNkZWZpbmUgREFUQShvZmZz
ZXQpICAoS0VYRUNfQ09OVFJPTF9DT0RFX01BWF9TSVpFKyhvZmZzZXQpKQoKCkkgYW0gbm90IHNh
eWluZyB0aGF0IEkgY2Fubm90IGZpeCBpdCB1cC4gSSBqdXN0IHdhbnQgdG8gc2F5LCB0aGF0IHRo
ZXNlCm5hbWVzIG1pZ2h0IGJlIHRvbyBnZW5lcmljLCBlc3BlY2lhbGx5ICJQUk9DIiBhbmQgIkRB
VEEiLiBTbyBzaG91bGQgSQpyZWFsbHkgc3RpY2sgdG8gdGhlc2U/Cgp0aGFua3MsCi0tIApqcwpz
dXNlIGxhYnMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Clhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0cHM6Ly9s
aXN0cy54ZW4ub3JnL3hlbi1kZXZlbAo=
