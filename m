From: "Thomas, Sujith" <sujith.thomas@intel.com>
Subject: [patch 2/6] Generic thermal management: use ERR_PTR for
	returning error
Date: Fri, 15 Feb 2008 10:53:15 +0530
Message-ID: <05B550FD4BD2014E841D83547B62600802AA6501__15439.7682323635$1203053662$gmane$org@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C86F92.DE318CD5"
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

------_=_NextPart_001_01C86F92.DE318CD5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Thomas Sujith <sujith.thomas@intel.com>

Need to return using ERR_PTR instead of NULL
in case of errors.

Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
---

 drivers/thermal/thermal.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6.24/drivers/thermal/thermal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24.orig/drivers/thermal/thermal.c
+++ linux-2.6.24/drivers/thermal/thermal.c
@@ -448,20 +448,20 @@ struct thermal_cooling_device *thermal_c
 	int result;
=20
 	if (strlen(type) >=3D THERMAL_NAME_LENGTH)
-		return NULL;
+		return ERR_PTR(-EINVAL);
=20
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
 	    !ops->set_cur_state)
-		return NULL;
+		return ERR_PTR(-EINVAL);
=20
 	cdev =3D kzalloc(sizeof(struct thermal_cooling_device),
GFP_KERNEL);
 	if (!cdev)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
=20
 	result =3D get_idr(&thermal_cdev_idr, &thermal_idr_lock,
&cdev->id);
 	if (result) {
 		kfree(cdev);
-		return NULL;
+		return ERR_PTR(result);
 	}
=20
 	strcpy(cdev->type, type);
@@ -473,7 +473,7 @@ struct thermal_cooling_device *thermal_c
 	if (result) {
 		release_idr(&thermal_cdev_idr, &thermal_idr_lock,
cdev->id);
 		kfree(cdev);
-		return NULL;
+		return ERR_PTR(result);
 	}
=20
 	/* sys I/F */
@@ -509,7 +509,7 @@ struct thermal_cooling_device *thermal_c
       unregister:
 	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
 	device_unregister(&cdev->device);
-	return NULL;
+	return ERR_PTR(result);
 }
=20
 EXPORT_SYMBOL(thermal_cooling_device_register);
@@ -581,17 +581,17 @@ struct thermal_zone_device *thermal_zone
 	int count;
=20
 	if (strlen(type) >=3D THERMAL_NAME_LENGTH)
-		return NULL;
+		return ERR_PTR(-EINVAL);
=20
 	if (trips > THERMAL_MAX_TRIPS || trips < 0)
-		return NULL;
+		return ERR_PTR(-EINVAL);
=20
 	if (!ops || !ops->get_temp)
-		return NULL;
+		return ERR_PTR(-EINVAL);
=20
 	tz =3D kzalloc(sizeof(struct thermal_zone_device), GFP_KERNEL);
 	if (!tz)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
=20
 	INIT_LIST_HEAD(&tz->cooling_devices);
 	idr_init(&tz->idr);
@@ -599,7 +599,7 @@ struct thermal_zone_device *thermal_zone
 	result =3D get_idr(&thermal_tz_idr, &thermal_idr_lock, &tz->id);
 	if (result) {
 		kfree(tz);
-		return NULL;
+		return ERR_PTR(result);
 	}
=20
 	strcpy(tz->type, type);
@@ -612,7 +612,7 @@ struct thermal_zone_device *thermal_zone
 	if (result) {
 		release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 		kfree(tz);
-		return NULL;
+		return ERR_PTR(result);
 	}
=20
 	/* sys I/F */
@@ -654,7 +654,7 @@ struct thermal_zone_device *thermal_zone
       unregister:
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 	device_unregister(&tz->device);
-	return NULL;
+	return ERR_PTR(result);
 }
=20
 EXPORT_SYMBOL(thermal_zone_device_register);

------_=_NextPart_001_01C86F92.DE318CD5
Content-Type: application/octet-stream;
	name="[patch 2 of 6] Thermal Management - return using ERR_PTR"
Content-Transfer-Encoding: base64
Content-Description: [patch 2 of 6] Thermal Management - return using ERR_PTR
Content-Disposition: attachment;
	filename="[patch 2 of 6] Thermal Management - return using ERR_PTR"

RnJvbTogVGhvbWFzIFN1aml0aCA8c3VqaXRoLnRob21hc0BpbnRlbC5jb20+CgpOZWVkIHRvIHJl
dHVybiB1c2luZyBFUlJfUFRSIGluc3RlYWQgb2YgTlVMTAppbiBjYXNlIG9mIGVycm9ycy4KClNp
Z25lZC1vZmYtYnk6IFRob21hcyBTdWppdGggPHN1aml0aC50aG9tYXNAaW50ZWwuY29tPgotLS0K
CiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbC5jIHwgICAyNiArKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkK
CkluZGV4OiBsaW51eC0yLjYuMjQvZHJpdmVycy90aGVybWFsL3RoZXJtYWwuYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Ci0tLSBsaW51eC0yLjYuMjQub3JpZy9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbC5jCisrKyBsaW51
eC0yLjYuMjQvZHJpdmVycy90aGVybWFsL3RoZXJtYWwuYwpAQCAtNDQ4LDIwICs0NDgsMjAgQEAg
c3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UgKnRoZXJtYWxfYwogCWludCByZXN1bHQ7CiAK
IAlpZiAoc3RybGVuKHR5cGUpID49IFRIRVJNQUxfTkFNRV9MRU5HVEgpCi0JCXJldHVybiBOVUxM
OworCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKIAogCWlmICghb3BzIHx8ICFvcHMtPmdldF9t
YXhfc3RhdGUgfHwgIW9wcy0+Z2V0X2N1cl9zdGF0ZSB8fAogCSAgICAhb3BzLT5zZXRfY3VyX3N0
YXRlKQotCQlyZXR1cm4gTlVMTDsKKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7CiAKIAljZGV2
ID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UpLCBHRlBfS0VS
TkVMKTsKIAlpZiAoIWNkZXYpCi0JCXJldHVybiBOVUxMOworCQlyZXR1cm4gRVJSX1BUUigtRU5P
TUVNKTsKIAogCXJlc3VsdCA9IGdldF9pZHIoJnRoZXJtYWxfY2Rldl9pZHIsICZ0aGVybWFsX2lk
cl9sb2NrLCAmY2Rldi0+aWQpOwogCWlmIChyZXN1bHQpIHsKIAkJa2ZyZWUoY2Rldik7Ci0JCXJl
dHVybiBOVUxMOworCQlyZXR1cm4gRVJSX1BUUihyZXN1bHQpOwogCX0KIAogCXN0cmNweShjZGV2
LT50eXBlLCB0eXBlKTsKQEAgLTQ3Myw3ICs0NzMsNyBAQCBzdHJ1Y3QgdGhlcm1hbF9jb29saW5n
X2RldmljZSAqdGhlcm1hbF9jCiAJaWYgKHJlc3VsdCkgewogCQlyZWxlYXNlX2lkcigmdGhlcm1h
bF9jZGV2X2lkciwgJnRoZXJtYWxfaWRyX2xvY2ssIGNkZXYtPmlkKTsKIAkJa2ZyZWUoY2Rldik7
Ci0JCXJldHVybiBOVUxMOworCQlyZXR1cm4gRVJSX1BUUihyZXN1bHQpOwogCX0KIAogCS8qIHN5
cyBJL0YgKi8KQEAgLTUwOSw3ICs1MDksNyBAQCBzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2Rldmlj
ZSAqdGhlcm1hbF9jCiAgICAgICB1bnJlZ2lzdGVyOgogCXJlbGVhc2VfaWRyKCZ0aGVybWFsX2Nk
ZXZfaWRyLCAmdGhlcm1hbF9pZHJfbG9jaywgY2Rldi0+aWQpOwogCWRldmljZV91bnJlZ2lzdGVy
KCZjZGV2LT5kZXZpY2UpOwotCXJldHVybiBOVUxMOworCXJldHVybiBFUlJfUFRSKHJlc3VsdCk7
CiB9CiAKIEVYUE9SVF9TWU1CT0wodGhlcm1hbF9jb29saW5nX2RldmljZV9yZWdpc3Rlcik7CkBA
IC01ODEsMTcgKzU4MSwxNyBAQCBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdGhlcm1hbF96
b25lCiAJaW50IGNvdW50OwogCiAJaWYgKHN0cmxlbih0eXBlKSA+PSBUSEVSTUFMX05BTUVfTEVO
R1RIKQotCQlyZXR1cm4gTlVMTDsKKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7CiAKIAlpZiAo
dHJpcHMgPiBUSEVSTUFMX01BWF9UUklQUyB8fCB0cmlwcyA8IDApCi0JCXJldHVybiBOVUxMOwor
CQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKIAogCWlmICghb3BzIHx8ICFvcHMtPmdldF90ZW1w
KQotCQlyZXR1cm4gTlVMTDsKKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7CiAKIAl0eiA9IGt6
YWxsb2Moc2l6ZW9mKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlKSwgR0ZQX0tFUk5FTCk7CiAJ
aWYgKCF0eikKLQkJcmV0dXJuIE5VTEw7CisJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwogCiAJ
SU5JVF9MSVNUX0hFQUQoJnR6LT5jb29saW5nX2RldmljZXMpOwogCWlkcl9pbml0KCZ0ei0+aWRy
KTsKQEAgLTU5OSw3ICs1OTksNyBAQCBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdGhlcm1h
bF96b25lCiAJcmVzdWx0ID0gZ2V0X2lkcigmdGhlcm1hbF90el9pZHIsICZ0aGVybWFsX2lkcl9s
b2NrLCAmdHotPmlkKTsKIAlpZiAocmVzdWx0KSB7CiAJCWtmcmVlKHR6KTsKLQkJcmV0dXJuIE5V
TEw7CisJCXJldHVybiBFUlJfUFRSKHJlc3VsdCk7CiAJfQogCiAJc3RyY3B5KHR6LT50eXBlLCB0
eXBlKTsKQEAgLTYxMiw3ICs2MTIsNyBAQCBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdGhl
cm1hbF96b25lCiAJaWYgKHJlc3VsdCkgewogCQlyZWxlYXNlX2lkcigmdGhlcm1hbF90el9pZHIs
ICZ0aGVybWFsX2lkcl9sb2NrLCB0ei0+aWQpOwogCQlrZnJlZSh0eik7Ci0JCXJldHVybiBOVUxM
OworCQlyZXR1cm4gRVJSX1BUUihyZXN1bHQpOwogCX0KIAogCS8qIHN5cyBJL0YgKi8KQEAgLTY1
NCw3ICs2NTQsNyBAQCBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdGhlcm1hbF96b25lCiAg
ICAgICB1bnJlZ2lzdGVyOgogCXJlbGVhc2VfaWRyKCZ0aGVybWFsX3R6X2lkciwgJnRoZXJtYWxf
aWRyX2xvY2ssIHR6LT5pZCk7CiAJZGV2aWNlX3VucmVnaXN0ZXIoJnR6LT5kZXZpY2UpOwotCXJl
dHVybiBOVUxMOworCXJldHVybiBFUlJfUFRSKHJlc3VsdCk7CiB9CiAKIEVYUE9SVF9TWU1CT0wo
dGhlcm1hbF96b25lX2RldmljZV9yZWdpc3Rlcik7Cg==

------_=_NextPart_001_01C86F92.DE318CD5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C86F92.DE318CD5--
