From: "Thomas, Sujith" <sujith.thomas@intel.com>
Subject: [patch 6/6] Intel Menlow : extract return values using
	PTR_ERR
Date: Fri, 15 Feb 2008 10:55:47 +0530
Message-ID: <05B550FD4BD2014E841D83547B62600802AA650F__43024.3342686028$1203053833$gmane$org@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C86F93.389D2A60"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C86F93.389D2A60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Thomas Sujith <sujith.thomas@intel.com>

Need to extract errors using PTR_ERR macro and
process accordingly.thermal_cooling_device_register
returning NULL means that CONFIG_THERMAL=3Dn and in that
case no need to create symbolic links.

Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
---

 drivers/misc/intel_menlow.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

Index: linux-2.6.24/drivers/misc/intel_menlow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24.orig/drivers/misc/intel_menlow.c
+++ linux-2.6.24/drivers/misc/intel_menlow.c
@@ -170,10 +170,13 @@ static int intel_menlow_memory_add(struc
=20
 	cdev =3D thermal_cooling_device_register("Memory controller",
device,
 					       &memory_cooling_ops);
-	acpi_driver_data(device) =3D cdev;
-	if (!cdev)
-		result =3D -ENODEV;
-	else {
+	if (IS_ERR(cdev)) {
+		result =3D PTR_ERR(cdev);
+		goto end;
+	}
+
+	if (cdev) {
+		acpi_driver_data(device) =3D cdev;
 		result =3D sysfs_create_link(&device->dev.kobj,
 					&cdev->device.kobj,
"thermal_cooling");
 		if (result)

------_=_NextPart_001_01C86F93.389D2A60
Content-Type: application/octet-stream;
	name="[patch 6 of 6] Intel Menlow - extract return value using PTR_ERR"
Content-Transfer-Encoding: base64
Content-Description: [patch 6 of 6] Intel Menlow - extract return value using PTR_ERR
Content-Disposition: attachment;
	filename="[patch 6 of 6] Intel Menlow - extract return value using PTR_ERR"

RnJvbTogVGhvbWFzIFN1aml0aCA8c3VqaXRoLnRob21hc0BpbnRlbC5jb20+CgpOZWVkIHRvIGV4
dHJhY3QgZXJyb3JzIHVzaW5nIFBUUl9FUlIgbWFjcm8gYW5kCnByb2Nlc3MgYWNjb3JkaW5nbHku
dGhlcm1hbF9jb29saW5nX2RldmljZV9yZWdpc3RlcgpyZXR1cm5pbmcgTlVMTCBtZWFucyB0aGF0
IENPTkZJR19USEVSTUFMPW4gYW5kIGluIHRoYXQKY2FzZSBubyBuZWVkIHRvIGNyZWF0ZSBzeW1i
b2xpYyBsaW5rcy4KClNpZ25lZC1vZmYtYnk6IFRob21hcyBTdWppdGggPHN1aml0aC50aG9tYXNA
aW50ZWwuY29tPgotLS0KCiBkcml2ZXJzL21pc2MvaW50ZWxfbWVubG93LmMgfCAgIDExICsrKysr
KystLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
CkluZGV4OiBsaW51eC0yLjYuMjQvZHJpdmVycy9taXNjL2ludGVsX21lbmxvdy5jCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIGxpbnV4LTIuNi4yNC5vcmlnL2RyaXZlcnMvbWlzYy9pbnRlbF9tZW5sb3cuYworKysg
bGludXgtMi42LjI0L2RyaXZlcnMvbWlzYy9pbnRlbF9tZW5sb3cuYwpAQCAtMTcwLDEwICsxNzAs
MTMgQEAgc3RhdGljIGludCBpbnRlbF9tZW5sb3dfbWVtb3J5X2FkZChzdHJ1YwogCiAJY2RldiA9
IHRoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIoIk1lbW9yeSBjb250cm9sbGVyIiwgZGV2
aWNlLAogCQkJCQkgICAgICAgJm1lbW9yeV9jb29saW5nX29wcyk7Ci0JYWNwaV9kcml2ZXJfZGF0
YShkZXZpY2UpID0gY2RldjsKLQlpZiAoIWNkZXYpCi0JCXJlc3VsdCA9IC1FTk9ERVY7Ci0JZWxz
ZSB7CisJaWYgKElTX0VSUihjZGV2KSkgeworCQlyZXN1bHQgPSBQVFJfRVJSKGNkZXYpOworCQln
b3RvIGVuZDsKKwl9CisKKwlpZiAoY2RldikgeworCQlhY3BpX2RyaXZlcl9kYXRhKGRldmljZSkg
PSBjZGV2OwogCQlyZXN1bHQgPSBzeXNmc19jcmVhdGVfbGluaygmZGV2aWNlLT5kZXYua29iaiwK
IAkJCQkJJmNkZXYtPmRldmljZS5rb2JqLCAidGhlcm1hbF9jb29saW5nIik7CiAJCWlmIChyZXN1
bHQpCg==

------_=_NextPart_001_01C86F93.389D2A60
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C86F93.389D2A60--
