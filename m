From: "Besogonov, Aleksei" <cyberax@amazon.com>
Subject: Re: [RFC PATCH 12/12] PM / hibernate: update the resume offset on
 SNAPSHOT_SET_SWAP_AREA
Date: Thu, 14 Jun 2018 19:50:15 +0000
Message-ID: <23092841-89AD-4D68-9790-AF0BD8702F0A@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
 <20180612205619.28156-13-anchalag@amazon.com> <20180614194515.GE17808@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614194515.GE17808@amd>
Content-Language: en-US
Content-ID: <D00608EDB57CB446B588E18069F89FA0@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, "Agarwal, Anchal" <anchalag@amazon.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "roger.pau@citrix.com" <roger.pau@citrix.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jgross@suse.com" <jgross@suse.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kamata, Munehisa" <kamatam@amazon.com>, "van der Linden, Frank" <fllinden@amazon.com>, "Vaidyeshwara, Vallish" <vallish@amazon.com>, "Anbalagane, Guru" <guruanb@amazon.com>, "Valentin, Eduardo" <eduval@amazon.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.>
List-Id: linux-pm@vger.kernel.org

KHNvcnJ5IGZvciB0b3AtcG9zdGluZykNCg0KV2VsbCwgbm90IGNvbXBsZXRlbHkgYnJva2VuLiBJ
dCBqdXN0IHJlcXVpcmVkIGEgcmVzdGFydCBmb3IgdGhlIG9mZnNldCBzZXR0aW5nIHRvIHRha2Ug
YW4gZWZmZWN0Lg0KDQrvu79PbiA2LzE0LzE4LCAxMjo0NiwgIlBhdmVsIE1hY2hlayIgPHBhdmVs
QHVjdy5jej4gd3JvdGU6DQoNCiAgICBIaSENCiAgICANCiAgICA+IEZyb206IEFsZWtzZWkgQmVz
b2dvbm92IDxjeWJlcmF4QGFtYXpvbi5jb20+DQogICAgPiANCiAgICA+IFRoZSBTTkFQU0hPVF9T
RVRfU1dBUF9BUkVBIGlzIHN1cHBvc2VkIHRvIGJlIHVzZWQgdG8gc2V0IHRoZSBoaWJlcm5hdGlv
bg0KICAgID4gb2Zmc2V0IG9uIGEgcnVubmluZyBrZXJuZWwgdG8gZW5hYmxlIGhpYmVybmF0aW5n
IHRvIGEgc3dhcCBmaWxlLg0KICAgID4gSG93ZXZlciwgaXQgZG9lc24ndCBhY3R1YWxseSB1cGRh
dGUgdGhlIHN3c3VzcF9yZXN1bWVfYmxvY2sgdmFyaWFibGUuIEFzDQogICAgPiBhIHJlc3VsdCwg
dGhlIGhpYmVybmF0aW9uIGZhaWxzIGF0IHRoZSBsYXN0IHN0ZXAgKGFmdGVyIGFsbCB0aGUgZGF0
YSBpcw0KICAgID4gd3JpdHRlbiBvdXQpIGluIHRoZSB2YWxpZGF0aW9uIG9mIHRoZSBzd2FwIHNp
Z25hdHVyZSBpbg0KICAgID4gbWFya19zd2FwZmlsZXMoKS4NCiAgICA+IA0KICAgID4gQmVmb3Jl
IHRoaXMgcGF0Y2gsIHRoZSBjb21tYW5kIGxpbmUgcHJvY2Vzc2luZyB3YXMgdGhlIG9ubHkgcGxh
Y2Ugd2hlcmUNCiAgICA+IHN3c3VzcF9yZXN1bWVfYmxvY2sgd2FzIHNldC4NCiAgICANCiAgICBB
cmUgeW91IHNheWluZyB0aGF0IHN1c3BlbmQtdG8tZmlsZSB3YXMgYnJva2VuLCBldmVuIG9uDQog
ICAgbm9uLXZpcnR1YWxpemVkIHN5c3RlbXM/DQogICAgDQogICAgSWYgc28sIHdlIG1heSB0aGlz
IHRvIGdvIGluIGZpcnN0Li4uDQogICAgCQkJCQkJCQlQYXZlbA0KICAgIAkJCQkJCQkJDQogICAg
LS0gDQogICAgKGVuZ2xpc2gpIGh0dHA6Ly93d3cubGl2ZWpvdXJuYWwuY29tL35wYXZlbG1hY2hl
aw0KICAgIChjZXNreSwgcGljdHVyZXMpIGh0dHA6Ly9hdHJleS5rYXJsaW4ubWZmLmN1bmkuY3ov
fnBhdmVsL3BpY3R1cmUvaG9yc2VzL2Jsb2cuaHRtbA0KICAgIA0KDQo=
