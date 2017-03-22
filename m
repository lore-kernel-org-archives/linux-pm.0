From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v2 03/10] x86: assembly,
	use SYM_FUNC_END for functions
Date: Wed, 22 Mar 2017 16:44:52 +0100
Message-ID: <e4f7197c-559e-0dc2-c4e4-e369bf503cbb@suse.cz>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-3-jslaby@suse.cz>
 <20170322142610.bo5c6wzlbqnxrgt3@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20170322142610.bo5c6wzlbqnxrgt3@treble>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, linux-pm@vger.kernel.org, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mingo@redhat.com, Pavel Machek <pavel@ucw.cz>, hpa@zytor.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-pm@vger.kernel.org

T24gMDMvMjIvMjAxNywgMDM6MjYgUE0sIEpvc2ggUG9pbWJvZXVmIHdyb3RlOgo+IE9uIE1vbiwg
TWFyIDIwLCAyMDE3IGF0IDAxOjMyOjE1UE0gKzAxMDAsIEppcmkgU2xhYnkgd3JvdGU6Cj4+IFNv
bWV3aGVyZSBFTkQgd2FzIHVzZWQgdG8gZW5kIGEgZnVuY3Rpb24sIGVsc2V3aGVyZSwgbm90aGlu
ZyB3YXMgdXNlZC4KPj4gU28gdW5pZnkgaXQgYW5kIG1hcmsgdGhlbSBhbGwgYnkgU1lNX0ZVTkNf
RU5ELgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKaXJpIFNsYWJ5IDxqc2xhYnlAc3VzZS5jej4KPiAK
PiBGb3IgbWUgdGhlc2UgcGF0Y2hlcyB3b3VsZCBiZSBlYXNpZXIgdG8gcmV2aWV3IGlmIHRoZSBT
WU1fRlVOQ19TVEFSVCBhbmQKPiBTWU1fRlVOQ19FTkQgcGFpcnMgZm9yIGEgZ2l2ZW4gZnVuY3Rp
b24gYXJlIGRvbmUgaW4gdGhlIHNhbWUgcGF0Y2guCgpUaGlzIHBhdGNoc2V0IHdhcyBpbnRlbmRl
ZCB0byBtYWtlIGV2ZXJ5dGhpbmcgcGFpcmVkIHdpdGggbWluaW11bQpjaGFuZ2VzLiBJIGNlcnRh
aW5seSBjYW4gY2hhbmdlIGFsc28gY291bnRlci1lbGVtZW50cyBvZiBlYWNoCmFkZGVkL2NoYW5n
ZWQgb25lIGlmIHlvdSBwcmVmZXIuCgo+IEFsc28gSSBub3RpY2VkIHNldmVyYWwgY2FzZXMgaW4g
ZW50cnlfNjQuUyB3aGVyZSB0aGUgb2xkIEVOVFJZIG1hY3JvIGlzCj4gc3RpbGwgdXNlZCwgYW5k
IHBhaXJlZCB3aXRoIFNZTV9GVU5DX0VORC4KPiAKPiBNYXliZSB0aGVyZSBzaG91bGQgYmUgYW4g
eDg2IHZlcnNpb24gb2YgdGhlIGRlcHJlY2F0ZWQgRU5UUlkvRU5EUFJPQy9ldGMKPiBtYWNyb3Mg
d2hpY2ggdGhyb3cgYSB3YXJuaW5nIG9yIGFuIGVycm9yPwoKWWVzLCBteSBwbGFuIGlzIHRvIHRo
cm93IEVOVFJZL0VORFBST0Mgb24gdGhlIGZsb29yIGZyb20geDg2IGNvbXBsZXRlbHkuCkFuZCBJ
IHdpbGwgZG8gaXQgYWZ0ZXIgdGhpcyBwYXRjaHNldCBzZXR0bGVzIGRvd24gYnkgc2VkIG9yIHNv
bWV0aGluZyBpbgpvbmUgc2hvdCAocGVyIGRpcmVjdG9yeSBvciBzb21ldGhpbmcpLgoKdGhhbmtz
LAotLSAKanMKc3VzZSBsYWJzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW4ub3Jn
Cmh0dHBzOi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
