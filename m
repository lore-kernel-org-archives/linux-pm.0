From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 2/6] power: bq24190_charger: Call set_mode_host() on pm_resume()
Date: Mon, 16 Jan 2017 18:29:04 -0800
Message-ID: <CAKvHMgTuUNtKhM1iLy_B8_vhGuBVBX6NYFoRr0T6QBAGqSqrsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a114aad2c600eba05464110a3
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:36476 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdAQC3F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 21:29:05 -0500
Received: by mail-it0-f44.google.com with SMTP id c7so86602290itd.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2017 18:29:05 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, "Mark A . Greer" <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

--001a114aad2c600eba05464110a3
Content-Type: text/plain; charset=UTF-8



--001a114aad2c600eba05464110a3
Content-Type: text/plain; charset=US-ASCII; name="patch-v3-2of6.txt"
Content-Disposition: attachment; filename="patch-v3-2of6.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iy0uo1ar0

cG1fcmVzdW1lKCkgZG9lcyBhIHJlZ2lzdGVyX3Jlc2V0KCkgd2hpY2ggY2xlYXJzIGNoYXJnZXIg
aG9zdCBtb2RlLg0KDQpGaXggYnkgY2FsbGluZyBzZXRfbW9kZV9ob3N0KCkgYWZ0ZXIgdGhlIHJl
c2V0Lg0KDQpGaXhlczogZDdiZjM1M2ZkMGFhMyAoImJxMjQxOTBfY2hhcmdlcjogQWRkIHN1cHBv
cnQgZm9yIFRJIEJRMjQxOTAgQmF0dGVyeSBDaGFyZ2VyIikNCkNjOiBNYXR0IFJhbm9zdGF5IDxt
YXR0QHJhbm9zdGF5LmNvbnN1bHRpbmc+DQpTaWduZWQtb2ZmLWJ5OiBMaWFtIEJyZWNrIDxrZXJu
ZWxAbmV0d29ya2ltcHJvdi5uZXQ+DQpBY2tlZC1ieTogTWFyayBHcmVlciA8bWdyZWVyQGFuaW1h
bGNyZWVrLmNvbT4NCkFja2VkLWJ5OiBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPg0K
LS0tDQogZHJpdmVycy9wb3dlci9zdXBwbHkvYnEyNDE5MF9jaGFyZ2VyLmMgfCAxICsNCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXIv
c3VwcGx5L2JxMjQxOTBfY2hhcmdlci5jIGIvZHJpdmVycy9wb3dlci9zdXBwbHkvYnEyNDE5MF9j
aGFyZ2VyLmMNCmluZGV4IGY1NzQ2YjkuLmU5ZTZmZTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Bv
d2VyL3N1cHBseS9icTI0MTkwX2NoYXJnZXIuYw0KKysrIGIvZHJpdmVycy9wb3dlci9zdXBwbHkv
YnEyNDE5MF9jaGFyZ2VyLmMNCkBAIC0xNDk0LDYgKzE0OTQsNyBAQCBzdGF0aWMgaW50IGJxMjQx
OTBfcG1fcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiANCiAJcG1fcnVudGltZV9nZXRfc3lu
YyhiZGktPmRldik7DQogCWJxMjQxOTBfcmVnaXN0ZXJfcmVzZXQoYmRpKTsNCisJYnEyNDE5MF9z
ZXRfbW9kZV9ob3N0KGJkaSk7DQogCXBtX3J1bnRpbWVfcHV0X3N5bmMoYmRpLT5kZXYpOw0KIA0K
IAkvKiBUaGluZ3MgbWF5IGhhdmUgY2hhbmdlZCB3aGlsZSBzdXNwZW5kZWQgc28gYWxlcnQgdXBw
ZXIgbGF5ZXIgKi8NCg==
--001a114aad2c600eba05464110a3--
