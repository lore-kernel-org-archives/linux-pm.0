From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: spurious bL cpufreq driver messages
Date: Mon, 20 May 2013 10:06:49 +0530
Message-ID: <CAKohpomG5E2FAeZGnX3eBw8fOiX3K8sWEeHgb5NT_FT3y+Cg1w@mail.gmail.com>
References: <519686BC.3090101@gmail.com>
	<CAKohpom0cGfWvsCf-jaMyu0cQJi2hVk9_0wskEDH2X7MaeHDLw@mail.gmail.com>
	<CAL_JsqLEv38DwnL4=ToXtEKNrDbgYv_0qiOc+cXZSjnfKVbeNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c2eba08749f904dd1ee1cd
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:63562 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab3ETEgu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2013 00:36:50 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so6581518obc.27
        for <linux-pm@vger.kernel.org>; Sun, 19 May 2013 21:36:49 -0700 (PDT)
In-Reply-To: <CAL_JsqLEv38DwnL4=ToXtEKNrDbgYv_0qiOc+cXZSjnfKVbeNg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Rob Herring <robherring2@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

--001a11c2eba08749f904dd1ee1cd
Content-Type: text/plain; charset=ISO-8859-1

On 19 May 2013 01:21, Rob Herring <robherring2@gmail.com> wrote:
> No, it still registers the bL driver. The problem is not that DT data
> is missing, but it is present on a single cluster system.

I misread your mail.. I got the problem now.. Below should fix your
issue (It is rebased on the patch I pointed to you earlier):

Attached too for testing as gmail copy-paste will break it.

@Rafael: Once Rob gives his Tested-by, please queue it for 3.10-rcs

------------x-----------------x-----------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 20 May 2013 09:57:17 +0530
Subject: [PATCH] cpufreq: arm_big_little_dt: Instantiate as platform_driver

As multiplatform build is being adopted by more and more ARM platforms, initcall
function should be used very carefully. For example, when both arm_big_little_dt
and cpufreq-cpu0 drivers are compiled in, arm_big_little_dt driver may try to
register even if we had platform device for cpufreq-cpu0 registered.

To eliminate this undesired the effect, the patch changes arm_big_little_dt
driver to have it instantiated as a platform_driver. Then it will only run on
platforms that create the platform_device "arm-bL-cpufreq-dt".

Reported-by: Rob Herring <robherring2@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little_dt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little_dt.c
b/drivers/cpufreq/arm_big_little_dt.c
index 27e2f45..fd9e3ea 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/opp.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include "arm_big_little.h"
@@ -95,7 +96,7 @@ static struct cpufreq_arm_bL_ops dt_bL_ops = {
 	.init_opp_table = dt_init_opp_table,
 };

-static int generic_bL_init(void)
+static int generic_bL_probe(struct platform_device *pdev)
 {
 	struct device_node *np;

@@ -106,13 +107,22 @@ static int generic_bL_init(void)
 	of_node_put(np);
 	return bL_cpufreq_register(&dt_bL_ops);
 }
-module_init(generic_bL_init);

-static void generic_bL_exit(void)
+static int generic_bL_remove(struct platform_device *pdev)
 {
-	return bL_cpufreq_unregister(&dt_bL_ops);
+	bL_cpufreq_unregister(&dt_bL_ops);
+	return 0;
 }
-module_exit(generic_bL_exit);
+
+static struct platform_driver generic_bL_platdrv = {
+	.driver = {
+		.name	= "arm-bL-cpufreq-dt",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= generic_bL_probe,
+	.remove		= generic_bL_remove,
+};
+module_platform_driver(generic_bL_platdrv);

 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
 MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver via DT");

--001a11c2eba08749f904dd1ee1cd
Content-Type: application/octet-stream;
	name="0001-cpufreq-arm_big_little_dt-Instantiate-as-platform_dr.patch"
Content-Disposition: attachment;
	filename="0001-cpufreq-arm_big_little_dt-Instantiate-as-platform_dr.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgx5vfje0

RnJvbSBhMGI3ZDM4ZmJiM2EzNDYxMTcyMzUzNGQ3OTc2YzYxODk1YjRmMDFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8YTBiN2QzOGZiYjNhMzQ2MTE3MjM1MzRkNzk3NmM2
MTg5NWI0ZjAxYS4xMzY5MDI0MzAyLmdpdC52aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRnJvbTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRGF0ZTogTW9uLCAyMCBNYXkg
MjAxMyAwOTo1NzoxNyArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIGNwdWZyZXE6IGFybV9iaWdfbGl0
dGxlX2R0OiBJbnN0YW50aWF0ZSBhcyBwbGF0Zm9ybV9kcml2ZXIKCkFzIG11bHRpcGxhdGZvcm0g
YnVpbGQgaXMgYmVpbmcgYWRvcHRlZCBieSBtb3JlIGFuZCBtb3JlIEFSTSBwbGF0Zm9ybXMsIGlu
aXRjYWxsCmZ1bmN0aW9uIHNob3VsZCBiZSB1c2VkIHZlcnkgY2FyZWZ1bGx5LiBGb3IgZXhhbXBs
ZSwgd2hlbiBib3RoIGFybV9iaWdfbGl0dGxlX2R0CmFuZCBjcHVmcmVxLWNwdTAgZHJpdmVycyBh
cmUgY29tcGlsZWQgaW4sIGFybV9iaWdfbGl0dGxlX2R0IGRyaXZlciBtYXkgdHJ5IHRvCnJlZ2lz
dGVyIGV2ZW4gaWYgd2UgaGFkIHBsYXRmb3JtIGRldmljZSBmb3IgY3B1ZnJlcS1jcHUwIHJlZ2lz
dGVyZWQuCgpUbyBlbGltaW5hdGUgdGhpcyB1bmRlc2lyZWQgdGhlIGVmZmVjdCwgdGhlIHBhdGNo
IGNoYW5nZXMgYXJtX2JpZ19saXR0bGVfZHQKZHJpdmVyIHRvIGhhdmUgaXQgaW5zdGFudGlhdGVk
IGFzIGEgcGxhdGZvcm1fZHJpdmVyLiBUaGVuIGl0IHdpbGwgb25seSBydW4gb24KcGxhdGZvcm1z
IHRoYXQgY3JlYXRlIHRoZSBwbGF0Zm9ybV9kZXZpY2UgImFybS1iTC1jcHVmcmVxLWR0Ii4KClJl
cG9ydGVkLWJ5OiBSb2IgSGVycmluZyA8cm9iaGVycmluZzJAZ21haWwuY29tPgpTaWduZWQtb2Zm
LWJ5OiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMv
Y3B1ZnJlcS9hcm1fYmlnX2xpdHRsZV9kdC5jIHwgMjAgKysrKysrKysrKysrKysrLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY3B1ZnJlcS9hcm1fYmlnX2xpdHRsZV9kdC5jIGIvZHJpdmVycy9jcHVmcmVx
L2FybV9iaWdfbGl0dGxlX2R0LmMKaW5kZXggMjdlMmY0NS4uZmQ5ZTNlYSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9jcHVmcmVxL2FybV9iaWdfbGl0dGxlX2R0LmMKKysrIGIvZHJpdmVycy9jcHVmcmVx
L2FybV9iaWdfbGl0dGxlX2R0LmMKQEAgLTI2LDYgKzI2LDcgQEAKICNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4KICNpbmNsdWRlIDxsaW51eC9vZi5oPgogI2luY2x1ZGUgPGxpbnV4L29wcC5oPgor
I2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgogI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgogI2luY2x1ZGUgImFybV9iaWdfbGl0dGxlLmgi
CkBAIC05NSw3ICs5Niw3IEBAIHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9hcm1fYkxfb3BzIGR0X2JM
X29wcyA9IHsKIAkuaW5pdF9vcHBfdGFibGUgPSBkdF9pbml0X29wcF90YWJsZSwKIH07CiAKLXN0
YXRpYyBpbnQgZ2VuZXJpY19iTF9pbml0KHZvaWQpCitzdGF0aWMgaW50IGdlbmVyaWNfYkxfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIHsKIAlzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5wOwogCkBAIC0xMDYsMTMgKzEwNywyMiBAQCBzdGF0aWMgaW50IGdlbmVyaWNfYkxfaW5pdCh2
b2lkKQogCW9mX25vZGVfcHV0KG5wKTsKIAlyZXR1cm4gYkxfY3B1ZnJlcV9yZWdpc3RlcigmZHRf
Ykxfb3BzKTsKIH0KLW1vZHVsZV9pbml0KGdlbmVyaWNfYkxfaW5pdCk7CiAKLXN0YXRpYyB2b2lk
IGdlbmVyaWNfYkxfZXhpdCh2b2lkKQorc3RhdGljIGludCBnZW5lcmljX2JMX3JlbW92ZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogewotCXJldHVybiBiTF9jcHVmcmVxX3VucmVnaXN0
ZXIoJmR0X2JMX29wcyk7CisJYkxfY3B1ZnJlcV91bnJlZ2lzdGVyKCZkdF9iTF9vcHMpOworCXJl
dHVybiAwOwogfQotbW9kdWxlX2V4aXQoZ2VuZXJpY19iTF9leGl0KTsKKworc3RhdGljIHN0cnVj
dCBwbGF0Zm9ybV9kcml2ZXIgZ2VuZXJpY19iTF9wbGF0ZHJ2ID0geworCS5kcml2ZXIgPSB7CisJ
CS5uYW1lCT0gImFybS1iTC1jcHVmcmVxLWR0IiwKKwkJLm93bmVyCT0gVEhJU19NT0RVTEUsCisJ
fSwKKwkucHJvYmUJCT0gZ2VuZXJpY19iTF9wcm9iZSwKKwkucmVtb3ZlCQk9IGdlbmVyaWNfYkxf
cmVtb3ZlLAorfTsKK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoZ2VuZXJpY19iTF9wbGF0ZHJ2KTsK
IAogTU9EVUxFX0FVVEhPUigiVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4i
KTsKIE1PRFVMRV9ERVNDUklQVElPTigiR2VuZXJpYyBBUk0gYmlnIExJVFRMRSBjcHVmcmVxIGRy
aXZlciB2aWEgRFQiKTsKLS0gCjEuNy4xMi5yYzIuMTguZzYxYjQ3MmUKCg==
--001a11c2eba08749f904dd1ee1cd--
