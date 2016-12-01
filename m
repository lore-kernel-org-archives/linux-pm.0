From: "Luc, Piotr" <Piotr.Luc@intel.com>
Subject: Re: [RESEND PATCH 11/11] tools/power turbostat: enable turbostat to
 support Knights Mill (KNM)
Date: Thu, 1 Dec 2016 11:17:56 +0000
Message-ID: <1480591045.4677.45.camel@intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
         <20161013153105.2517-12-piotr.luc@intel.com>
         <CAJvTdKmTyVg0UeBWFggj4RsW3hbtK5e+-rAZyfHUFvwAqtEPuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJvTdKmTyVg0UeBWFggj4RsW3hbtK5e+-rAZyfHUFvwAqtEPuw@mail.gmail.com>
Content-Language: en-US
Content-ID: <7C5E99D854E1EC40A92F33CF9B95CEFC@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "dougthompson@xmission.com" <dougthompson@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "mingo@redhat.com" <mingo@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCAyMDE2LTEyLTAxIGF0IDAxOjQ3IC0wNTAwLCBMZW4gQnJvd24gd3JvdGU6DQo+IFBp
b3RyLA0KPiBUaGFua3MgZm9yIHNlbmRpbmcgdGhlIHBhdGNoLCBJJ3ZlIG1hZGUgdGhpcyBjaGFu
Z2UgdG8gbXkgdHVyYm9zdGF0DQo+IGJyYW5jaCBmb3IgNC4xMC4NCj4gDQo+IEkgZGlkIG5vdCBh
cHBseSB5b3VyIHBhdGNoIGRpcmVjdGx5IGJlY2F1c2UgZm9yIHNvbWUgcmVhc29uIGl0IGRpZG4n
dA0KPiBhcHBlYXIgaW4gcGF0Y2h3b3JrIGZvciBsaW51eC1wbSwNCj4gb25seSBmb3IgbGttbCwg
d2hpY2ggSSBkbyBub3QgcmV2aWV3Lg0KDQpUaGUgbWlzc2luZyBmcm9tIGxpbnV4LXBtIHdhcyBt
eSBtaXN0YWtlIGR1ZSB0byBsYWNrIG9mIGV4cGVyaWVuY2UgYW5kDQpwZXJzcGljYWNpdHk7IEkg
ZGlkIG5vdCBhZGQgdGhlIGxpbnV4LXBtIGxpc3QgdG8gY2MgYmVjYXVzZSBJIGNvdWxkIG5vdA0K
ZmluZCBhbiBlbnRyeSBmb3IgdHVyYm9zdGF0IG9uIE1BSU5UQUlORVJTIGZpbGUuIFByb2JhYmx5
LCBpdCBpcw0KbWVudGlvbmVkIGltcGxpY2l0bHkgYnV0IEkgZGlkIG5vdCBjb21lIGFjcm9zcyBp
dC4NCj4gDQo+IEFsc28sIHlvdXIgcGF0Y2ggZGVwZW5kZWQgb24geW91ciBzdHlsZSB1cGRhdGUg
cGF0Y2ggdG8gdXNlIHRoZSBtb2RlbA0KPiAjIG1hY3Jvcy4NCj4gVW5mb3J0dW5hdGVseSB3aGF0
IHlvdSBkaWQgbm90IGtub3cgd2FzIHRoYXQgSSdkIGFscmVhZHkgYXBwbGllZCBhDQo+IHNsaWdo
dGx5IGRpZmZlcmVudCBzdHlsZSB1cGRhdGUgcGF0Y2guDQo+IChhbmQgaXQgd2FzIG15IGZhdWx0
IHRoYXQgSSBkaWQgbm90IHB1c2ggaXQgdXBzdHJlYW0gYmVmb3JlIG15IHN1bW1lcg0KPiBzYWJi
YXRpY2FsLCBzb3JyeSkNCg0KTlAsIHRoaXMgd2FzIGFuIGVhc3kgY2hhbmdlIG1hZGUgYXV0b21h
dGljYWxseSBieSBteSBzY3JpcHQuDQoNCj4gDQo+IEluIGdlbmVyYWwsIHRob3VnaCwgYSBnb29k
IHN0cmF0ZWd5IHdoZW4gbWl4aW5nIHN0eWxlIGFuZA0KPiBmdW5jdGlvbmFsaXR5IHBhdGNoZXMN
Cj4gaXMgdG8gZG8gdGhlIGZ1bmN0aW9uYWxpdHkgZmlyc3QuwqDCoFRoZSByZWFzb24gaXMgYm90
aCB0aGF0IHN0eWxlDQo+IHBhdGNoZXMgdGVuZCB0byBjb25mbGljdCBtb3JlLA0KPiBhbmQgeW91
IGRvbid0IHdhbnQgdGhlbSB0byBob2xkIHVwIHRoZSBmdW5jdGlvbmFsaXR5Lg0KPiBBbHNvLCBp
ZiB5b3VyIGZ1bmN0aW9uYWxpdHkgcGF0Y2ggZG9lcyBub3QgZGVwZW5kIG9uIHN0eWxlLA0KPiBp
dCBpcyBlYXNpZXIgdG8gYmFja3BvcnQgdG8gZGlzdHJvcyB3aG8gYXZvaWQgc3R5bGUgdXBkYXRl
cy4NCg0KVGhhbmtzIGZvciB0aGUgdGlwLg0KSG93ZXZlciwgaW4gdGhpcyBjYXNlLCBJIGdvdCBj
b21tZW50cyB0byB1c2UgdGhlIG1hY3JvcyBpbnN0ZWFkIHJhdw0KbnVtYmVycyBpbiBteSBwYXRj
aCBhbmQgcmVtb3ZlIHVubmVjZXNzYXJ5IGNvbW1lbnRzLiBJdCBjYXVzZWQgdGhhdCB0aGUNCnN0
eWxlIHBhdGNoIGNhbWUgZmlyc3QuDQoNClRoYW5rcw0KUGlvdHI=
