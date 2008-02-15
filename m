From: "Thomas, Sujith" <sujith.thomas@intel.com>
Subject: [patch 4/6] ACPI processor: extract return values using
	PTR_ERR
Date: Fri, 15 Feb 2008 10:54:07 +0530
Message-ID: <05B550FD4BD2014E841D83547B62600802AA6506__37169.6799448275$1203053542$gmane$org@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C86F92.FCDC85F0"
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

------_=_NextPart_001_01C86F92.FCDC85F0
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

 drivers/acpi/processor_core.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

Index: linux-2.6.24/drivers/acpi/processor_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24.orig/drivers/acpi/processor_core.c
+++ linux-2.6.24/drivers/acpi/processor_core.c
@@ -670,21 +670,26 @@ static int __cpuinit acpi_processor_star
=20
 	pr->cdev =3D thermal_cooling_device_register("Processor", device,
 						&processor_cooling_ops);
-	if (pr->cdev)
+	if (IS_ERR(pr->cdev)) {
+		result =3D PTR_ERR(pr->cdev);
+		goto end;
+	}
+	if (pr->cdev) {
 		printk(KERN_INFO PREFIX
 			"%s is registered as cooling_device%d\n",
 			device->dev.bus_id, pr->cdev->id);
-	else
-		goto end;
=20
-	result =3D sysfs_create_link(&device->dev.kobj,
&pr->cdev->device.kobj,
-					"thermal_cooling");
-	if (result)
-		return result;
-	result =3D sysfs_create_link(&pr->cdev->device.kobj,
&device->dev.kobj,
-					"device");
-	if (result)
-		return result;
+		result =3D sysfs_create_link(&device->dev.kobj,
+					   &pr->cdev->device.kobj,
+					   "thermal_cooling");
+		if (result)
+			return result;
+		result =3D sysfs_create_link(&pr->cdev->device.kobj,
+					   &device->dev.kobj,
+					   "device");
+		if (result)
+			return result;
+	}
=20
 	if (pr->flags.throttling) {
 		printk(KERN_INFO PREFIX "%s [%s] (supports",

------_=_NextPart_001_01C86F92.FCDC85F0
Content-Type: application/octet-stream;
	name="[patch 4 of 6] ACPI processor - extract return value using PTR_ERR"
Content-Transfer-Encoding: base64
Content-Description: [patch 4 of 6] ACPI processor - extract return value using PTR_ERR
Content-Disposition: attachment;
	filename="[patch 4 of 6] ACPI processor - extract return value using PTR_ERR"

RnJvbTogVGhvbWFzIFN1aml0aCA8c3VqaXRoLnRob21hc0BpbnRlbC5jb20+CgpOZWVkIHRvIGV4
dHJhY3QgZXJyb3JzIHVzaW5nIFBUUl9FUlIgbWFjcm8gYW5kCnByb2Nlc3MgYWNjb3JkaW5nbHku
dGhlcm1hbF9jb29saW5nX2RldmljZV9yZWdpc3RlcgpyZXR1cm5pbmcgTlVMTCBtZWFucyB0aGF0
IENPTkZJR19USEVSTUFMPW4gYW5kIGluIHRoYXQKY2FzZSBubyBuZWVkIHRvIGNyZWF0ZSBzeW1i
b2xpYyBsaW5rcy4KClNpZ25lZC1vZmYtYnk6IFRob21hcyBTdWppdGggPHN1aml0aC50aG9tYXNA
aW50ZWwuY29tPgotLS0KCiBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2NvcmUuYyB8ICAgMjcgKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LTIuNi4yNC9kcml2ZXJzL2FjcGkvcHJv
Y2Vzc29yX2NvcmUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYuMjQub3JpZy9kcml2ZXJzL2Fj
cGkvcHJvY2Vzc29yX2NvcmUuYworKysgbGludXgtMi42LjI0L2RyaXZlcnMvYWNwaS9wcm9jZXNz
b3JfY29yZS5jCkBAIC02NzAsMjEgKzY3MCwyNiBAQCBzdGF0aWMgaW50IF9fY3B1aW5pdCBhY3Bp
X3Byb2Nlc3Nvcl9zdGFyCiAKIAlwci0+Y2RldiA9IHRoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVn
aXN0ZXIoIlByb2Nlc3NvciIsIGRldmljZSwKIAkJCQkJCSZwcm9jZXNzb3JfY29vbGluZ19vcHMp
OwotCWlmIChwci0+Y2RldikKKwlpZiAoSVNfRVJSKHByLT5jZGV2KSkgeworCQlyZXN1bHQgPSBQ
VFJfRVJSKHByLT5jZGV2KTsKKwkJZ290byBlbmQ7CisJfQorCWlmIChwci0+Y2RldikgewogCQlw
cmludGsoS0VSTl9JTkZPIFBSRUZJWAogCQkJIiVzIGlzIHJlZ2lzdGVyZWQgYXMgY29vbGluZ19k
ZXZpY2UlZFxuIiwKIAkJCWRldmljZS0+ZGV2LmJ1c19pZCwgcHItPmNkZXYtPmlkKTsKLQllbHNl
Ci0JCWdvdG8gZW5kOwogCi0JcmVzdWx0ID0gc3lzZnNfY3JlYXRlX2xpbmsoJmRldmljZS0+ZGV2
LmtvYmosICZwci0+Y2Rldi0+ZGV2aWNlLmtvYmosCi0JCQkJCSJ0aGVybWFsX2Nvb2xpbmciKTsK
LQlpZiAocmVzdWx0KQotCQlyZXR1cm4gcmVzdWx0OwotCXJlc3VsdCA9IHN5c2ZzX2NyZWF0ZV9s
aW5rKCZwci0+Y2Rldi0+ZGV2aWNlLmtvYmosICZkZXZpY2UtPmRldi5rb2JqLAotCQkJCQkiZGV2
aWNlIik7Ci0JaWYgKHJlc3VsdCkKLQkJcmV0dXJuIHJlc3VsdDsKKwkJcmVzdWx0ID0gc3lzZnNf
Y3JlYXRlX2xpbmsoJmRldmljZS0+ZGV2LmtvYmosCisJCQkJCSAgICZwci0+Y2Rldi0+ZGV2aWNl
LmtvYmosCisJCQkJCSAgICJ0aGVybWFsX2Nvb2xpbmciKTsKKwkJaWYgKHJlc3VsdCkKKwkJCXJl
dHVybiByZXN1bHQ7CisJCXJlc3VsdCA9IHN5c2ZzX2NyZWF0ZV9saW5rKCZwci0+Y2Rldi0+ZGV2
aWNlLmtvYmosCisJCQkJCSAgICZkZXZpY2UtPmRldi5rb2JqLAorCQkJCQkgICAiZGV2aWNlIik7
CisJCWlmIChyZXN1bHQpCisJCQlyZXR1cm4gcmVzdWx0OworCX0KIAogCWlmIChwci0+ZmxhZ3Mu
dGhyb3R0bGluZykgewogCQlwcmludGsoS0VSTl9JTkZPIFBSRUZJWCAiJXMgWyVzXSAoc3VwcG9y
dHMiLAo=

------_=_NextPart_001_01C86F92.FCDC85F0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C86F92.FCDC85F0--
