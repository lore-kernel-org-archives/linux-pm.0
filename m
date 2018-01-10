From: "Sun, XinX" <xinx.sun@intel.com>
Subject: RE: [PATCH] powercap: add suspend and resume mechanism for SOC
 power limit
Date: Wed, 10 Jan 2018 00:23:21 +0000
Message-ID: <29BA90D9533CD34EA40DF8A796ED93C30409C0F1@CDSMSX104.ccr.corp.intel.com>
References: <1515486310-20330-1-git-send-email-xinx.sun@intel.com>
 <CAJZ5v0hr96bQZmfP3w0Kh2fGy9PxeU8gQRpHiHKtj9HNifRcVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:33397 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbeAJAXZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jan 2018 19:23:25 -0500
In-Reply-To: <CAJZ5v0hr96bQZmfP3w0Kh2fGy9PxeU8gQRpHiHKtj9HNifRcVw@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Han, Zhen" <zhen.han@intel.com>, "Wang, ChaoX M" <chaox.m.wang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

T2ssIGdvdCBpdC4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IHJqd3lzb2Nr
aUBnbWFpbC5jb20gW21haWx0bzpyand5c29ja2lAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgUmFm
YWVsIEouIFd5c29ja2kNClNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAxMCwgMjAxOCA4OjIxIEFN
DQpUbzogU3VuLCBYaW5YIDx4aW54LnN1bkBpbnRlbC5jb20+DQpDYzogUmFmYWVsIEouIFd5c29j
a2kgPHJqd0Byand5c29ja2kubmV0PjsgSGFuLCBaaGVuIDx6aGVuLmhhbkBpbnRlbC5jb20+OyBX
YW5nLCBDaGFvWCBNIDxjaGFveC5tLndhbmdAaW50ZWwuY29tPjsgTGludXggUE0gPGxpbnV4LXBt
QHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBwb3dlcmNhcDogYWRkIHN1
c3BlbmQgYW5kIHJlc3VtZSBtZWNoYW5pc20gZm9yIFNPQyBwb3dlciBsaW1pdA0KDQpPbiBUdWUs
IEphbiA5LCAyMDE4IGF0IDk6MjUgQU0sICA8eGlueC5zdW5AaW50ZWwuY29tPiB3cm90ZToNCj4g
RnJvbTogWmhlbiBIYW4gPHpoZW4uaGFuQGludGVsLmNvbT4NCj4NCj4gUEwxIGFuZCBQTDIgY291
bGQgYmUgdGhyb2xsZWQgb3IgZGUtdGhyb3R0bGVkIGJ5IFRoZXJtYWwgbWFuYWdlbWVudCB0byAN
Cj4gY29udHJvbCBTT0MgdGVtcGVyYXR1cmUuDQo+IEhvd2V2ZXIsIGN1cnJlbnRseSwgdGhlaXIg
dmFsdWUgd2lsbCBiZSByZXNldCB0byBkZWZhdWx0IHZhbHVlIGFmdGVyIA0KPiBvbmNlIHN5c3Rl
bSBzdXNwZW5kIGFuZCByZXN1bWUuDQo+IEFkZCBwbV9ub3RpZmllciB0byBzYXZlIFBMMSwgUEwy
IGJlZm9yZSBzeXN0ZW0gc3VzcGVjdCBhbmQgcmVzdG9yZSANCj4gUEwxLCBQTDIgYWZ0ZXIgc3lz
dGVtIHJlc3VtZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU3VuIFhpbnggPHhpbnguc3VuQGludGVs
LmNvbT4NCg0KVGhlcmUgaXMgYSBmb3JtYWwgaXNzdWUgaGVyZS4NCg0KV2UgbmVlZCBhIFNpZ25l
ZC1vZmYtYnk6IHRhZyBmcm9tIFpoZW4gSGFuIHRvby4NCg0KVGhhbmtzLA0KUmFmYWVsDQo=
