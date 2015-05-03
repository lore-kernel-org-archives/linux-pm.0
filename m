From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: [4.1-rc1][Hibernation failed]  bisect result  included
Date: Sun, 3 May 2015 15:54:39 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402CA0E2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_36DF59CE26D8EE47B0655C516E9CE6402CA0E2SHSMSX101ccrcorpi_"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33331 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbbECPyo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 3 May 2015 11:54:44 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "dehrenberg@chromium.org" <dehrenberg@chromium.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Lu, Aaron" <aaron.lu@intel.com>

--_002_36DF59CE26D8EE47B0655C516E9CE6402CA0E2SHSMSX101ccrcorpi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,all,
When we are doing QA test, a hibernation failor was found on latest kernel =
4.1-rc1,
resume from hibernation failed with the following error:

PM: Hibernation image not present or could not be loaded.

Bisect shows following commit might trigger this problem:
commit 283e7ad0241155710f99a9f39d13313a53336926

The  reason for failor is that, some distribution use klibc in initrd
to restore the image, and klibc will provide kernel with the device=20
format of major:minor:offset,
for example, 8:3:0 represents a swap partition, and klibc will
echo 8:3:0 > /sys/power/resume to resume the system manually.
However in current implementation, format of 8:3:0 will be regarded=20
as an invalid device, so restoring from hibernation failed.

Do we need to add support for device format like 8:3:0?
I'm happy to debug more specifically if you can let me know what=20
would be of use, and I've also attached a temporary patch=20
for this problem, not sure if it is suitable,  thanks.




Best Regards,
Yu


--_002_36DF59CE26D8EE47B0655C516E9CE6402CA0E2SHSMSX101ccrcorpi_
Content-Type: application/octet-stream;
	name="0001-init-support-device-of-major-minor-offset-format.patch"
Content-Description: 0001-init-support-device-of-major-minor-offset-format.patch
Content-Disposition: attachment;
	filename="0001-init-support-device-of-major-minor-offset-format.patch";
	size=1601; creation-date="Sun, 03 May 2015 15:51:54 GMT";
	modification-date="Sun, 03 May 2015 15:51:54 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNjVkNzZjMTQzYjMxNWMzMjJiNWM3YTlmYjM2NTcwM2M5ZjMyNzk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaGVuIFl1IDx5dS5jLmNoZW5AaW50ZWwuY29tPgpEYXRlOiBT
dW4sIDMgTWF5IDIwMTUgMjI6MzU6MDUgKzA4MDAKU3ViamVjdDogW1JGQ10gaW5pdDogc3VwcG9y
dCBkZXZpY2Ugb2YgbWFqb3I6bWlub3I6b2Zmc2V0IGZvcm1hdAoKRGlzdHJpYnV0aW9uIGxpa2Ug
VWJ1bnR1IHVzZXMga2xpYmMgcmF0aGVyIHRoYW4gdXN3c3VzcCB0byByZXN1bWUKc3lzdGVtIGZy
b20gaGliZXJuYXRpb24sIHdoaWNoIHdpbGwgdHJlYXQgc3dhcCBwYXJ0aXRpb24vZmlsZSBpbgp0
aGUgZm9ybSBvZiBtYWpvcjptaW5vcjpvZmZzZXQuIEZvciBleGFtcGxlLCA4OjM6MCByZXByZXNl
bnRzIGEKc3dhcCBwYXJ0aXRpb24gaW4ga2xpYmMsIGFuZCBrbGliYydzIHJlc3VtZSBwcm9jZXNz
IGluIGluaXRyZCB3aWxsCmZpbmFsbHkgZWNobyA4OjM6MCB0byAvc3lzL3Bvd2VyL3Jlc3VtZSBm
b3IgbWFudWFsbHkgcmVzdG9yaW5nLgpIb3dldmVyIGluIGN1cnJlbnQgaW1wbGVtZW50YXRpb24s
IDg6MzowIHdpbGwgYmUgdHJlYXRlZCBhcyBhbiBpbnZhbGlkCmRldmljZSBmb3JtYXQsIGFuZCBp
dCBpcyBmb3VuZCB0aGF0IG1hbnVhbCByZXN1bW1pbmcgZnJvbSBoaWJlcm5hdGlvbgp3aWxsIGZh
aWwgb24gbGFzdGVzdCBrZXJuZWwuCgpUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgZGV2aWNl
IHdpdGggbWFqb3I6bWlub3I6b2Zmc2V0IGZvcm1hdAp3aGVuIHJlc3VtbWluZyBmcm9tIGhpYmVy
bmF0aW9uLgoKUmVwb3J0ZWQtYnk6IFByaWdlbnQsIENocmlzdG9waGUgPGNocmlzdG9waGUucHJp
Z2VudEBpbnRlbC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBDaGVuIFl1IDx5dS5jLmNoZW5AaW50ZWwu
Y29tPgotLS0KIGluaXQvZG9fbW91bnRzLmMgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbml0L2RvX21vdW50
cy5jIGIvaW5pdC9kb19tb3VudHMuYwppbmRleCA4MzY5ZmZhLi4yZDM2YmYxIDEwMDY0NAotLS0g
YS9pbml0L2RvX21vdW50cy5jCisrKyBiL2luaXQvZG9fbW91bnRzLmMKQEAgLTIyNSwxMCArMjI1
LDEyIEBAIGRldl90IG5hbWVfdG9fZGV2X3QoY29uc3QgY2hhciAqbmFtZSkKICNlbmRpZgogCiAJ
aWYgKHN0cm5jbXAobmFtZSwgIi9kZXYvIiwgNSkgIT0gMCkgewotCQl1bnNpZ25lZCBtYWosIG1p
bjsKKwkJdW5zaWduZWQgbWFqLCBtaW4sIG9mZnNldDsKIAkJY2hhciBkdW1teTsKIAotCQlpZiAo
c3NjYW5mKG5hbWUsICIldToldSVjIiwgJm1haiwgJm1pbiwgJmR1bW15KSA9PSAyKSB7CisJCWlm
ICgoc3NjYW5mKG5hbWUsICIldToldSVjIiwgJm1haiwgJm1pbiwgJmR1bW15KSA9PSAyKSB8fAor
CQkJKHNzY2FuZihuYW1lLCAiJXU6JXU6JXU6JWMiLCAmbWFqLCAmbWluLCAmb2Zmc2V0LAorCQkJ
JmR1bW15KSA9PSAzKSkgewogCQkJcmVzID0gTUtERVYobWFqLCBtaW4pOwogCQkJaWYgKG1haiAh
PSBNQUpPUihyZXMpIHx8IG1pbiAhPSBNSU5PUihyZXMpKQogCQkJCWdvdG8gZmFpbDsKLS0gCjEu
OS4xCgo=

--_002_36DF59CE26D8EE47B0655C516E9CE6402CA0E2SHSMSX101ccrcorpi_--
