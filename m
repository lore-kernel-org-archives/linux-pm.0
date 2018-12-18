From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] drm/i915: Move to new PM core fields
Date: Tue, 18 Dec 2018 11:03:05 +0100
Message-ID: <CAJZ5v0g9ceG=dVTTfwkqdZQ0-YMswvfHNfmryZfXAfH=yJV__g@mail.gmail.com>
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
 <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFrvrN6+sVGc1sM+hmQo=JR=8FyAz_YRK9DzEQN2jOVX6w@mail.gmail.com>
 <CAKfTPtBbZgZtU-qZhh-nKoC=cNj=ZT_LTn=cTX4V10MCZhDFEg@mail.gmail.com>
 <CAJZ5v0i0FMw90vBH9L9EirX-mfFzh4Fb0npE8Y7rHbFn0JpZyw@mail.gmail.com>
 <CAKfTPtCNYz6a5rqvpGGGNgsAw_=HdqtpEOfXjn309saNUBjbrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CAKfTPtCNYz6a5rqvpGGGNgsAw_=HdqtpEOfXjn309saNUBjbrw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux PM <linux-pm@vger.kernel.org>, David Airlie <airlied@linux.ie>, intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, rodrigo.vivi@intel.com
List-Id: linux-pm@vger.kernel.org

T24gVHVlLCBEZWMgMTgsIDIwMTggYXQgMTA6NTggQU0gVmluY2VudCBHdWl0dG90Cjx2aW5jZW50
Lmd1aXR0b3RAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBPbiBUdWUsIDE4IERlYyAyMDE4IGF0IDEw
OjU3LCBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4KPiA+
IE9uIE1vbiwgRGVjIDE3LCAyMDE4IGF0IDM6MjIgUE0gVmluY2VudCBHdWl0dG90Cj4gPiA8dmlu
Y2VudC5ndWl0dG90QGxpbmFyby5vcmc+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBGcmksIDE0IERl
YyAyMDE4IGF0IDE1OjM2LCBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4gd3Jv
dGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBGcmksIDE0IERlYyAyMDE4IGF0IDE1OjIyLCBWaW5jZW50
IEd1aXR0b3QKPiA+ID4gPiA8dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc+IHdyb3RlOgo+ID4g
PiA+ID4KPiA+ID4gPiA+IFdpdGggamlmZmllcyBiZWVuIHJlcGxhY2VkIGJ5IHJhdyBucyBpbiBQ
TSBjb3JlIGFjY291bnRpbmcsIDkxNSBkcml2ZXIgaXMKPiA+ID4gPiA+IHVwZGF0ZWQgdG8gdXNl
IHRoaXMgbmV3IHRpbWUgaW5mcmFzdHJ1Y3R1cmUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogVmluY2VudCBHdWl0dG90IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz4KPiA+
ID4gPiA+IC0tLQo+ID4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfcG11LmMgfCAx
MiArKysrKystLS0tLS0KPiA+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X3BtdS5o
IHwgIDQgKystLQo+ID4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4
IGRlbGV0aW9ucygtKQo+ID4gPiA+ID4KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9pOTE1X3BtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9wbXUuYwo+
ID4gPiA+ID4gaW5kZXggZDZjOGY4Zi4uY2Y2NDM3ZCAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfcG11LmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9pOTE1L2k5MTVfcG11LmMKPiA+ID4gPiA+IEBAIC00OTMsMTQgKzQ5MywxNCBAQCBzdGF0
aWMgdTY0IGdldF9yYzYoc3RydWN0IGRybV9pOTE1X3ByaXZhdGUgKmk5MTUpCj4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICovCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgaWYgKGtkZXYtPnBv
d2VyLnJ1bnRpbWVfc3RhdHVzID09IFJQTV9TVVNQRU5ERUQpIHsKPiA+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmICghaTkxNS0+cG11LnNhbXBsZVtfX0k5MTVfU0FNUExFX1JDNl9F
U1RJTUFURURdLmN1cikKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aTkxNS0+cG11LnN1c3BlbmRlZF9qaWZmaWVzX2xhc3QgPQo+ID4gPiA+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBrZGV2LT5wb3dlci5zdXNwZW5k
ZWRfamlmZmllczsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaTkx
NS0+cG11LnN1c3BlbmRlZF90aW1lX2xhc3QgPQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGtkZXYtPnBvd2VyLnN1c3BlbmRlZF90aW1lOwo+ID4gPiA+
ID4KPiA+ID4gPgo+ID4gPiA+IEh1aCwgc28gcGF0Y2ggMiBpbnRyb2R1Y2VzIGEgY29tcGxpZXIg
ZXJyb3IgYmVjYXVzZSBvZiByZW1vdmluZyB0aGUKPiA+ID4gPiBvbGQgZmllbGRzLiBXZSBjYW4n
dCBoYXZlIHRoYXQuCj4gPiA+Cj4gPiA+IEkgYWdyZWUKPiA+ID4gVGhlIHBhdGNoIHdhcyBtYWlu
bHkgdG8gcmFpc2UgZGlzY3Vzc2lvbgo+ID4KPiA+IE9LLCBzbyBwYXRjaCBbMS8zXSBmcm9tIHRo
aXMgc2VyaWVzIHNob3VsZCBiZSBhcHBsaWNhYmxlIHJlZ2FyZGxlc3MsIHJpZ2h0Pwo+Cj4gWWVz
CgpPSywgSSdsbCBxdWV1ZSBpdCB1cCwgdGhlbi4KCk5leHQgdGltZSB5b3UgZG8gc29tZXRoaW5n
IGxpa2UgdGhhdCAgcGxlYXNlIG1hcmsgcGF0Y2hlcyBmb3IKZGlzY3Vzc2lvbiBpbiBhIHNlcmll
cyBhcyBbUkZDXSBzbyBpdCBpcyBhbGwgY2xlYXIuCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2ludGVsLWdmeAo=
