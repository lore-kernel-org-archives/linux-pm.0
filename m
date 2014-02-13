From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH 6/6] drivers/acpi: fix thermal driver compile error when CONFIG_PM_SLEEP is undefined
Date: Wed, 12 Feb 2014 20:19:10 -0700
Message-ID: <cf2b092c9e1fcb1ea56d56284745836df45c9c79.1392250669.git.shuah.kh@samsung.com>
References: <cover.1392250669.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:34832 "EHLO
	qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752018AbaBMDTU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2014 22:19:20 -0500
In-Reply-To: <cover.1392250669.git.shuah.kh@samsung.com>
In-Reply-To: <cover.1392250669.git.shuah.kh@samsung.com>
References: <cover.1392250669.git.shuah.kh@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, rui.zhang@intel.com
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, shuahkhan@gmail.com

thermal driver defines acpi_thermal_resume() when CONFIG_PM_SLEEP is de=
fined.
This results in the following compile error when CONFIG_PM_SLEEP is und=
efined.

  CC      drivers/acpi/thermal.o
drivers/acpi/thermal.c:107:8: error: =E2=80=98acpi_thermal_resume=E2=80=
=99 undeclared here (not in a function)
make[2]: *** [drivers/acpi/thermal.o] Error 1

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/acpi/thermal.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 8349a55..08626c8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -102,6 +102,8 @@ MODULE_DEVICE_TABLE(acpi, thermal_device_ids);
=20
 #ifdef CONFIG_PM_SLEEP
 static int acpi_thermal_resume(struct device *dev);
+#else
+#define acpi_thermal_resume NULL
 #endif
 static SIMPLE_DEV_PM_OPS(acpi_thermal_pm, NULL, acpi_thermal_resume);
=20
--=20
1.7.10.4

