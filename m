From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Armada DRM: bridge with componentized devices
Date: Fri, 18 Jan 2019 11:03:35 +0100
Message-ID: <CAJZ5v0iteL55yjxw=NFkKJ+4=gCJ36jviruLTsyFDU+Oj+j-og@mail.gmail.com>
References: <20190108132150.GT11171@n2100.armlinux.org.uk>
 <515889972.533tA6DaoZ@aspire.rjw.lan>
 <CAKMK7uGY7oQVn4jjN58k0-6YL201xwMp2sfnS8P+SNbaETPgAg@mail.gmail.com>
 <4051825.HNqyo8zv3N@aspire.rjw.lan>
 <CAKMK7uHV=8Jpb1z_iRK-WBWW+oA6dYO7-Yj6tHkf7Be98_Xitg@mail.gmail.com>
 <1547804218.2626.7.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1547804218.2626.7.camel@pengutronix.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Lubomir Rintel <lkundrak@v3.sk>, "Sarvela,
 Tomi P" <tomi.p.sarvela@intel.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, DRI Development <dri-devel@lists.freedesktop.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Paul <sean@poorly.run>, Peter Rosin <peda@axentia.se>
List-Id: linux-pm@vger.kernel.org

T24gRnJpLCBKYW4gMTgsIDIwMTkgYXQgMTA6MzcgQU0gTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVu
Z3V0cm9uaXguZGU+IHdyb3RlOgo+Cj4gQW0gRG9ubmVyc3RhZywgZGVuIDE3LjAxLjIwMTksIDEz
OjIwICswMTAwIHNjaHJpZWIgRGFuaWVsIFZldHRlcjoKPiBbLi4uXQo+ID4KPiA+ID4gSSBkb24n
dCB0aGluayBpdCBpcyBhZGRyZXNzZWQgaGVyZS4KPiA+ID4KPiA+ID4gQ2FuIGFueW9uZSBwbGVh
c2UgZXhwbGFpbiB0byBtZSB3aGF0IGhhcHBlbnMgaW4gbW9yZSBkZXRhaWw/Cj4gPgo+ID4gTXkg
dW5kZXJzdGFuZGluZyAoYW5kIHRoaXMgbWlnaHQgYmUgd3JvbmcsIFJ1c3NlbGwsIEFuZHJ6ZWos
IC4uLiBwbHMKPiA+IGNvcnJlY3QpIGlzIHRoYXQgdGhlIGZvbGxvd2luZyBzZXF1ZW5jZSBnb2Vz
IHdyb25nOgo+ID4KPiA+IC0gY29tcG9uZW50aXplZCBkcml2ZXIgKGJvdGggcHJvZHVjZXIgYW5k
IGNvbnN1bWVyKSBmdWxseSBsb2FkZWQmd29ya2luZwo+ID4gLSB5b3UgdW5iaW5kIHRoZSBwcm9k
dWNlci9vbmUgb2YgdGhlIGNvbXBvbmVudHMKPiA+IC0gY29tcG9uZW50IGZyYW1ld29yayBvciBk
cml2ZXIgY29yZSB0aHJvdWdoIGRldmljZV9saW5rIGFsc28gdW5iaW5kcwo+ID4gdGhlIG1hc3Rl
ci9jb25zdW1lcgo+ID4gLSB5b3UgcmVsb2FkL3JlYmluZCB0aGUgY29tcG9uZW50Cj4gPiAtIHdp
dGggdGhlIGNvbXBvbmVudCBmcmFtZXdvcmsgdGhpcyByZXN1bHRzIGluIHRoZSBtYXN0ZXIgYmVp
bmcKPiA+IHJlYm91bmQsIGFuZCB0aGUgb3ZlcmFsbCBkcml2ZXIgd29ya2luZyBhZ2Fpbi4gV2l0
aCBkZXZpY2VfbGlua3MKPiA+IG5vdGhpbmcgaGFwcGVucy4KPiA+Cj4gPiBJIHRoaW5rIHRoZXJl
IHdhcyBhIHBhdGNoIGZsb2F0aW5nIGFyb3VuZCBvbmNlIHRvIHB1dCBkcml2ZXJzIHVuYm91bmQK
PiA+IGR1ZSB0byBkZXZpY2VfbGlua3Mgb250byB0aGUgZGVmZXJyZWQgcHJvYmUgbGlzdCwgc28g
dGhhdCB0aGUgbmV4dAo+ID4gdGltZSBzb21ldGhpbmcgaXMgYm91bmQgdGhleSBoYXZlIGEgY2hh
bmNlIHRvIHJlYmluZC4gQnV0IEkgY2FuJ3QgZmluZAo+ID4gdGhhdCBwYXRjaCBhbnltb3JlLCBt
YXliZSBzb21lb25lIGVsc2UgaGFzIHRoZSBsaW5rIHN0aWxsPwo+Cj4gaHR0cHM6Ly93d3cubWFp
bC1hcmNoaXZlLmNvbS9saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnL21zZzEzNDgwMjMuaHRt
bAo+IGh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZy9tc2cxMzU1MjQzLmh0bWwKPgo+IEkgY2FuIHJlcG9zdCBpZiB0aGlzIGlzIGZpbmFsbHkg
ZGVlbWVkIGEgZ29vZCBpZGVhLgoKSSBkb24ndCB0aGluayB0aGlzIHdpbGwgaGVscC4KClR3byB0
aGluZ3MgYXBwZWFyIHRvIGJlIG5lZWRlZCBoZXJlOiBtaXNzaW5nIHN1cHBsaWVycyBuZWVkIHRv
IGJlCnByb2JlZCBhdXRvbWF0aWNhbGx5IGF0IGEgY29uc3VtZXIgcHJvYmUgdGltZSBhbmQgInBl
cnNpc3RlbnQiIGxpbmtzCmNyZWF0ZWQgYnkgLT5wcm9iZSgpIGNhbGxiYWNrcyBzaG91bGQgbm90
IGJlIHJlZmVyZW5jZS1jb3VudGVkIHdoZW4KdGhvc2UgY2FsbGJhY2tzIHJ1biBhZ2Fpbi4gIEkn
bSBnb2luZyB0byBjdXQgYSBwYXRjaCB0byBkbyB0aGF0IChlYXJseQpuZXh0IHdlZWsgaWYgYWxs
IGdvZXMgd2VsbCkuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bAo=
