From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC] linkage: new macros for functions and data
Date: Thu, 16 Mar 2017 09:02:57 +0100
Message-ID: <20170316080257.GA7815@gmail.com>
References: <20170307082750.GA1695@gmail.com>
 <20170307172404.27374-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <20170307172404.27374-1-jslaby@suse.cz>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, x86@kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-pm@vger.kernel.org, hpa@zytor.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, jpoimboe@redhat.com, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

CiogSmlyaSBTbGFieSA8anNsYWJ5QHN1c2UuY3o+IHdyb3RlOgoKPiBTWU1fTE9DQUxfQUxJQVNf
U1RBUlQgLS0gdXNlIHdoZXJlIHRoZXJlIGFyZSB0d28gbG9jYWwgbmFtZXMgZm9yIG9uZSBjb2Rl
Cj4gU1lNX0FMSUFTX1NUQVJUIC0tIHVzZSB3aGVyZSB0aGVyZSBhcmUgdHdvIGdsb2JhbCBuYW1l
cyBmb3Igb25lIGNvZGUKPiBTWU1fTE9DQUxfRlVOQ19TVEFSVCAtLSB1c2UgZm9yIGxvY2FsIGZ1
bmN0aW9ucwo+IFNZTV9GVU5DVElPTl9TVEFSVCAtLSB1c2UgZm9yIGdsb2JhbCBmdW5jdGlvbnMK
PiBTWU1fV0VBS19GVU5DX1NUQVJUIC0tIHVzZSBmb3Igd2VhayBmdW5jdGlvbnMKPiBTWU1fQUxJ
QVNfRU5EIC0tIHRoZSBlbmQgb2YgTE9DQUxBTElBU2VkIG9yIEFMSUFTZWQgY29kZQo+IFNZTV9G
VU5DVElPTl9FTkQgLS0gdGhlIGVuZCBvZiBTWU1fTE9DQUxfRlVOQ19TVEFSVCwgU1lNX0ZVTkNU
SU9OX1NUQVJULCBTWU1fV0VBS19GVU5DX1NUQVJULCAuLi4KPiBTWU1fREFUQV9TVEFSVCAtLSBn
bG9iYWwgZGF0YSBzeW1ib2wKPiBTWU1fREFUQV9FTkQgLS0gdGhlIGVuZCBvZiBTWU1fREFUQV9T
VEFSVCBzeW1ib2wKClRoaXMgbG9va3MgbW9zdGx5IGdvb2QgdG8gbWUsIHdpdGggbWlub3IgZGV0
YWlsczoKCi0gVGhlIG1peGVkICdGVU5DJyBhbmQgJ0ZVTkNUSU9OJyBuYW1pbmcgbG9va3MgYSBi
aXQgY29uZnVzaW5nIC0gSSdkIHBpY2sgb25lIGFuZAogIHVzZSB0aGF0IGNvbnNpc3RlbnRseS4K
Ci0gSSdkIGFsc28gbWFrZSB0aGUgU1RBUlQvRU5EIGNvbnN0cnVjdHMgbG9vayBtb3JlIHN5bW1l
dHJpYywgaS5lLiBtYWtlIHRoZSAKICBhdHRyaWJ1dGUgYSBwb3N0Zml4LCBub3QgYSBwcmVmaXgu
CgotIEluIGZhY3QgSSdkIG1ha2UgdGhlICdhbGlhcycgbm90aW9uIGFuIGF0dHJpYnV0ZSBhcyB3
ZWxsIC0gd2hhdCBtYXR0ZXJzIG1vc3RseSAKICBpcyB0aGF0IGl0J3MgYSBmdW5jdGlvbiBzeW1i
b2wsIGFuZCB0aGF0IGZhY3QgaXMgbG9zdCBmcm9tIHRoZSBTWU1fQUxJQVMgbmFtaW5nLgoKSS5l
LiBzb21ldGhpbmcgbGlrZSB0aGlzOgoKCVNZTV9GVU5DVElPTl9TVEFSVAoJU1lNX0ZVTkNUSU9O
X1NUQVJUX1dFQUsKCVNZTV9GVU5DVElPTl9TVEFSVF9MT0NBTAoJU1lNX0ZVTkNUSU9OX1NUQVJU
X0FMSUFTCglTWU1fRlVOQ1RJT05fU1RBUlRfTE9DQUxfQUxJQVMKCS4uLgoJU1lNX0ZVTkNUSU9O
X0VORAoKCVNZTV9EQVRBX1NUQVJUCglTWU1fREFUQV9FTkQKCk5vdGUgaG93IHNpbXBsZSBhbmQg
c3RydWN0dXJlZCBsb29raW5nIHRoZSBub21lbmNsYXR1cmUgaXMgd2hlbiBncm91cGVkIGluIHN1
Y2ggYSAKd2F5LCBob3cgZWFzeSBpdCBpcyB0byB2ZXJpZnkgYXQgYSBnbGFuY2UsIGFuZCBob3cg
ZWFzeSBpdCBpcyB0byBleHRlbmQgd2l0aCBuZXcgCnBvc3RmaXhlcy4KCiggSW4gdGhlb3J5IHdl
IGNvdWxkIGFsc28gbWFrZSB0aGUgYXR0cmlidXRlcyBhIHJlYWwgbWFjcm8gYXJndW1lbnQgaW4g
dGhlIGZ1dHVyZSwKICBzaG91bGQgdGhlIG51bWJlciBvZiBhdHRyaWJ1dGVzIGluY3JlYXNlIHNp
Z25pZmljYW50bHkuICkKCkRvZXMgdGhpcyBsb29rIGdvb2QgdG8gZXZlcnlvbmU/CgpUaGFua3Ms
CgoJSW5nbwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
WGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xp
c3RzLnhlbi5vcmcveGVuLWRldmVsCg==
