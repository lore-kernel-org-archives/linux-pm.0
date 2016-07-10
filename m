From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v8 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
Date: Sun, 10 Jul 2016 16:16:49 +1000
Message-ID: <27770.2915519059$1468131463@news.gmane.org>
References: <1467958853-35841-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1467958853-35841-11-git-send-email-shreyas@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1467958853-35841-11-git-send-email-shreyas@linux.vnet.ibm.com>
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
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, benh@au1.ibm.com, linux-pm@vger.kernel.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, maddy@linux.vnet.ibm.com, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

IlNocmV5YXMgQi4gUHJhYmh1IiA8c2hyZXlhc0BsaW51eC52bmV0LmlibS5jb20+IHdyaXRlczoK
Cj4gUE9XRVIgSVNBIHYzIGRlZmluZXMgYSBuZXcgaWRsZSBwcm9jZXNzb3IgY29yZSBtZWNoYW5p
c20uIEluIHN1bW1hcnksCj4gIGEpIG5ldyBpbnN0cnVjdGlvbiBuYW1lZCBzdG9wIGlzIGFkZGVk
Lgo+ICBiKSBuZXcgcGVyIHRocmVhZCBTUFIgbmFtZWQgUFNTQ1IgaXMgYWRkZWQgd2hpY2ggY29u
dHJvbHMgdGhlIGJlaGF2aW9yCj4gCW9mIHN0b3AgaW5zdHJ1Y3Rpb24uCj4KPiBTdXBwb3J0ZWQg
aWRsZSBzdGF0ZXMgYW5kIHZhbHVlIHRvIGJlIHdyaXR0ZW4gdG8gUFNTQ1IgcmVnaXN0ZXIgdG8g
ZW50ZXIKPiBhbnkgaWRsZSBzdGF0ZSBpcyBleHBvc2VkIHZpYSBpYm0sY3B1LWlkbGUtc3RhdGUt
bmFtZXMgYW5kCj4gaWJtLGNwdS1pZGxlLXN0YXRlLXBzc2NyIHJlc3BlY3RpdmVseS4gVG8gZW50
ZXIgYW4gaWRsZSBzdGF0ZSwKPiBwbGF0Zm9ybSBwcm92aWRlZCBwb3dlcl9zdG9wKCkgbmVlZHMg
dG8gYmUgaW52b2tlZCB3aXRoIHRoZSBhcHByb3ByaWF0ZQo+IFBTU0NSIHZhbHVlLgo+Cj4gVGhp
cyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIHRoaXMgbmV3IG1lY2hhbmlzbSBpbiBjcHVpZGxlIHBv
d2VybnYgZHJpdmVyLgo+Cj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tp
QGludGVsLmNvbT4KPiBDYzogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5v
cmc+Cj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Cj4gQ2M6IExvcmVuem8g
UGllcmFsaXNpIDxMb3JlbnpvLlBpZXJhbGlzaUBhcm0uY29tPgo+IENjOiBsaW51eC1wbUB2Z2Vy
Lmtlcm5lbC5vcmcKClJhZmFlbC9EYW5pZWwgZG8geW91IGd1eXMgd2FudCB0byBhY2sgb3IgbmFj
ayB0aGlzPwoKSSdsbCB0YWtlIHNpbGVuY2UgYXMgIm5vdCBib3RoZXJlZCIgYW5kIG1lcmdlIHRo
ZSB3aG9sZSBzZXJpZXMgdmlhIHRoZQpwb3dlcnBjIHRyZWUuCgpjaGVlcnMKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcg
bGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5v
cmcvbGlzdGluZm8vbGludXhwcGMtZGV2
