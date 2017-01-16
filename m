From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v2 1/6] power: bq24190_charger: Fix irq trigger to IRQF_TRIGGER_FALLING
Date: Sun, 15 Jan 2017 22:06:16 -0800
Message-ID: <CAKvHMgRHAJ8LAbpTByaYS1ECHK_gtT1ZH=Vs7umr_003ENEG7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a114aad2c4c481f05462ffb2e
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35919 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdAPGGR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 01:06:17 -0500
Received: by mail-it0-f65.google.com with SMTP id o138so11285083ito.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2017 22:06:17 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, "Mark A . Greer" <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

--001a114aad2c4c481f05462ffb2e
Content-Type: text/plain; charset=UTF-8



--001a114aad2c4c481f05462ffb2e
Content-Type: text/plain; charset=US-ASCII; name="patch-v2-1of6.txt"
Content-Disposition: attachment; filename="patch-v2-1of6.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixznh3300

VGhlIGludGVycnVwdCBzaWduYWwgaXMgVFJJR0dFUl9GQUxMSU5HLiBUaGlzIGlzIGlzIHNwZWNp
ZmllZCBpbiB0aGUNCmRhdGEgc2hlZXQgUElOIEZVTkNUSU9OUzogIlRoZSBJTlQgcGluIHNlbmRz
IGFjdGl2ZSBsb3csIDI1NnVzDQpwdWxzZSB0byBob3N0IHRvIHJlcG9ydCBjaGFyZ2VyIGRldmlj
ZSBzdGF0dXMgYW5kIGZhdWx0LiINCg0KQWxzbyB0aGUgZGlyZWN0aW9uIGNhbiBiZSBzZWVuIGlu
IHRoZSBkYXRhIHNoZWV0IEZpZ3VyZSAxICJCUTI0MTkwDQp3aXRoIEQrL0QtIERldGVjdGlvbiBh
bmQgVVNCIE9uLVRoZS1HbyAoT1RHKSIgd2hpY2ggc2hvd3MgYSAxMGsNCnB1bGwtdXAgcmVzaXN0
b3IgaW5zdGFsbGVkIGZvciB0aGUgc2FtcGxlIGNvbmZpZ3VyYXRpb25zLg0KDQpGaXhlczogZDdi
ZjM1M2ZkMGFhMyAoImJxMjQxOTBfY2hhcmdlcjogQWRkIHN1cHBvcnQgZm9yIFRJIEJRMjQxOTAg
QmF0dGVyeSBDaGFyZ2VyIikNCkNjOiBNYXJrIEEuIEdyZWVyIDxtZ3JlZXJAYW5pbWFsY3JlZWsu
Y29tPg0KQ2M6IE1hdHQgUmFub3N0YXkgPG1hdHRAcmFub3N0YXkuY29uc3VsdGluZz4NCkNjOiBU
b255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPg0KU2lnbmVkLW9mZi1ieTogTGlhbSBCcmVj
ayA8a2VybmVsQG5ldHdvcmtpbXByb3YubmV0Pg0KLS0tDQogZHJpdmVycy9wb3dlci9zdXBwbHkv
YnEyNDE5MF9jaGFyZ2VyLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyL3N1cHBseS9icTI0
MTkwX2NoYXJnZXIuYyBiL2RyaXZlcnMvcG93ZXIvc3VwcGx5L2JxMjQxOTBfY2hhcmdlci5jDQpp
bmRleCBmNTc0NmI5Li42OTRjMDg4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wb3dlci9zdXBwbHkv
YnEyNDE5MF9jaGFyZ2VyLmMNCisrKyBiL2RyaXZlcnMvcG93ZXIvc3VwcGx5L2JxMjQxOTBfY2hh
cmdlci5jDQpAQCAtMTM5NCw3ICsxMzk0LDcgQEAgc3RhdGljIGludCBicTI0MTkwX3Byb2JlKHN0
cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQogDQogCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRl
ZF9pcnEoZGV2LCBiZGktPmlycSwgTlVMTCwNCiAJCQlicTI0MTkwX2lycV9oYW5kbGVyX3RocmVh
ZCwNCi0JCQlJUlFGX1RSSUdHRVJfUklTSU5HIHwgSVJRRl9PTkVTSE9ULA0KKwkJCUlSUUZfVFJJ
R0dFUl9GQUxMSU5HIHwgSVJRRl9PTkVTSE9ULA0KIAkJCSJicTI0MTkwLWNoYXJnZXIiLCBiZGkp
Ow0KIAlpZiAocmV0IDwgMCkgew0KIAkJZGV2X2VycihkZXYsICJDYW4ndCBzZXQgdXAgaXJxIGhh
bmRsZXJcbiIpOw0K
--001a114aad2c4c481f05462ffb2e--
