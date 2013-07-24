From: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: RE: [PATCH 1/2] cpuidle: fix cpu idle driver as a module can not
 remove
Date: Wed, 24 Jul 2013 02:26:12 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259FDCB28@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
 <8766398.Myt5gdDlbY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:54334
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864Ab3GXC0R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2013 22:26:17 -0400
In-Reply-To: <8766398.Myt5gdDlbY@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgW21haWx0bzpyandAc2lzay5wbF0NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDI0LCAyMDEz
IDU6MzMgQU0NCj4gVG86IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNA0KPiBDYzogZGFuaWVsLmxlemNh
bm9AbGluYXJvLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eHBwYy0NCj4gZGV2
QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGNwdWlkbGU6IGZp
eCBjcHUgaWRsZSBkcml2ZXIgYXMgYSBtb2R1bGUgY2FuIG5vdA0KPiByZW1vdmUNCj4gDQo+IE9u
IFR1ZXNkYXksIEp1bHkgMjMsIDIwMTMgMDU6Mjg6MDAgUE0gRG9uZ3NoZW5nIFdhbmcgd3JvdGU6
DQo+ID4gRnJvbTogV2FuZyBEb25nc2hlbmcgPGRvbmdzaGVuZy53YW5nQGZyZWVzY2FsZS5jb20+
DQo+ID4NCj4gPiBUaGUgbW9kdWxlIGNhbiBub3QgYmUgcmVtb3ZlZCB3aGVuIGV4ZWN1dGUgInJt
bW9kIi4gcm1tb2Qgbm90IHVzZQ0KPiA+ICItLWZvcmNlIi4NCj4gPg0KPiA+IExvZzoNCj4gPiBy
b290On4jIHJtbW9kIGNwdWlkbGUtZTUwMA0KPiA+IGluY3NbOV0sIGRlY3NbMV0NCj4gPiBybW1v
ZDogY2FuJ3QgdW5sb2FkICdjcHVpZGxlX2U1MDAnOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2
YWlsYWJsZQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2FuZyBEb25nc2hlbmcgPGRvbmdzaGVu
Zy53YW5nQGZyZWVzY2FsZS5jb20+DQo+IA0KPiBDYW4geW91IHBsZWFzZSBjaGVjayB0aGUgY3Vy
cmVudCBsaW51eC1uZXh0IGJyYW5jaCBvZiB0aGUgbGludXgtcG0uZ2l0DQo+IHRyZWUNCj4gYW5k
IHNlZSBpZiB0aGF0IGRvZXNuJ3QgY29uZmxpY3Qgd2l0aCB0aGUgbWF0ZXJpYWwgaW4gdGhlcmU/
DQo+IA0KPiBBbHNvIHBsZWFzZSBleHBsYWluIGluIHRoZSBjaGFuZ2Vsb2cgaG93IHlvdXIgY2hh
bmdlcyBoZWxwIHRvIGZpeCB0aGUNCj4gcHJvYmxlbS4NCj4gDQpZZXMsIExpbnV4LW5leHQgYnJh
bmNoIGFsc28gaGF2ZSB0aGlzIHByb2JsZW0uDQoNClNob3VsZCBJIGJhc2Ugb24gTGludXgtbmV4
dCB0byBmaXggdGhpcyBwcm9ibGVtPw0KDQpUaGFua3MuDQotIGRvbmdzaGVuZw0K

