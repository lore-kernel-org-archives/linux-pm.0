From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [RFC patch 2/2] ARM: at91: cpuidle: move the driver to
 drivers/cpuidle directory
Date: Mon, 15 Apr 2013 18:00:41 +0200
Message-ID: <20130415160041.GF15139@game.jcrosoft.org>
References: <1366032598-23053-1-git-send-email-daniel.lezcano@linaro.org>
 <1366032598-23053-3-git-send-email-daniel.lezcano@linaro.org>
 <20130415142047.GE15139@game.jcrosoft.org>
 <516C10C5.4050107@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <516C10C5.4050107@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nicolas.ferre@atmel.com, rjw@sisk.pl, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

T24gMTY6MzcgTW9uIDE1IEFwciAgICAgLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToKPiBPbiAwNC8x
NS8yMDEzIDA0OjIwIFBNLCBKZWFuLUNocmlzdG9waGUgUExBR05JT0wtVklMTEFSRCB3cm90ZToK
PiA+IE9uIDE1OjI5IE1vbiAxNSBBcHIgICAgICwgRGFuaWVsIExlemNhbm8gd3JvdGU6Cj4gPj4g
V2UgZG9uJ3QgaGF2ZSBhbnkgZGVwZW5kZW5jeSB3aXRoIHRoZSBTb0Mgc3BlY2lmaWMgY29kZS4K
PiA+Pgo+ID4+IE1vdmUgdGhlIGRyaXZlciB0byB0aGUgZHJpdmVycy9jcHVpZGxlIGRpcmVjdG9y
eS4KPiA+Pgo+ID4+IEFkZCBOaWNvbGFzIEZlcnJlIGFzIGF1dGhvciBvZiB0aGUgZHJpdmVyLCBz
byBpdCB3aWxsIGJlIGluIGNvcHkgb2YgdGhlIGVtYWlscy4KPiA+Pgo+ID4+IFNpZ25lZC1vZmYt
Ynk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgo+ID4gcGxlYXNl
IHVzZSAtTSB3aGVuIGdlbmVyYXRpbmcgdGhlIHBhdGNoCj4gCj4gT2gsIHJpZ2h0LiBUaGFua3Mg
Zm9yIHJlbWluZGluZyBtZSB0aGUgb3B0aW9uLgo+IAo+IFsgLi4uIF0KPiAKPiA+PiArI2luY2x1
ZGUgPGxpbnV4L21vZHVsZS5oPgo+ID4+ICsjaW5jbHVkZSA8bGludXgvaW5pdC5oPgo+ID4+ICsj
aW5jbHVkZSA8bGludXgvY3B1aWRsZS5oPgo+ID4+ICsjaW5jbHVkZSA8YXNtL2NwdWlkbGUuaD4K
PiA+PiArCj4gPj4gKyNkZWZpbmUgQVQ5MV9NQVhfU1RBVEVTCTIKPiA+PiArCj4gPj4gK2V4dGVy
biB2b2lkICgqYXQ5MV9zdGFuZGJ5X29wcykodm9pZCk7Cj4gPiByZWFsbHkgZG9uJ3QgbGlrZSBj
YW4gd2UgcGFzcyBpdCB2aWEgdGhlIHBtPwo+IAo+IEkgYWdyZWUsIGl0IGlzIGhhY2tpc2guIENh
biB5b3UgZWxhYm9yYXRlIHdoZW4geW91IHNheSAicGFzcyBpdCB2aWEgdGhlCj4gcG0iID8KCkkg
d2FzIHRoaW5raW5nIGFib3V0IGl0CgpJIHdvdWxkIGV2ZW4gcHJlZmVyIHRvIGhhdmUgYSBwbGF0
ZnJvbSBkcml2ZXIgdGhhdCBwYXNzIGl0IHZpYSBwbGF0Zm9ybSBkYXRhCmV2ZW4gaW4gRFQKCmJ1
dCBub3Qgc29tZXRoaW5nIHRoYXQgY2FuIHRvdWNoIGdsb2JhbGx5CgphbmQgZm9yIGRyaXZlcnMg
SSBwcmVmZXIgdG8gZG8gbm90IHVzZSBjcHVfaXMgb25seSBmb3IgdGhlIGNvcmUKCkJlc3QgUmVn
YXJkcywKSi4KPiAKPiAKPiAKPiAtLSAKPiAgPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFy
by5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcwo+IAo+IEZvbGxvdyBM
aW5hcm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8
Cj4gPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo+IDxodHRwOi8v
d3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nCj4gCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
