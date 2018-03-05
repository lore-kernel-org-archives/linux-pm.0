From: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH 3/3] drm/msm: Add A6XX device support
Date: Mon, 5 Mar 2018 08:26:32 -0700
Message-ID: <20180305152632.GB15200@jcrouse-lnx.qualcomm.com>
References: <20180302214329.1086-1-jcrouse@codeaurora.org>
 <20180302214329.1086-4-jcrouse@codeaurora.org>
 <20180305043938.GB23018@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180305043938.GB23018@vireshk-i7>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: nm@ti.com, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, dri-devel@lists.freedesktop.org, vireshk@kernel.org, freedreno@lists.freedesktop.org
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBNYXIgMDUsIDIwMTggYXQgMTA6MDk6MzhBTSArMDUzMCwgVmlyZXNoIEt1bWFyIHdy
b3RlOgo+IE9uIDAyLTAzLTE4LCAxNDo0MywgSm9yZGFuIENyb3VzZSB3cm90ZToKPiA+ICtzdGF0
aWMgaW50IGE2eHhfZ211X2J1aWxkX2ZyZXFfdGFibGUoc3RydWN0IGRldmljZSAqZGV2LCB1bnNp
Z25lZCBsb25nICpmcmVxcywKPiA+ICsJCXUzMiBzaXplKQo+ID4gK3sKPiA+ICsJaW50IGNvdW50
ID0gZGV2X3BtX29wcF9nZXRfb3BwX2NvdW50KGRldik7Cj4gPiArCXN0cnVjdCBkZXZfcG1fb3Bw
ICpvcHA7Cj4gPiArCWludCBpLCBpbmRleCA9IDA7Cj4gPiArCXVuc2lnbmVkIGxvbmcgZnJlcSA9
IDE7Cj4gPiArCj4gPiArCS8qCj4gPiArCSAqIFRoZSBPUFAgdGFibGUgZG9lc24ndCBjb250YWlu
IHRoZSAib2ZmIiBmcmVxdWVuY3kgbGV2ZWwgc28gd2UgbmVlZCB0bwo+ID4gKwkgKiBhZGQgMSB0
byB0aGUgdGFibGUgc2l6ZSB0byBhY2NvdW50IGZvciBpdAo+ID4gKwkgKi8KPiA+ICsKPiA+ICsJ
aWYgKFdBUk4oY291bnQgKyAxID4gc2l6ZSwKPiA+ICsJCSJUaGUgR01VIGZyZXF1ZW5jeSB0YWJs
ZSBpcyBiZWluZyB0cnVuY2F0ZWRcbiIpKQo+ID4gKwkJY291bnQgPSBzaXplIC0gMTsKPiA+ICsK
PiA+ICsJLyogU2V0IHRoZSAib2ZmIiBmcmVxdWVuY3kgKi8KPiA+ICsJZnJlcXNbaW5kZXgrK10g
PSAwOwo+ID4gKwo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgY291bnQ7IGkrKykgewo+ID4gKwkJb3Bw
ID0gZGV2X3BtX29wcF9maW5kX2ZyZXFfY2VpbChkZXYsICZmcmVxKTsKPiA+ICsJCWlmIChJU19F
UlIob3BwKSkKPiA+ICsJCQlicmVhazsKPiA+ICsKPiA+ICsJCWZyZXFzW2luZGV4KytdID0gZnJl
cSsrOwo+IAo+IAlkZXZfcG1fb3BwX3B1dChvcHApID8KPiAKClllcyEgVGhhbmsgeW91IGZvciBm
aW5kaW5nIHRoYXQuIEknbGwgZml4IGl0IGluIHRoZSBuZXh0IGdvLWFyb3VuZC4KCkpvcmRhbgoK
LS0gClRoZSBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBpcyBhIG1lbWJlciBvZiBD
b2RlIEF1cm9yYSBGb3J1bSwKYSBMaW51eCBGb3VuZGF0aW9uIENvbGxhYm9yYXRpdmUgUHJvamVj
dApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
