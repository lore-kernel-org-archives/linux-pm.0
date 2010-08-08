From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sun, 8 Aug 2010 15:53:52 +0300
Message-ID: <AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi__332.115105311637$1281272081$gmane$org@mail.gmail.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100804195704.GA23681@linux.vnet.ibm.com>
	<20100806225453.GA3947@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008061651530.30564@asgard.lang.hm>
	<AANLkTikyRhtfX4R3x_NDgHnXssmfVuhjC5PbhRZ0a7su@mail.gmail.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100807061558.GA28087@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ted Ts'o <tytso@mit.edu>, david@lang.hm, Brian Swetland <swetland@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-pm@lists.linux-foundation.
List-Id: linux-pm@vger.kernel.org

T24gU2F0LCBBdWcgNywgMjAxMCBhdCA5OjE1IEFNLCBUZWQgVHMnbyA8dHl0c29AbWl0LmVkdT4g
d3JvdGU6Cj4gT24gRnJpLCBBdWcgMDYsIDIwMTAgYXQgMDg6MTQ6MDlQTSAtMDcwMCwgZGF2aWRA
bGFuZy5obSB3cm90ZToKPj4gMS4gc2xlZXBpbmcgY2FuJ3QgY3VycmVudGx5IHNhdmUgYXMgbXVj
aCBwb3dlciBhcyBzdXNwZW5kaW5nCj4KPiBObywgSSBkb24ndCB0aGluayB0aGF0J3MgdGhlIGNh
c2UgYXQgYWxsLiDCoFRoZSBrZXkgdGhpbmcgaGVyZSBpcyB0aGF0Cj4gKm1vc3QqIGFwcGxpY2F0
aW9ucyBkb24ndCBuZWVkIHRvIGJlIG1vZGlmaWVkIHRvIHVzZSBzdXNwZW5kIGxvY2tzLAo+IGJl
Y2F1c2UgZXZlbiB0aG91Z2ggdGhleSBtaWdodCBiZSBpbiBhbiBldmVudCBsb29wLCB3aGVuIHRo
ZSB1c2VyIHVzZXIKPiB0dXJucyBvZmYgdGhlIGRpc3BsYXksIHRoZSB1c2VyIGdlbmVyYWxseSBk
b2Vzbid0IHdhbnQgaXQgZG9pbmcgdGhpbmdzCj4gb24gdGhlaXIgYmVoYWxmLgoKWW91IGFyZSBv
dmVyZ2VuZXJhbGl6aW5nOyB0aGVyZSBhcmUgbWFueSBhcHBsaWNhdGlvbnMgdGhhdCBydW4gaW4g
dGhlCmJhY2tncm91bmQsIGFuZCB5b3Ugd2FudCB0byBrZWVwIHRoZW0gcnVubmluZyBldmVuIHdo
ZW4gdGhlIGRpc3BsYXkgaXMKb2ZmLgoKWW91IHNlZW4gdG8gYmUgY29uY2VudHJhdGluZyBvbiBV
SS1vbmx5IGFwcGxpY2F0aW9ucywgZm9yIHRob3NlIGl0J3MKd29ydGggbm90aW5nIHRoYXQgQW5k
cm9pZCBwcm92aWRlcyBzZXBhcmF0ZSBtZWNoYW5pc21zIGZvciBwb3dlcgpzYXZpbmcuIFNpbmNl
IEFuZHJvaWQgZG9lc24ndCBoYXZlIHRydWUgbXVsdGktdGFza2luZywgdGhlCmFwcGxpY2F0aW9u
cyBtdXN0IHNlcmlhbGl6ZSB0aGVpciBzdGF0ZXMgc28gdGhhdCB0aGUgbmV4dCB0aW1lIHRoZXkK
YXJlIG9wZW5lZCB0aGV5IHNlZW0gdG8gaGF2ZSBub3QgYmVlbiBjbG9zZWQuIFNvLCB0aGUgY3Vy
cmVudCBhY3RpdmUKVUkgYXBwbGljYXRpb24gY2FuIGJlIGNsb3NlZCB3aGlsZSB0dXJuaW5nIG9m
ZiB0aGUgZGlzcGxheSwgYW5kCnJlLW9wZW5lZCBsYXRlci4KClVzZXItc3BhY2Ugc3VzcGVuZCBi
bG9ja2VycyBhcmUgcmVsZXZhbnQgZm9yIGJhY2tncm91bmQgc2VydmljZXMsIGFuZAphcyBpdCBo
YXMgYmVlbiBkaXNjdXNzZWQgYmVmb3JlOyBzdXNwZW5kIGJsb2NrZXJzIChub3QgYWN0aXZhdGlu
Zwp0aGVtKSBtaWdodCBhY3R1YWxseSBkZWdyYWRlIHBvd2VyIHVzYWdlLgoKLS0gCkZlbGlwZSBD
b250cmVyYXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1wbQ==
