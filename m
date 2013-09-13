From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 00/12] CPU idle for Armada XP
Date: Fri, 13 Sep 2013 17:19:17 +0200
Message-ID: <52332CF5.8050404@linaro.org>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <20130913110043.GJ19363@lunn.ch> <5232F43D.4040404@free-electrons.com>
 <871u4shj6i.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <871u4shj6i.fsf@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ike Pan <ike.pan@canonical.com>, Atsushi Yamagata <yamagata@plathome.co.jp>, Nadav Haklai <nadavh@marvell.com>, David Marlin <dmarlin@redhat.com>, Yehuda Yitschak <yehuday@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Dan Frazier <dann.frazier@canonical.com>, Eran Ben-Avi <benavi@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Leif Lindholm <leif.lindholm@arm.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tomonori Kimura <kimura@plathome.co.jp>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Jon Masters <jcm@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Hironobu Shibata <h-shibata@plathome.co.jp>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.orgThomas Petazzoni <tho>
List-Id: linux-pm@vger.kernel.org

T24gMDkvMTMvMjAxMyAwNDo0OCBQTSwgS2V2aW4gSGlsbWFuIHdyb3RlOgo+IEdyZWdvcnkgQ0xF
TUVOVCA8Z3JlZ29yeS5jbGVtZW50QGZyZWUtZWxlY3Ryb25zLmNvbT4gd3JpdGVzOgo+IAo+PiBP
biAxMy8wOS8yMDEzIDEzOjAwLCBBbmRyZXcgTHVubiB3cm90ZToKPj4+Cj4+PiBPbiBGcmksIFNl
cCAxMywgMjAxMyBhdCAxMjowNjoyOVBNICswMjAwLCBHcmVnb3J5IENMRU1FTlQgd3JvdGU6Cj4+
Pj4gSGVsbG8sCj4+Pj4KPj4+PiBUaGlzIHBhdGNoIHNldCBhZGRzIHRoZSBDUFUgaWRsZSBzdXBw
b3J0IGZvciBBcm1hZGEgWFAgYW5kIHByZXBhcmVzCj4+Pj4gdGhlIHN1cHBvcnQgZm9yIEFybWFk
YSAzNzAuIFRoaXMgd2FzIGJhc2VkIG9uIHRoZSB3b3JrIG9mIE5hZGF2Cj4+Pj4gSGFrbGFpLgo+
Pj4KPj4+IEhpIEdyZWdvcnkuCj4+Pgo+Pj4gS2lya3dvb2QgaGFzIHRoZSBhYmlsaXR5IHRvIHB1
dCB0aGUgRERSIGludG8gc2VsZiByZWZyZXNoIG1vZGUsIHdoaWNoCj4+PiBpcyB1c2VkIGFzIHBh
cnQgb2YgdGhlIHNlY29uZCBsZXZlbCBpZGxlIG1vZGUuIERvZXMgMzcwL1hQIGhhdmUgdGhpcz8K
Pj4KPj4gSW5kZWVkIHRoZXJlIGlzIGEgc2VsZiByZWZyZXNoIGJpdCBvbiBhIEREUiByZWxhdGVk
IHJlZ2lzdGVyLiBJIHRob3VnaHQKPj4gdGhpcyBraW5kIG9mIGZlYXR1cmUgaXMgbW9yZSBsaWtl
bHkgdXNlZCBmb3Igc3VzcGVuZCB0byByYW0uCj4+Cj4+IFdlIHBsYW4gdG8gYWxzbyBzdWJtaXQg
dGhlIHN1c3BlbmQgdG8gcmFtIGJ1dCBub3QgaW1tZWRpYXRlbHkuCj4+Cj4+Pgo+Pj4gRm9yIFhQ
LCB3aXRoIGl0IGJlaW5nIFNNUCwgaXQgd291bGQgYmUgYSBiaXQgbW9yZSBjb21wbGV4LCBzaW5j
ZSB5b3UKPj4+IHdvdWxkIG5vdCB3YW50IHRvIHVzZSBpdCB1bmxlc3MgYWxsIENQVXMgd2VyZSBp
ZGxlLgo+Pgo+PiBJIHdvbmRlciBob3cgdGhlIG90aGVycyBTTVAgQVJNIFNvQ3MgZGVhbCB3aXRo
IGl0LCBJIGhvcGUgdGhpcyB0aW1lCj4+IHRoZXJlIHdpbGwgYmUgYSBmcmFtZXdvcmsgYXZhaWxh
YmxlIGFuZCB3ZSB3b24ndCBoYXZlIHRvIGNyZWF0ZSBpdCEgOykKPiAKPiBZb3Ugc2hvdWxkbid0
IGhhdmUgdG8gaW52ZW50IGFueXRoaW5nIGhlcmUuCj4gCj4gRm9yIGxvdy1wb3dlciBzdGF0ZXMg
dGhhdCByZXF1aXJlIGFsbCBDUFVzIHRvIGJlIGlkbGUsIHdlIGhhdmUgImNvdXBsZWQiCj4gQ1BV
aWRsZSBzdGF0ZXMgKGMuZi4gZHJpdmVycy9jcHVpZGxlL2NvdXBsZWQuKSAgT01BUCBhbmQgVGVn
cmEgYXJlIHVzaW5nCj4gdGhpcywgYnV0IEkgYmVsaWV2ZSBEYW5pZWwgd2FudHMgdG8gbW92ZSBh
d2F5IGZyb20gdGhpcywgc28gSSdsbCBsZXQgaGltCj4gZWxhYm9yYXRlLgoKWWVzLCBJIHdvdWxk
IG5vdCByZWNvbW1lbmQgdG8gdXNlIHRoZSAiY291cGxlZCIgaWRsZSBzdGF0ZXMgdW5sZXNzIHlv
dQpoYXZlIGEgZ29vZCByZWFzb24gdG8gZG8gdGhhdCAoZWcuIG9ubHkgQ1BVMCBjYW4gZG8gc2V0
IHRoZSBQTVUpLgoKSWYgdGhlIGJvYXJkIHByb3ZpZGVzIGVub3VnaCBtZWNoYW5pc21zIHdpdGgg
dGhlIFBNU1UsIHRoZXJlIGlzIGFuCmFsdGVybmF0ZSwgbG9ja2xlc3MsIHN5bmMgYWxnb3JpdGht
LCB3aGljaCBjYW4gYmUgcmV1c2VkLCBpbiB0aGUgdXg1MDAncwpjcHVpZGxlIGRyaXZlciAoYy5m
LiBkcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS11eDUwMC5jKS4KCk90aGVyd2lzZSwgSSByZWNvbW1l
bmQgdG8gaGF2ZSBhIGxvb2sgYXQgTUNQTSAoYy5mCmRyaXZlcnMvY3B1aWRsZS9jcHVpZGxlLWJp
Z19saXR0bGUuYykuCgogIC0tIERhbmllbAoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+
IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93
IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29r
IHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3
dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
