From: hpa@zytor.com
Subject: Re: [PATCH 01/10] x86: assembly, ENTRY for fn,
	GLOBAL for data
Date: Fri, 03 Mar 2017 10:20:11 -0800
Message-ID: <F37D3EC6-277C-4034-BB6A-B31695ADB358@zytor.com>
References: <20170217104757.28588-1-jslaby@suse.cz>
 <20170301093855.GA27152@gmail.com> <alpine.DEB.2.20.1703011108220.4005@nanos>
 <20170301102754.GA13374@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20170301102754.GA13374@gmail.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-pm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mingo@redhat.com, Pavel Machek <pavel@ucw.cz>, jpoimboe@redhat.com, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

T24gTWFyY2ggMSwgMjAxNyAyOjI3OjU0IEFNIFBTVCwgSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5l
bC5vcmc+IHdyb3RlOgo+Cj4qIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiB3
cm90ZToKPgo+PiBPbiBXZWQsIDEgTWFyIDIwMTcsIEluZ28gTW9sbmFyIHdyb3RlOgo+PiA+IAo+
PiA+ICogSmlyaSBTbGFieSA8anNsYWJ5QHN1c2UuY3o+IHdyb3RlOgo+PiA+IAo+PiA+ID4gVGhp
cyBpcyBhIHN0YXJ0IG9mIHNlcmllcyB0byB1bmlmeSB1c2Ugb2YgRU5UUlksIEVORFBST0MsIEdM
T0JBTCwKPkVORCwKPj4gPiA+IGFuZCBvdGhlciBtYWNyb3MgYWNyb3NzIHg4Ni4gV2hlbiB3ZSBo
YXZlIGFsbCB0aGlzIHNvcnRlZCBvdXQsCj50aGlzIHdpbGwKPj4gPiA+IGhlbHAgdG8gaW5qZWN0
IERXQVJGIHVud2luZGluZyBpbmZvIGJ5IG9ianRvb2wgbGF0ZXIuCj4+ID4gPiAKPj4gPiA+IFNv
LCBsZXQgdXMgdXNlIHRoZSBtYWNyb3MgdGhpcyB3YXk6Cj4+ID4gPiAqIEVOVFJZIC0tIHN0YXJ0
IG9mIGEgZ2xvYmFsIGZ1bmN0aW9uCj4+ID4gPiAqIEVORFBST0MgLS0gZW5kIG9mIGEgbG9jYWwv
Z2xvYmFsIGZ1bmN0aW9uCj4+ID4gPiAqIEdMT0JBTCAtLSBzdGFydCBvZiBhIGdsb2JhbGx5IHZp
c2libGUgZGF0YSBzeW1ib2wKPj4gPiA+ICogRU5EIC0tIGVuZCBvZiBsb2NhbC9nbG9iYWwgZGF0
YSBzeW1ib2wKPj4gPiAKPj4gPiBTbyBob3cgYWJvdXQgdXNpbmcgbWFjcm8gbmFtZXMgdGhhdCBh
Y3R1YWxseSBzaG93IHRoZSBwdXJwb3NlLAo+aW5zdGVhZCBvZiAKPj4gPiBpbXBvcnRpbmcgYWxs
IHRoZSBjcmFwcHksIGhpc3RvcmljLCBlc3NlbnRpYWxseSByYW5kb21seSBjaG9zZW4KPmRlYnVn
IHN5bWJvbCBtYWNybyAKPj4gPiBuYW1lcyBmcm9tIHRoZSBiaW51dGlscyBhbmQgb2xkZXIga2Vy
bmVscz8KPj4gPiAKPj4gPiBTb21ldGhpbmcgc2FuZSwgbGlrZToKPj4gPiAKPj4gPiAJU1lNX19G
VU5DVElPTl9TVEFSVAo+PiAKPj4gU2FuZSB3b3VsZCBiZToKPj4gCj4+ICAgICAgCVNZTV9GVU5D
VElPTl9TVEFSVAo+PiAKPj4gVGhlIGRvdWJsZSB1bmRlcnNjb3JlIGlzIGp1c3Qgbm90IGdpdmlu
ZyBhbnkgdmFsdWUuCj4KPlNvIHRoZSBkb3VibGUgdW5kZXJzY29yZSAoYXQgbGVhc3QgaW4gbXkg
dmlldykgaGFzIHR3byBhZHZhbnRhZ2VzOgo+Cj4xKSBpdCBoZWxwcyBzZXBhcmF0ZSB0aGUgcHJl
Zml4IGZyb20gdGhlIHBvc3RmaXguCj4KPkkuZS4gaXQncyBhICdzeW1ib2xzJyBuYW1lc3BhY2Us
IGFuZCBhICdmdW5jdGlvbiBzdGFydCcsIG5vdCB0aGUKPidzdGFydCcgb2YgYSAKPidzeW1ib2wg
ZnVuY3Rpb24nLgo+Cj4yKSBJdCBhbHNvIGhlbHBzIGVhc3kgZ3JlcHBhYmlsaXR5Lgo+Cj5Ucnkg
dGhpcyBpbiBsYXRlc3QgLXRpcDoKPgo+ICBnaXQgZ3JlcCBlODIwX18KPgo+VG8gc2VlIGFsbCB0
aGUgRTgyMCBBUEkgY2FsbHMgLSB3aXRoIG5vIGZhbHNlIHBvc2l0aXZlcyEKPgo+J2dpdCBncmVw
IGU4MjBfJyBvbiB0aGUgb3RoZXIgaGFuZCBpcyBhIGxvdCBsZXNzIHJlbGlhYmxlLi4uCj4KPkJ1
dCBubyBzdHJvbmcgZmVlbGluZ3MgZWl0aGVyIHdheSwgSSBqdXN0IHRyeSB0byBzbmVhayBpbiB0
aGVzZSBzbWFsbAo+bmFtZXNwYWNlIAo+c3RydWN0dXJlIHRyaWNrcyB3aGVuIG5vYm9keSdzIGxv
b2tpbmchIDstKQo+Cj5UaGFua3MsCj4KPglJbmdvCgpUaGlzIHNlZW1zIG5lZWRsZXNzbHkgdmVy
Ym9zZSB0byBtZSBhbmQgY2x1dHRlcnMgdGhlIGNvZGUuCgpIb3cgYWJvdXQ6CgpQUk9DLi5FTkRQ
Uk9DLCBMT0NBTFBST0MuLkVORFBST0MgYW5kIERBVEEuLkVORERBVEEuICBDbGVhciwgdW5hbWJp
Z3VvdXMgYW5kIGJhbGFuY2VkLgoKCi0tIApTZW50IGZyb20gbXkgQW5kcm9pZCBkZXZpY2Ugd2l0
aCBLLTkgTWFpbC4gUGxlYXNlIGV4Y3VzZSBteSBicmV2aXR5LgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4t
ZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhlbi5vcmcveGVuLWRldmVsCg==
