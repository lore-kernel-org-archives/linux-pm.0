From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v4] cpuidle: Fix last_residency division
Date: Fri, 1 Jul 2016 09:00:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1607010857480.12094@knanqh.ubzr>
References: <1467297253-2171-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <5775335E.2040003@linaro.org>
 <alpine.LFD.2.20.1606301132350.12094@knanqh.ubzr>
 <577624A3.2000406@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <577624A3.2000406@linaro.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: arnd@arndb.de, linux-pm@vger.kernel.org, rjw@rjwysocki.net, David.Laight@ACULAB.COM, anton@samba.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

T24gRnJpLCAxIEp1bCAyMDE2LCBEYW5pZWwgTGV6Y2FubyB3cm90ZToKCj4gT24gMDYvMzAvMjAx
NiAwNTozNyBQTSwgTmljb2xhcyBQaXRyZSB3cm90ZToKPiA+IE9uIFRodSwgMzAgSnVuIDIwMTYs
IERhbmllbCBMZXpjYW5vIHdyb3RlOgo+IAo+IFsgLi4uIF0KPiAKPiA+ID4gPiArCWlmIChsaWtl
bHkobnNlYyA8IERJVl9BUFBST1hJTUFUSU9OX1RIUkVTSE9MRCkpIHsKPiA+ID4gPiArCQl1MzIg
dXNlYyA9IG5zZWM7Cj4gPiA+ID4gKwo+ID4gPiA+ICsJCXVzZWMgKz0gdXNlYyA+PiA1Owo+ID4g
PiA+ICsJCXVzZWMgPSB1c2VjID4+IDEwOwo+ID4gPiA+ICsKPiA+ID4gPiArCQkvKiBDYW4gc2Fm
ZWx5IGNhc3QgdG8gaW50IHNpbmNlIHVzZWMgaXMgPCBJTlRfTUFYICovCj4gPiA+ID4gKwkJcmV0
dXJuIHVzZWM7Cj4gPiA+ID4gKwl9IGVsc2Ugewo+ID4gPiA+ICsJCXU2NCB1c2VjID0gZGl2X3U2
NChuc2VjLCAxMDAwKTsKPiA+ID4gPiArCj4gPiA+ID4gKwkJaWYgKHVzZWMgPiBJTlRfTUFYKQo+
ID4gPiA+ICsJCQl1c2VjID0gSU5UX01BWDsKPiA+ID4gPiArCj4gPiA+ID4gKwkJLyogQ2FuIHNh
ZmVseSBjYXN0IHRvIGludCBzaW5jZSB1c2VjIGlzIDwgSU5UX01BWCAqLwo+ID4gPiA+ICsJCXJl
dHVybiB1c2VjOwo+ID4gPiA+ICsJfQo+ID4gPiA+ICt9Cj4gPiA+Cj4gPiA+Cj4gPiA+IFdoYXQg
Ym90aGVycyBtZSB3aXRoIHRoaXMgZGl2aXNpb24gaXMgdGhlIGJlbmVmaXQgb2YgYWRkaW5nIGFu
IGV4dHJhIHVsdHJhCj4gPiA+IG9wdGltaXplZCBkaXZpc2lvbiBieSAxMDAwIGluIGNwdWlkbGUu
aCB3aGlsZSB3ZSBoYXZlIGFscmVhZHkga3RpbWVfZGl2bnMKPiA+ID4gd2hpY2ggaXMgb3B0aW1p
emVkIGluIGt0aW1lLmguCj4gPgo+ID4gSXQgaXMgIm9wdGltaXplZCIgYnV0IHN0aWxsIG11Y2gg
aGVhdmllciB0aGFuIHdoYXQgaXMgcHJlc2VudGVkIGFib3ZlIGFzCj4gPiBpdCBwcm92aWRlcyBt
YXhpbXVtIHByZWNpc2lvbi4KPiA+Cj4gPiBJdCBhbGwgZGVwZW5kcyBvbiBob3cgaW1wb3J0YW50
IHRoZSBwZXJmb3JtYW5jZSBnYWluIGZyb20gdGhlIG9yaWdpbmFsCj4gPiBzaGlmdCBieSAxMCB3
YXMgaW4gdGhlIGZpcnN0IHBsYWNlLgo+IAo+IEFjdHVhbGx5IHRoZSBvcmlnaW5hbCBzaGlmdCB3
YXMgdGhlcmUgYmVjYXVzZSBpdCB3YXMgY29udmVuaWVudCBhcyBhIHNpbXBsZQo+IH5kaXYxMDAw
IG9wZXJhdGlvbi4gQnV0IGFnYWluc3QgYWxsIG9kZHMsIHRoZSBhcHByb3hpbWF0aW9uIGludHJv
ZHVjZWQgYQo+IHJlZ3Jlc3Npb24gb24gYSB2ZXJ5IHNwZWNpZmljIHVzZSBjYXNlIG9uIFBvd2Vy
UEMuCj4gCj4gV2UgYXJlIG5vdCBpbiB0aGUgaG90IHBhdGggYW5kIEkgdGhpbmsgd2UgY2FuIGxp
dmUgd2l0aCBhIGt0aW1lX2Rpdm5zIHdpdGhvdXQKPiBwcm9ibGVtLiBUaGF0IHdvdWxkIHNpbXBs
aWZ5IHRoZSBmaXggSSBiZWxpZXZlLgoKSSBhZ3JlZS4KCj4gUGVyaGFwcyB0aGUgZGl2MTAwMCBy
b3V0aW5lIGNvdWxkIGJlIG1vdmVkIGluIGt0aW1lLmggdG8gYmUgdXNlZCBhcyBhIGhlbHBlcgo+
IGZvciBrdGltZV9kaXZucyB3aGVuIHdlIGRpdmlkZSBieSB0aGUgMTAwMCBjb25zdGFudCBhbmQg
c3VibWl0dGVkIGluIGEKPiBzZXBhcmF0ZSBwYXRjaCBhcyBhbiBvcHRpbWl6YXRpb24uCgpUaGUg
cHJvcG9zZWQgcGF0Y2ggaGVyZSBzdGlsbCBwcm92aWRlcyBhbiBhcHByb3hpbWF0aW9uIHNvIGl0
IHdvdWxkbid0IApiZSBhcHByb3ByaWF0ZSBmb3Iga3RpbWVfZGl2bnMuCgoKTmljb2xhcwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYg
bWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMu
b3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
