From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 1/6] power: bq24190_charger: Fix irq trigger to IRQF_TRIGGER_FALLING
Date: Mon, 16 Jan 2017 18:28:46 -0800
Message-ID: <CAKvHMgSxJXB7HEd8PVHHVyK0NrfTb_QX=LUoQEhEGyyA1J81nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a114a6d764a723d0546410fb5
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36033 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdAQC2r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 21:28:47 -0500
Received: by mail-io0-f196.google.com with SMTP id q20so14385682ioi.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2017 18:28:47 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, "Mark A . Greer" <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

--001a114a6d764a723d0546410fb5
Content-Type: text/plain; charset=UTF-8



--001a114a6d764a723d0546410fb5
Content-Type: text/plain; charset=US-ASCII; name="patch-v3-1of6.txt"
Content-Disposition: attachment; filename="patch-v3-1of6.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iy0uk3wg0

VGhlIGludGVycnVwdCBzaWduYWwgaXMgVFJJR0dFUl9GQUxMSU5HLiBUaGlzIGlzIGlzIHNwZWNp
ZmllZCBpbiB0aGUNCmRhdGEgc2hlZXQgUElOIEZVTkNUSU9OUzogIlRoZSBJTlQgcGluIHNlbmRz
IGFjdGl2ZSBsb3csIDI1NnVzDQpwdWxzZSB0byBob3N0IHRvIHJlcG9ydCBjaGFyZ2VyIGRldmlj
ZSBzdGF0dXMgYW5kIGZhdWx0LiINCg0KQWxzbyB0aGUgZGlyZWN0aW9uIGNhbiBiZSBzZWVuIGlu
IHRoZSBkYXRhIHNoZWV0IEZpZ3VyZSAzNyAiQlEyNDE5MA0Kd2l0aCBEKy9ELSBEZXRlY3Rpb24g
YW5kIFVTQiBPbi1UaGUtR28gKE9URykiIHdoaWNoIHNob3dzIGEgMTBrDQpwdWxsLXVwIHJlc2lz
dG9yIGluc3RhbGxlZCBmb3IgdGhlIHNhbXBsZSBjb25maWd1cmF0aW9ucy4NCg0KRml4ZXM6IGQ3
YmYzNTNmZDBhYTMgKCJicTI0MTkwX2NoYXJnZXI6IEFkZCBzdXBwb3J0IGZvciBUSSBCUTI0MTkw
IEJhdHRlcnkgQ2hhcmdlciIpDQpDYzogTWF0dCBSYW5vc3RheSA8bWF0dEByYW5vc3RheS5jb25z
dWx0aW5nPg0KU2lnbmVkLW9mZi1ieTogTGlhbSBCcmVjayA8a2VybmVsQG5ldHdvcmtpbXByb3Yu
bmV0Pg0KQWNrZWQtYnk6IE1hcmsgR3JlZXIgPG1ncmVlckBhbmltYWxjcmVlay5jb20+DQpBY2tl
ZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcG93
ZXIvc3VwcGx5L2JxMjQxOTBfY2hhcmdlci5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlci9z
dXBwbHkvYnEyNDE5MF9jaGFyZ2VyLmMgYi9kcml2ZXJzL3Bvd2VyL3N1cHBseS9icTI0MTkwX2No
YXJnZXIuYw0KaW5kZXggZjU3NDZiOS4uNjk0YzA4OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcG93
ZXIvc3VwcGx5L2JxMjQxOTBfY2hhcmdlci5jDQorKysgYi9kcml2ZXJzL3Bvd2VyL3N1cHBseS9i
cTI0MTkwX2NoYXJnZXIuYw0KQEAgLTEzOTQsNyArMTM5NCw3IEBAIHN0YXRpYyBpbnQgYnEyNDE5
MF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0KIA0KIAlyZXQgPSBkZXZtX3JlcXVl
c3RfdGhyZWFkZWRfaXJxKGRldiwgYmRpLT5pcnEsIE5VTEwsDQogCQkJYnEyNDE5MF9pcnFfaGFu
ZGxlcl90aHJlYWQsDQotCQkJSVJRRl9UUklHR0VSX1JJU0lORyB8IElSUUZfT05FU0hPVCwNCisJ
CQlJUlFGX1RSSUdHRVJfRkFMTElORyB8IElSUUZfT05FU0hPVCwNCiAJCQkiYnEyNDE5MC1jaGFy
Z2VyIiwgYmRpKTsNCiAJaWYgKHJldCA8IDApIHsNCiAJCWRldl9lcnIoZGV2LCAiQ2FuJ3Qgc2V0
IHVwIGlycSBoYW5kbGVyXG4iKTsNCg==
--001a114a6d764a723d0546410fb5--
