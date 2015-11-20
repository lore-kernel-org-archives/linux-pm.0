From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 1/2] cpufreq, intel_pstate, Fix limits->max_policy_pct
 rounding error
Date: Fri, 20 Nov 2015 23:57:56 +0000
Message-ID: <1448063875.9857.6.camel@intel.com>
References: <1448022757-7856-1-git-send-email-prarit@redhat.com>
		 <1448022757-7856-2-git-send-email-prarit@redhat.com>
		 <20151120131833.GD3957@ubuntu> <564F37C8.60307@redhat.com>
		 <20151120151944.GE3957@ubuntu> <564F3FBA.6030806@redhat.com>
	 <1448049757.4914.3.camel@intel.com> <564FB111.5050403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14494 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759681AbbKTX56 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Nov 2015 18:57:58 -0500
In-Reply-To: <564FB111.5050403@redhat.com>
Content-Language: en-US
Content-ID: <9206B1231F401C40B394C65E209C5399@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "prarit@redhat.com" <prarit@redhat.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "kristen@linux.intel.com" <kristen@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Yates, Alexandra" <alexandra.yates@intel.com>

T24gRnJpLCAyMDE1LTExLTIwIGF0IDE4OjQ3IC0wNTAwLCBQcmFyaXQgQmhhcmdhdmEgd3JvdGU6
DQo+IA0KW2N1dF0NCj4gVGhlIC0xIGRpZmZlcmVuY2UgaGVyZSBpcyBub3QgdW5leHBlY3RlZCBn
aXZlbiB0aGUgb3RoZXIgcHJvYmFibGUgcm91bmRpbmcNCj4gZXJyb3JzIGluIHRoZSBmcmVxdWVu
Y3kgY29kZS4NClllcy4gSW50ZWwgUCBzdGF0ZSBjcHVmcmVxIGludGVyZmFjZSBpcyBub3Qgb3B0
aW1hbC4gV2UgZXZlbiBkZWJhdGUNCndoZXRoZXIgd2Ugc2hvdWxkIGhhdmUgdGhpcyBpbnRlcmZh
Y2UgYXQgYWxsLg0KDQo+ICAgSSBoYXZlIGEgZmVlbGluZyB0aGF0IG5vIG9uZSByZWFsbHkgaGFz
IGRvbmUgYW4NCj4gaW4gZGVwdGggcmV2aWV3IHRvIGZpbmQgdGhlIGVycm9ycy4gIEknbSBub3Qg
Z29pbmcgdG8gYmVjYXVzZSBJJ20gcHJldHR5IHN1cmUNCj4gSS93ZSBjYW4gY29udmluY2UgdXNl
cnMgdGhhdCAzMjAwID09IDMxOTkuOTggOykuICBGV0lXLCBJJ3ZlIGFsc28gd29uZGVyZWQgaWYN
Cj4gdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgbWFya2V0aW5nIGZyZXF1ZW5jeSBhbmQgdGhl
IFRTQyBmcmVxdWVuY3kgKHdoaWNoIGluDQo+IHRoZW9yeSBlcXVhbHMgdGhlIG1hcmtldGluZyBm
cmVxdWVuY3kpIGNhbiBjYXVzZSB0aGlzIHNvcnQgb2YgZXJyb3IuDQpXZSBkb24ndCBldmVuIHJl
cXVlc3QgY29ycmVjdCBwc3RhdGUgaGVyZSwgc28gd2Ugd2lsbCBub3QgZ2V0IHRoYXQuIEJ1dA0K
aW4gdGhpcyBjYXNlIGluIHR1cmJvIHJlZ2lvbiBpcyBub3QgY29udHJvbGxhYmxlIChhZnRlciBT
YW5keWJyaWRnZSApDQphYm92ZSBzb21ldGhpbmcgY2FsbGVkIHR1cmJvIGFjdGl2YXRpb24gcmF0
aW8uIFNvIG5vdCBhIGJpZyBkZWFsLg0KQXMgbG9uZyBhcyB3ZSBjYW4gc2V0IGF0IGxvd2VyIGVu
ZCB3ZSBhcmUgZmluZS4NCj4gDQoNClRoYW5rcywNClNyaW5pdmFzDQoNCj4gT09DIGRpZCB5b3Ug
dHJ5IGxvYWRpbmcgdGhlIHN5c3RlbSBkb3duICh3aXRoIGEga2VybmVsIGJ1aWxkKSBhbmQgc3dp
dGNoaW5nDQo+IGJldHdlZW4gZnJlcXVlbmNpZXM/ICBUaGF0J3MgYSBnb29kIHdheSB0byBzZWUg
dGhlIGVmZmVjdCBvZiB0aGUgdHVyYm8gc3RhdGVzLg0KPiBJIHdvdWxkIGV4cGVjdCB0aGF0IHRo
ZSB0dXJibyBzdGF0ZSBoaXRzIGEgbWF4aW11bSBvZiBhYm91dCA3NSUgb2YgdGhlIG1heCB0dXJi
bw0KPiBzdGF0ZSB2YWx1ZSAoYmFzZWQgb24gZXhwZXJpbWVudCkgc28gdGhlIGRpZmZlcmVuY2Vz
IHNob3VsZCBiZSBsYXJnZXIgYXQgdGhlDQo+IGhpZ2ggZW5kLg0KPiANCj4gUC4NCg0K
