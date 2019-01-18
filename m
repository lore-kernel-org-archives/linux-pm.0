From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
Date: Fri, 18 Jan 2019 12:05:18 +0100
Message-ID: <CAJZ5v0gFpK3Kqyf=RM+160A3RAQYPs3c3EgxmNH7ZceEaujEUw@mail.gmail.com>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
 <20190117221628.GA21979@roeck-us.net> <20190118104215.GA13168@linaro.org>
 <CAKfTPtD9fu06sw8=MvjwfQfJoQHb0kT3un9=kdw+WZj+rbVUZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAKfTPtD9fu06sw8=MvjwfQfJoQHb0kT3un9=kdw+WZj+rbVUZg@mail.gmail.com>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, David Airlie <airlied@linux.ie>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, rodrigo.vivi@intel.com, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

T24gRnJpLCBKYW4gMTgsIDIwMTkgYXQgMTE6NTMgQU0gVmluY2VudCBHdWl0dG90Cjx2aW5jZW50
Lmd1aXR0b3RAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBPbiBGcmksIDE4IEphbiAyMDE5IGF0IDEx
OjQyLCBWaW5jZW50IEd1aXR0b3QKPiA8dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc+IHdyb3Rl
Ogo+ID4KPiA+IEhpIEd1ZW50ZXIsCj4gPgo+ID4gTGUgVGh1cnNkYXkgMTcgSmFuIDIwMTkgw6Ag
MTQ6MTY6MjggKC0wODAwKSwgR3VlbnRlciBSb2VjayBhIMOpY3JpdCA6Cj4gPiA+IE9uIEZyaSwg
RGVjIDIxLCAyMDE4IGF0IDExOjMzOjU2QU0gKzAxMDAsIFZpbmNlbnQgR3VpdHRvdCB3cm90ZToK
PiA+ID4gPiBGcm9tOiBUaGFyYSBHb3BpbmF0aCA8dGhhcmEuZ29waW5hdGhAbGluYXJvLm9yZz4K
PiA+ID4gPgo+ID4gPiA+IFRoaXMgcGF0Y2ggcmVwbGFjZXMgamlmZmllcyBiYXNlZCBhY2NvdW50
aW5nIGZvciBydW50aW1lX2FjdGl2ZV90aW1lCj4gPiA+ID4gYW5kIHJ1bnRpbWVfc3VzcGVuZGVk
X3RpbWUgd2l0aCBrdGltZSBiYXNlIGFjY291bnRpbmcuIFRoaXMgbWFrZXMgdGhlCj4gPiA+ID4g
cnVudGltZSBkZWJ1ZyBjb3VudGVycyBpbmxpbmUgd2l0aCBnZW5wZCBhbmQgb3RoZXIgcG0gc3Vi
c3l0ZW1zIHdoaWNoCj4gPiA+ID4gdXNlcyBrdGltZSBiYXNlZCBhY2NvdW50aW5nLgo+ID4gPiA+
Cj4gPiA+ID4gdGltZWtlZXBpbmcgaXMgaW5pdGlhbGl6ZWQgYmVmb3JlIHBtX3J1bnRpbWVfaW5p
dCgpIHNvIGt0aW1lX2dldCgpIHdpbGwKPiA+ID4gPiBiZSByZWFkeSBiZWZvcmUgZmlyc3QgY2Fs
bC4gSW4gZmFjdCwgdGltZWtlZXBpbmdfaW5pdCgpIGlzIGNhbGxlZCBlYXJseQo+ID4gPiA+IGlu
IHN0YXJ0X2tlcm5lbCgpIHdoaWNoIGlzIHdheSBiZWZvcmUgZHJpdmVyX2luaXQoKSAoYW5kIHRo
YXQncyB3aGVuCj4gPiA+ID4gZGV2aWNlcyBjYW4gc3RhcnQgdG8gYmUgaW5pdGlhbGl6ZWQpIGNh
bGxlZCBmcm9tIHJlc3RfaW5pdCgpIHZpYQo+ID4gPiA+IGtlcm5lbF9pbml0X2ZyZWVhYmxlKCkg
YW5kIGRvX2Jhc2ljX3NldHVwKCkuCj4gPiA+ID4KPiA+ID4gVGhpcyBpcyBub3QgKGFsd2F5cykg
Y29ycmVjdC4gTXkgcWVtdSAiY29sbGllIiBib290IHRlc3QgZmFpbHMgd2l0aCB0aGlzCj4gPiA+
IHBhdGNoIGFwcGxpZWQuIFJldmVydGluZyB0aGUgcGF0Y2ggZml4ZXMgdGhlIHByb2JsZW0uIEJp
c2VjdCBsb2cgYXR0YWNoZWQuCj4gPiA+Cj4gPgo+ID4gQ2FuIHlvdSB0cnkgdGhlIHBhdGNoIGJl
bG93ID8KPiA+IGt0aW1lX2dldF9tb25vX2Zhc3RfbnMoKSBoYXMgdGhlIGFkdmFudGFnZSBvZiBi
ZWluZyBpbml0IHdpdGggZHVtbXkgY2xvY2sgc28KPiA+IGl0IGNhbiBiZSB1c2VkIGF0IGVhcmx5
X2luaXQuCj4KPiBBbm90aGVyIHBvc3NpYmlsaXR5IHdvdWxkIGJlIGRlbGF5IHRoZSBpbml0IG9m
IHRoZSBncGlvY2hpcAoKV2VsbCwgcmlnaHQuCgpJbml0aWFsaXppbmcgZGV2aWNlcyBiZWZvcmUg
dGltZWtlZXBpbmcgZG9lc24ndCBmZWVsIHBhcnRpY3VsYXJseQpyb2J1c3QgZnJvbSB0aGUgZGVz
aWduIHBlcnNwZWN0aXZlLgoKSG93IGV4YWN0bHkgZG9lcyB0aGF0IGhhcHBlbj8KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
