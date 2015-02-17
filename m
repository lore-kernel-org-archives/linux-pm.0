From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v6 0/7] Add initial support for DA9150 Charger &
 Fuel-Gauge IC
Date: Tue, 17 Feb 2015 18:15:11 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB534CBC@NB-EX-MBX01.diasemi.com>
References: <cover.1421854282.git.Adam.Thomson.Opensource@diasemi.com>
 <20150121165250.GG13715@earth.universe>
 <C1079F30-5D1D-45AA-A129-FE1E68EA5DC5@jic23.retrosnub.co.uk>
 <20150122075811.GO22024@x1>
 <2E89032DDAA8B9408CB92943514A0337AB52D71F@SW-EX-MBX01.diasemi.com>
 <20150217180401.GA13777@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.137]:34377 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753873AbbBQSPS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 13:15:18 -0500
In-Reply-To: <20150217180401.GA13777@earth.universe>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Jonathan Cameron <jic23@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Hartmut Knaack <knaack.h@gmx.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

T24gRmVicnVhcnkgMTcsIDIwMTUgMTg6MDQsIFNlYmFzdGlhbiBSZWljaGVsIHdyb3RlOg0KDQo+
IEhpLA0KPiANCj4gT24gTW9uLCBGZWIgMTYsIDIwMTUgYXQgMDk6NDU6NTlQTSArMDAwMCwgT3Bl
bnNvdXJjZSBbQWRhbSBUaG9tc29uXSB3cm90ZToNCj4gPiBKdXN0IGEgcXVpY2sgb25lIHRvIHNl
ZSB3aGF0IHRoZSBzdGF0dXMgaXMgb24gdGhpcyBwYXRjaCBzZXQ/IEp1c3QNCj4gPiBpbnRlcmVz
dGVkIGFzIHRvIHdoZW4gaXQnbGwgYmUgcHVsbGVkIGluLg0KPiANCj4gSSBwbGFuIHRvIHB1bGwg
aXQgaW50byBmb3ItbmV4dCBvbmNlIC1yYzEgaGFzIGJlZW4gdGFnZ2VkIChwcm9iYWJseQ0KPiBh
Ym91dCBhIHdlZWspLiBGZWVsIGZyZWUgdG8gc2VuZCBhIG5ldyB2ZXJzaW9uIHdpdGggdGhlIHN0
eWxlIGZpeGVzLg0KDQpPayB0aGFua3MgZm9yIHRoZSB1cGRhdGUuIFdpbGwgc2VlIGlmIEkgY2Fu
IGdldCB0aGUgdXBkYXRlcyBvdXQgYmVmb3JlIHRoZW4uDQoNClRoYW5rcw0KQWRhbQ0K
