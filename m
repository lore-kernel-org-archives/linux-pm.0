From: "Luc, Piotr" <Piotr.Luc@intel.com>
Subject: Re: [RESEND PATCH 06/11] cpufreq: intel_pstate: Add Knights Mill
 CPUID
Date: Tue, 25 Oct 2016 10:48:02 +0000
Message-ID: <1477392172.9496.2.camel@intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
         <20161013153105.2517-7-piotr.luc@intel.com>
         <1476381119.114531.61.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476381119.114531.61.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <BC81C633AE69C3409992F9F9F758CF79@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
List-Id: linux-pm@vger.kernel.org

SGkNCg0KQ291bGQgeW91IHRlbGwgbWUgd2hhdCBtb3JlIGRvIEkgbmVlZCB0byBkbyB0byBnZXQg
dGhlIHBhdGNoDQphY2NlcHRlZD8NCg0KVGhlIG1lbnRpb25lZCBwYXRoIDAzLzExIGlzIGFscmVh
ZHkgbWVyZ2VkIGluIDQuOS5yYzIuDQoNClRoYW5rcw0KUGlvdHINCg0KT24gVGh1LCAyMDE2LTEw
LTEzIGF0IDEwOjUxIC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdyb3RlOg0KPiBPbiBUaHUs
IDIwMTYtMTAtMTMgYXQgMTc6MzEgKzAyMDAsIFBpb3RyIEx1YyB3cm90ZToNCj4gPiANCj4gPiBB
ZGQgS25pZ2h0cyBNaWxsIChLTk0pIHRvIHRoZSBsaXN0IG9mIENQVUlEcyBzdXBwb3J0ZWQgYnkN
Cj4gPiBpbnRlbF9wc3RhdGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUGlvdHIgTHVjIDxw
aW90ci5sdWNAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBEYXZlIEhhbnNlbiA8ZGF2ZS5o
YW5zZW5AaW50ZWwuY29tPg0KPiA+IENjOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5w
YW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogTGVuIEJyb3duIDxsZW5iQGtlcm5l
bC5vcmc+DQo+ID4gQ2M6ICJSYWZhZWwgSi4gV3lzb2NraSIgPHJqd0Byand5c29ja2kubmV0Pg0K
PiA+IENjOiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KPiA+IENjOiBs
aW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiANCj4gQWNrZWQtYnk6IFNyaW5pdmFzIFBhbmRydXZhZGEgPHNyaW5pdmFzLnBhbmRy
dXZhZGFAbGludXguaW50ZWwuY29tPg0KPiANCj4gPiANCj4gPiAtLS0NCj4gPiBUaGlzIHBhdGNo
IGRlcGVuZHMgb24gW1BBVENIIDAzLzExXSB4ODYvY3B1L2ludGVsOiBBZGQgS25pZ2h0cw0KPiA+
IE1pbGzCoA0KPiA+IHRvIEludGVsIGZhbWlseQ0KPiA+IA0KPiA+IMKgZHJpdmVycy9jcHVmcmVx
L2ludGVsX3BzdGF0ZS5jIHwgMSArDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5j
