From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v2 2/6] power: bq24190_charger: Call set_mode_host() on pm_resume()
Date: Sun, 15 Jan 2017 22:07:34 -0800
Message-ID: <CAKvHMgS_Es4CrTWCEiYZU1v9VC8pqVnqPfkNoj+g6b6t8wfvQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11470b38f30e4905462fff68
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35110 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdAPGHf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 01:07:35 -0500
Received: by mail-it0-f65.google.com with SMTP id 203so11293934ith.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2017 22:07:35 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, "Mark A . Greer" <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

--001a11470b38f30e4905462fff68
Content-Type: text/plain; charset=UTF-8



--001a11470b38f30e4905462fff68
Content-Type: text/plain; charset=US-ASCII; name="patch-v2-2of6.txt"
Content-Disposition: attachment; filename="patch-v2-2of6.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixznlpov0

cG1fcmVzdW1lKCkgZG9lcyBhIHJlZ2lzdGVyX3Jlc2V0KCkgd2hpY2ggY2xlYXJzIGNoYXJnZXIg
aG9zdCBtb2RlLg0KDQpGaXggYnkgY2FsbGluZyBzZXRfbW9kZV9ob3N0KCkgYWZ0ZXIgdGhlIHJl
c2V0Lg0KDQpGaXhlczogZDdiZjM1M2ZkMGFhMyAoImJxMjQxOTBfY2hhcmdlcjogQWRkIHN1cHBv
cnQgZm9yIFRJIEJRMjQxOTAgQmF0dGVyeSBDaGFyZ2VyIikNCkNjOiBNYXJrIEEuIEdyZWVyIDxt
Z3JlZXJAYW5pbWFsY3JlZWsuY29tPg0KQ2M6IE1hdHQgUmFub3N0YXkgPG1hdHRAcmFub3N0YXku
Y29uc3VsdGluZz4NCkNjOiBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPg0KU2lnbmVk
LW9mZi1ieTogTGlhbSBCcmVjayA8a2VybmVsQG5ldHdvcmtpbXByb3YubmV0Pg0KLS0tDQogZHJp
dmVycy9wb3dlci9zdXBwbHkvYnEyNDE5MF9jaGFyZ2VyLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXIvc3VwcGx5L2Jx
MjQxOTBfY2hhcmdlci5jIGIvZHJpdmVycy9wb3dlci9zdXBwbHkvYnEyNDE5MF9jaGFyZ2VyLmMN
CmluZGV4IGY1NzQ2YjkuLmU5ZTZmZTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Bvd2VyL3N1cHBs
eS9icTI0MTkwX2NoYXJnZXIuYw0KKysrIGIvZHJpdmVycy9wb3dlci9zdXBwbHkvYnEyNDE5MF9j
aGFyZ2VyLmMNCkBAIC0xNDk0LDYgKzE0OTQsNyBAQCBzdGF0aWMgaW50IGJxMjQxOTBfcG1fcmVz
dW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiANCiAJcG1fcnVudGltZV9nZXRfc3luYyhiZGktPmRl
dik7DQogCWJxMjQxOTBfcmVnaXN0ZXJfcmVzZXQoYmRpKTsNCisJYnEyNDE5MF9zZXRfbW9kZV9o
b3N0KGJkaSk7DQogCXBtX3J1bnRpbWVfcHV0X3N5bmMoYmRpLT5kZXYpOw0KIA0KIAkvKiBUaGlu
Z3MgbWF5IGhhdmUgY2hhbmdlZCB3aGlsZSBzdXNwZW5kZWQgc28gYWxlcnQgdXBwZXIgbGF5ZXIg
Ki8NCg==
--001a11470b38f30e4905462fff68--
