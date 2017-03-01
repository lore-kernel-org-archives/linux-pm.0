From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 01/10] x86: assembly, ENTRY for fn,
	GLOBAL for data
Date: Wed, 1 Mar 2017 10:38:56 +0100
Message-ID: <20170301093855.GA27152@gmail.com>
References: <20170217104757.28588-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <20170217104757.28588-1-jslaby@suse.cz>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, hpa@zytor.com, Andrew Morton <akpm@linux-foundation.org>, linux-pm@vger.kernel.org, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mingo@redhat.com, Pavel Machek <pavel@ucw.cz>, jpoimboe@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org

CiogSmlyaSBTbGFieSA8anNsYWJ5QHN1c2UuY3o+IHdyb3RlOgoKPiBUaGlzIGlzIGEgc3RhcnQg
b2Ygc2VyaWVzIHRvIHVuaWZ5IHVzZSBvZiBFTlRSWSwgRU5EUFJPQywgR0xPQkFMLCBFTkQsCj4g
YW5kIG90aGVyIG1hY3JvcyBhY3Jvc3MgeDg2LiBXaGVuIHdlIGhhdmUgYWxsIHRoaXMgc29ydGVk
IG91dCwgdGhpcyB3aWxsCj4gaGVscCB0byBpbmplY3QgRFdBUkYgdW53aW5kaW5nIGluZm8gYnkg
b2JqdG9vbCBsYXRlci4KPiAKPiBTbywgbGV0IHVzIHVzZSB0aGUgbWFjcm9zIHRoaXMgd2F5Ogo+
ICogRU5UUlkgLS0gc3RhcnQgb2YgYSBnbG9iYWwgZnVuY3Rpb24KPiAqIEVORFBST0MgLS0gZW5k
IG9mIGEgbG9jYWwvZ2xvYmFsIGZ1bmN0aW9uCj4gKiBHTE9CQUwgLS0gc3RhcnQgb2YgYSBnbG9i
YWxseSB2aXNpYmxlIGRhdGEgc3ltYm9sCj4gKiBFTkQgLS0gZW5kIG9mIGxvY2FsL2dsb2JhbCBk
YXRhIHN5bWJvbAoKU28gaG93IGFib3V0IHVzaW5nIG1hY3JvIG5hbWVzIHRoYXQgYWN0dWFsbHkg
c2hvdyB0aGUgcHVycG9zZSwgaW5zdGVhZCBvZiAKaW1wb3J0aW5nIGFsbCB0aGUgY3JhcHB5LCBo
aXN0b3JpYywgZXNzZW50aWFsbHkgcmFuZG9tbHkgY2hvc2VuIGRlYnVnIHN5bWJvbCBtYWNybyAK
bmFtZXMgZnJvbSB0aGUgYmludXRpbHMgYW5kIG9sZGVyIGtlcm5lbHM/CgpTb21ldGhpbmcgc2Fu
ZSwgbGlrZToKCglTWU1fX0ZVTkNUSU9OX1NUQVJUCglTWU1fX0ZVTkNUSU9OX0VORAoKCVNZTV9f
REFUQV9TVEFSVAoJU1lNX19EQVRBX0VORAoKLi4uIGFuZCBleHRlbmQgdGhhdCBtYWNybyBuYW1l
c3BhY2Ugd2l0aCBhbnkgb3RoZXIgdmFyaWFudHMgd2UgbWlnaHQgbmVlZC4KCldlIGNhbiBzdGls
bCBrZWVwIHRoZSBvbGQgbWFjcm8gbmFtZXMgKGZvciBhIHNob3J0IHdoaWxlKSB0byBlYXNlIHRo
ZSB0cmFuc2l0aW9uLCAKYnV0IGZvciBoZWF2ZW4ncyBzYWtlLCBpZiB3ZSBkbyAiY2xlYW51cHMi
IGJlZm9yZSBjb21wbGljYXRpbmcgdGhlIGNvZGUgbGV0J3MgbWFrZSAKc3VyZSB0aGUgcmVzdWx0
IGlzIGFjdHVhbGx5IHJlYWRhYmxlIQoKQWdyZWVkPwoKVGhhbmtzLAoKCUluZ28KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5n
IGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0cHM6Ly9saXN0cy54ZW4ub3JnL3hlbi1k
ZXZlbAo=
