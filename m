From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v3] cpuidle: Fix last_residency division
Date: Wed, 29 Jun 2016 11:52:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1606291151060.24439@knanqh.ubzr>
References: <1467183971-12327-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <57737AA1.7050201@linaro.org>
 <alpine.LFD.2.20.1606290944400.24439@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <alpine.LFD.2.20.1606290944400.24439@knanqh.ubzr>
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, David.Laight@ACULAB.COM, anton@samba.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCAyOSBKdW4gMjAxNiwgTmljb2xhcyBQaXRyZSB3cm90ZToKCj4gT24gV2VkLCAyOSBK
dW4gMjAxNiwgRGFuaWVsIExlemNhbm8gd3JvdGU6Cj4gCj4gPiBPbiAwNi8yOS8yMDE2IDA5OjA2
IEFNLCBTaHJleWFzIEIuIFByYWJodSB3cm90ZToKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y3B1aWRsZS9jcHVpZGxlLmggYi9kcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS5oCj4gPiA+IGluZGV4
IGY4N2YzOTkuLmM4ZWE1YWQgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvY3B1aWRsZS9jcHVp
ZGxlLmgKPiA+ID4gKysrIGIvZHJpdmVycy9jcHVpZGxlL2NwdWlkbGUuaAo+ID4gPiBAQCAtNjgs
NCArNjgsMjcgQEAgc3RhdGljIGlubGluZSB2b2lkCj4gPiA+IGNwdWlkbGVfY291cGxlZF91bnJl
Z2lzdGVyX2RldmljZShzdHJ1Y3QgY3B1aWRsZV9kZXZpY2UgKmRldikKPiA+ID4gICB9Cj4gPiA+
ICAgI2VuZGlmCj4gPiA+Cj4gPiA+ICsvKgo+ID4gPiArICogVXNlZCBmb3IgY2FsY3VsYXRpbmcg
bGFzdF9yZXNpZGVuY3kgaW4gdXNlYy4gT3B0aW1pemVkIGZvciBjYXNlCj4gPiA+ICsgKiB3aGVy
ZSBsYXN0X3Jlc2lkZW5jeSBpbiBuc2VjcyBpcyA8IElOVF9NQVgvMiBieSB1c2luZyBmYXN0ZXIK
PiA+ID4gKyAqIGFwcHJveGltYXRpb24uIEFwcHJveGltYXRlZCB2YWx1ZSBoYXMgbGVzcyB0aGFu
IDElIGVycm9yLgo+ID4gPiArICovCj4gPiA+ICtzdGF0aWMgaW5saW5lIGludCBjb252ZXJ0X25z
ZWNfdG9fdXNlYyh1NjQgbnNlYykKPiA+ID4gK3sKPiA+ID4gKwlpZiAobGlrZWx5KG5zZWMgPCBJ
TlRfTUFYIC8gMikpIHsKPiA+IAo+ID4gVUlOVF9NQVggPwo+IAo+IEFjdHVhbGx5IHRoaXMgY2Fu
IGJlIGJldHRlciB0aGFuIHRoYXQuCj4gCj4gPiA+ICsJCWludCB1c2VjID0gKGludCluc2VjOwo+
IAo+IEZpcnN0LCB5b3UnbGwgd2FudCBhbiB1bnNpZ25lZCB0eXBlLiBHaXZlbiB0aGUgcHJvdmlk
ZWQgYXJndW1lbnQgaXMgdTY0LCAKPiB3ZSBjYW4gYXNzdW1lIHRoZXJlIHdvbid0IGJlIGFueSBu
ZWdhdGl2ZSB2YWx1ZXMgaGVyZS4KPiAKPiBUaGVuIGl0IHdvdWxkIGJlIHdpc2UgdG8gdXNlIGEg
dHlwZSB3aXRoIGFuIGV4cGxpY2l0IHdpZHRoLCBsaWtlIFUzMi4KPiAKPiA+ID4gKwkJdXNlYyAr
PSB1c2VjID4+IDU7Cj4gPiA+ICsJCXVzZWMgPSB1c2VjID4+IDEwOwo+ID4gPiArCQlyZXR1cm4g
dXNlYzsKPiAKPiBBbmQgbm93IHlvdSB3YW50IHRvIG1heGltaXplIHRoZSBhdmFpbGFibGUgcmFu
Z2UuIFNvIG5vdCB0byBvdmVyZmxvdyB0aGUgCj4gZmlyc3QgYWRkaXRpb24sIHdlIG11c3QgcmVz
cGVjdDoKPiAKPiAJdXNlYyArICh1c2VjID4+IDUpIDw9IDB4ZmZmZmZmZmYgCj4gCXVzZWMgKyB1
c2VjLzMyIDw9IDB4ZmZmZmZmZmYKPiAJdXNlYyA8PSAoMHhmZmZmZmZmZiAqIDMyKSAvIDMzCj4g
Cj4gVGhlcmVmb3JlOgo+IAo+IAluc2VjIDw9IDB4ZjgzZTBmODIKCkFuZCB0byBiZSBzdXJlLCB5
b3Ugc2hvdWxkIHVzZSAweGY4M2UwZjgyVUwgdG8gYXZvaWQgYW55IHBvdGVudGlhbCBzaWduIApl
eHRlbnNpb24uCgoKTmljb2xhcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5v
emxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
