From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V5 2/2] thermal: broadcom: add Northstar thermal driver
Date: Fri, 14 Apr 2017 14:16:36 +0200
Message-ID: <6dd2617d-a8a8-d7a4-53a4-7ebcb274573c@milecki.pl>
References: <20170331201124.656-1-zajec5@gmail.com>
 <20170403154829.29780-1-zajec5@gmail.com>
 <20170403154829.29780-2-zajec5@gmail.com>
 <20170407044218.GA12447@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170407044218.GA12447@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Ray Jui <rjui@broadcom.com>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, Jon Mason <jon.mason@broadcom.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

T24gMDQvMDcvMjAxNyAwNjo0MiBBTSwgRWR1YXJkbyBWYWxlbnRpbiB3cm90ZToKPiBPbiBNb24s
IEFwciAwMywgMjAxNyBhdCAwNTo0ODoyOVBNICswMjAwLCBSYWZhxYIgTWnFgmVja2kgd3JvdGU6
Cj4+IEZyb206IFJhZmHFgiBNacWCZWNraSA8cmFmYWxAbWlsZWNraS5wbD4KPj4KPj4gTm9ydGhz
dGFyIGlzIGEgU29DIGZhbWlseSBjb21tb25seSB1c2VkIGluIGhvbWUgcm91dGVycy4gVGhpcyBj
b21taXQKPj4gYWRkcyBhIGRyaXZlciBmb3IgY2hlY2tpbmcgQ1BVIHRlbXBlcmF0dXJlLiBBcyBO
b3J0aHN0YXIgUGx1cyBzZWVtcyB0bwo+PiBhbHNvIGhhdmUgdGhpcyBJUCBibG9jayB0aGlzIG5l
dyBzeW1ib2wgZ2V0cyBBUkNIX0JDTV9JUFJPQyBkZXBlbmRlbmN5Lgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBSYWZhxYIgTWnFgmVja2kgPHJhZmFsQG1pbGVja2kucGw+Cj4+IFNpZ25lZC1vZmYtYnk6
IEpvbiBNYXNvbiA8am9uLm1hc29uQGJyb2FkY29tLmNvbT4KPgo+IElmIG5vIG9iamVjdGlvbiwg
SSBhbSBhcHBseWluZyB0aGlzIHNlcmllcy4KCkNvb2wsIGhvcGVmdWxseSB0aGVyZSBhcmVuJ3Qg
YW55IG1vcmUgb2JqZWN0aW9ucyA6KSBPbmNlIGFwcGxpZWQgc2hvdWxkIEkKZXhwZWN0IHRoaXMg
aW4KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZXZhbGVu
dGkvbGludXgtc29jLXRoZXJtYWwuZ2l0L2xvZy8/aD1uZXh0Cj8KClRoYXQgd291bGQgYWxsb3cg
bWUgdG8gbW92ZSBiY20yODM1X3RoZXJtYWwuYyB0byB0aGUgYnJvYWRjb20gc3ViZGlyLgoKCj4+
ICtjb25zdCBzdHJ1Y3QgdGhlcm1hbF96b25lX29mX2RldmljZV9vcHMgbnNfdGhlcm1hbF9vcHMg
PSB7Cj4KPiBtaW5vciBjb3JyZWN0aW9uIGhlcmU6Cj4KPiAtY29uc3Qgc3RydWN0IHRoZXJtYWxf
em9uZV9vZl9kZXZpY2Vfb3BzIG5zX3RoZXJtYWxfb3BzID0gewo+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzIG5zX3RoZXJtYWxfb3BzID0gewo+Cj4gYnV0
IEkgYW0gYXBwbHlpbmcgdGhpcyBhbHJlYWR5IGluIG15IHRyZWUuCj4KPj4gKwkuZ2V0X3RlbXAg
PSBuc190aGVybWFsX2dldF90ZW1wLAo+PiArfTsKClRoYW5rIHlvdSEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
