From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [Intel-gfx] [PATCH v5 2/3] drm/i915: Move on the new pm runtime
 interface
Date: Mon, 7 Jan 2019 15:03:55 +0100
Message-ID: <CAKfTPtC1VVqK8Fde=AdRFyd4--09XVoNg8xHUja2siynL_o_3Q@mail.gmail.com>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-3-git-send-email-vincent.guittot@linaro.org>
 <ae85c6d4-5482-1376-7573-8ece9f78bc61@linux.intel.com>
 <CAKfTPtDx8u_TnZQnQNmn+=A5A78CPVSWKvMdOVD0UEw4m4s1iQ@mail.gmail.com>
 <d15e49e3-8d86-9c25-6412-a8534f1790d4@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <d15e49e3-8d86-9c25-6412-a8534f1790d4@linux.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, David Airlie <airlied@linux.ie>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, rodrigo.vivi@intel.com
List-Id: linux-pm@vger.kernel.org

SGkgVHZydGtvLAoKT24gTW9uLCAzMSBEZWMgMjAxOCBhdCAxMzozMiwgVHZydGtvIFVyc3VsaW4K
PHR2cnRrby51cnN1bGluQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj4KPgo+IE9uIDIxLzEyLzIw
MTggMTM6MjYsIFZpbmNlbnQgR3VpdHRvdCB3cm90ZToKPiA+IE9uIEZyaSwgMjEgRGVjIDIwMTgg
YXQgMTI6MzMsIFR2cnRrbyBVcnN1bGluCgpbc25pcF0KCj4gPj4KPiA+PiBJZiBpdCBpcyBhbHdh
eXMgbW9ub3RvbmljLCB0aGVuIHdvcnN0IGNhc2Ugd2UgcmVwb3J0IG9uZSB3cm9uZyBzYW1wbGUs
Cj4gPj4gd2hpY2ggSSBndWVzcyBpcyBzdGlsbCBub3QgaWRlYWwgc2luY2Ugc29tZW9uZSBjb3Vs
ZCBiZSBxdWVyeWluZyB0aGUgUE1VCj4gPj4gd2l0aCBxdWl0ZSBsb3cgZnJlcXVlbmN5Lgo+ID4+
Cj4gPj4gVGhlcmUgYXJlIHRlc3RzIHdoaWNoIHByb2JhYmx5IGNhbiBoaXQgdGhpcywgYnV0IHRv
IHJ1biB0aGVtCj4gPj4gYXV0b21hdGljYWxseSB5b3VyIHBhdGNoZXMgd291bGQgbmVlZCB0byBi
ZSByZWJhc2VkIG9uIGRybS10aXAgYW5kIG1heWJlCj4gPj4gc2VudCB0byBvdXIgdHJ5Ym90LiBJ
IGNhbiBkbyB0aGF0IGFmdGVyIHRoZSBob2xpZGF5IGJyZWFrIGlmIHlvdSBhcmUKPiA+PiBva2F5
IHdpdGggaGF2aW5nIHRoZSBzZXJpZXMgd2FpdGluZyB1bnRpbCB0aGVuLgo+ID4KPiA+IHllcyBs
b29rcyBnb29kIHRvIG1lCj4KPiBMb29rcyBnb29kIHRvIG1lIGFzIHdlbGwuIEFuZCBvdXIgQ0kg
YWdyZWVzIHdpdGggaXQuIFNvOgo+Cj4gUmV2aWV3ZWQtYnk6IFR2cnRrbyBVcnN1bGluIDx0dnJ0
a28udXJzdWxpbkBpbnRlbC5jb20+CgpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHRoZSB0ZXN0
Cgo+Cj4gSSBhc3N1bWUgeW91IHdpbGwgdGFrZSB0aGUgcGF0Y2ggdGhyb3VnaCBzb21lIHBvd2Vy
IHJlbGF0ZWQgdHJlZSBhbmQgd2UKPiB3aWxsIGV2ZW50dWFsbHkgcHVsbCBpdCBiYWNrIHRvIGRy
bS10aXAuCgpSYWZhZWwsCkhvdyBkbyB5b3Ugd2FudCB0byBwcm9jZWVkIHdpdGggdGhpcyBwYXRj
aCBhbmQgdGhlIDIgb3RoZXJzIG9mIHRoZSBzZXJpZSA/CgpSZWdhcmRzLApWaW5jZW50Cgo+Cj4g
UmVnYXJkcywKPgo+IFR2cnRrbwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9k
cmktZGV2ZWwK
