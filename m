From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v4] cpuidle: Fix last_residency division
Date: Fri, 01 Jul 2016 22:41:13 +1000
Message-ID: <1467376873.12509.1.camel@gmail.com>
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
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: arnd@arndb.de, linux-pm@vger.kernel.org, rjw@rjwysocki.net, David.Laight@ACULAB.COM, anton@samba.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

T24gRnJpLCAyMDE2LTA3LTAxIGF0IDEwOjA2ICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToK
PiBPbiAwNi8zMC8yMDE2IDA1OjM3IFBNLCBOaWNvbGFzIFBpdHJlIHdyb3RlOgo+ID7CoAo+ID4g
T24gVGh1LCAzMCBKdW4gMjAxNiwgRGFuaWVsIExlemNhbm8gd3JvdGU6Cj4gWyAuLi4gXQo+wqAK
PiA+wqAKPiA+ID7CoAo+ID4gPiA+wqAKPiA+ID4gPiArCWlmIChsaWtlbHkobnNlYyA8IERJVl9B
UFBST1hJTUFUSU9OX1RIUkVTSE9MRCkpIHsKPiA+ID4gPiArCQl1MzIgdXNlYyA9IG5zZWM7Cj4g
PiA+ID4gKwo+ID4gPiA+ICsJCXVzZWMgKz0gdXNlYyA+PiA1Owo+ID4gPiA+ICsJCXVzZWMgPSB1
c2VjID4+IDEwOwo+ID4gPiA+ICsKPiA+ID4gPiArCQkvKiBDYW4gc2FmZWx5IGNhc3QgdG8gaW50
IHNpbmNlIHVzZWMgaXMgPCBJTlRfTUFYICovCj4gPiA+ID4gKwkJcmV0dXJuIHVzZWM7Cj4gPiA+
ID4gKwl9IGVsc2Ugewo+ID4gPiA+ICsJCXU2NCB1c2VjID0gZGl2X3U2NChuc2VjLCAxMDAwKTsK
PiA+ID4gPiArCj4gPiA+ID4gKwkJaWYgKHVzZWMgPiBJTlRfTUFYKQo+ID4gPiA+ICsJCQl1c2Vj
ID0gSU5UX01BWDsKPiA+ID4gPiArCj4gPiA+ID4gKwkJLyogQ2FuIHNhZmVseSBjYXN0IHRvIGlu
dCBzaW5jZSB1c2VjIGlzIDwgSU5UX01BWCAqLwo+ID4gPiA+ICsJCXJldHVybiB1c2VjOwo+ID4g
PiA+ICsJfQo+ID4gPiA+ICt9Cj4gPiA+wqAKPiA+ID4gV2hhdCBib3RoZXJzIG1lIHdpdGggdGhp
cyBkaXZpc2lvbiBpcyB0aGUgYmVuZWZpdCBvZiBhZGRpbmcgYW4gZXh0cmEgdWx0cmEKPiA+ID4g
b3B0aW1pemVkIGRpdmlzaW9uIGJ5IDEwMDAgaW4gY3B1aWRsZS5oIHdoaWxlIHdlIGhhdmUgYWxy
ZWFkeSBrdGltZV9kaXZucwo+ID4gPiB3aGljaCBpcyBvcHRpbWl6ZWQgaW4ga3RpbWUuaC4KPiA+
IEl0IGlzICJvcHRpbWl6ZWQiIGJ1dCBzdGlsbCBtdWNoIGhlYXZpZXIgdGhhbiB3aGF0IGlzIHBy
ZXNlbnRlZCBhYm92ZSBhcwo+ID4gaXQgcHJvdmlkZXMgbWF4aW11bSBwcmVjaXNpb24uCj4gPsKg
Cj4gPiBJdCBhbGwgZGVwZW5kcyBvbiBob3cgaW1wb3J0YW50IHRoZSBwZXJmb3JtYW5jZSBnYWlu
IGZyb20gdGhlIG9yaWdpbmFsCj4gPiBzaGlmdCBieSAxMCB3YXMgaW4gdGhlIGZpcnN0IHBsYWNl
Lgo+IEFjdHVhbGx5IHRoZSBvcmlnaW5hbCBzaGlmdCB3YXMgdGhlcmUgYmVjYXVzZSBpdCB3YXMg
Y29udmVuaWVudCBhcyBhwqAKPiBzaW1wbGUgfmRpdjEwMDAgb3BlcmF0aW9uLiBCdXQgYWdhaW5z
dCBhbGwgb2RkcywgdGhlIGFwcHJveGltYXRpb27CoAo+IGludHJvZHVjZWQgYSByZWdyZXNzaW9u
IG9uIGEgdmVyeSBzcGVjaWZpYyB1c2UgY2FzZSBvbiBQb3dlclBDLgo+wqAKPiBXZSBhcmUgbm90
IGluIHRoZSBob3QgcGF0aCBhbmQgSSB0aGluayB3ZSBjYW4gbGl2ZSB3aXRoIGEga3RpbWVfZGl2
bnPCoAo+IHdpdGhvdXQgcHJvYmxlbS4gVGhhdCB3b3VsZCBzaW1wbGlmeSB0aGUgZml4IEkgYmVs
aWV2ZS4KPsKgCgpJIHdvdWxkIHRlbmQgdG8gYWdyZWUgd2l0aCB0aGlzIGFuZCB0aGVyZSBhcmUg
YmV0dGVyIHdheXMgdG8gZG8KbXVsdGlwbGljYXRpdmUgaW52ZXJzZXMgaWYgd2UgY2FyZQoKQmFs
YmlyIFNpbmdoLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9y
ZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
