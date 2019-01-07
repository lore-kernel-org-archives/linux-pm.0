From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Intel-gfx] [PATCH v5 2/3] drm/i915: Move on the new pm runtime
 interface
Date: Mon, 7 Jan 2019 15:21:49 +0100
Message-ID: <CAJZ5v0i_xyKTtMShut5JEFSE=8GrE4cfb_Yi+eeMPZdRsNvmbA@mail.gmail.com>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-3-git-send-email-vincent.guittot@linaro.org>
 <ae85c6d4-5482-1376-7573-8ece9f78bc61@linux.intel.com>
 <CAKfTPtDx8u_TnZQnQNmn+=A5A78CPVSWKvMdOVD0UEw4m4s1iQ@mail.gmail.com>
 <d15e49e3-8d86-9c25-6412-a8534f1790d4@linux.intel.com>
 <CAKfTPtC1VVqK8Fde=AdRFyd4--09XVoNg8xHUja2siynL_o_3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAKfTPtC1VVqK8Fde=AdRFyd4--09XVoNg8xHUja2siynL_o_3Q@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, David Airlie <airlied@linux.ie>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, rodrigo.vivi@intel.com
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBKYW4gNywgMjAxOSBhdCAzOjA0IFBNIFZpbmNlbnQgR3VpdHRvdAo8dmluY2VudC5n
dWl0dG90QGxpbmFyby5vcmc+IHdyb3RlOgo+Cj4gSGkgVHZydGtvLAo+Cj4gT24gTW9uLCAzMSBE
ZWMgMjAxOCBhdCAxMzozMiwgVHZydGtvIFVyc3VsaW4KPiA8dHZydGtvLnVyc3VsaW5AbGludXgu
aW50ZWwuY29tPiB3cm90ZToKPiA+Cj4gPgo+ID4gT24gMjEvMTIvMjAxOCAxMzoyNiwgVmluY2Vu
dCBHdWl0dG90IHdyb3RlOgo+ID4gPiBPbiBGcmksIDIxIERlYyAyMDE4IGF0IDEyOjMzLCBUdnJ0
a28gVXJzdWxpbgo+Cj4gW3NuaXBdCj4KPiA+ID4+Cj4gPiA+PiBJZiBpdCBpcyBhbHdheXMgbW9u
b3RvbmljLCB0aGVuIHdvcnN0IGNhc2Ugd2UgcmVwb3J0IG9uZSB3cm9uZyBzYW1wbGUsCj4gPiA+
PiB3aGljaCBJIGd1ZXNzIGlzIHN0aWxsIG5vdCBpZGVhbCBzaW5jZSBzb21lb25lIGNvdWxkIGJl
IHF1ZXJ5aW5nIHRoZSBQTVUKPiA+ID4+IHdpdGggcXVpdGUgbG93IGZyZXF1ZW5jeS4KPiA+ID4+
Cj4gPiA+PiBUaGVyZSBhcmUgdGVzdHMgd2hpY2ggcHJvYmFibHkgY2FuIGhpdCB0aGlzLCBidXQg
dG8gcnVuIHRoZW0KPiA+ID4+IGF1dG9tYXRpY2FsbHkgeW91ciBwYXRjaGVzIHdvdWxkIG5lZWQg
dG8gYmUgcmViYXNlZCBvbiBkcm0tdGlwIGFuZCBtYXliZQo+ID4gPj4gc2VudCB0byBvdXIgdHJ5
Ym90LiBJIGNhbiBkbyB0aGF0IGFmdGVyIHRoZSBob2xpZGF5IGJyZWFrIGlmIHlvdSBhcmUKPiA+
ID4+IG9rYXkgd2l0aCBoYXZpbmcgdGhlIHNlcmllcyB3YWl0aW5nIHVudGlsIHRoZW4uCj4gPiA+
Cj4gPiA+IHllcyBsb29rcyBnb29kIHRvIG1lCj4gPgo+ID4gTG9va3MgZ29vZCB0byBtZSBhcyB3
ZWxsLiBBbmQgb3VyIENJIGFncmVlcyB3aXRoIGl0LiBTbzoKPiA+Cj4gPiBSZXZpZXdlZC1ieTog
VHZydGtvIFVyc3VsaW4gPHR2cnRrby51cnN1bGluQGludGVsLmNvbT4KPgo+IFRoYW5rcyBmb3Ig
dGhlIHJldmlldyBhbmQgdGhlIHRlc3QKPgo+ID4KPiA+IEkgYXNzdW1lIHlvdSB3aWxsIHRha2Ug
dGhlIHBhdGNoIHRocm91Z2ggc29tZSBwb3dlciByZWxhdGVkIHRyZWUgYW5kIHdlCj4gPiB3aWxs
IGV2ZW50dWFsbHkgcHVsbCBpdCBiYWNrIHRvIGRybS10aXAuCj4KPiBSYWZhZWwsCj4gSG93IGRv
IHlvdSB3YW50IHRvIHByb2NlZWQgd2l0aCB0aGlzIHBhdGNoIGFuZCB0aGUgMiBvdGhlcnMgb2Yg
dGhlIHNlcmllID8KCkknbSBnb2luZyB0byBxdWV1ZSB1cCB0aGUgd2hvbGUgc2VyaWVzIGZvciA1
LjEuCgpUaGFua3MhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bAo=
