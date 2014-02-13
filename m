From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH 4/6] drivers/acpi: fix fan driver compile error when CONFIG_PM_SLEEP is undefined
Date: Wed, 12 Feb 2014 20:19:08 -0700
Message-ID: <1e50ddee5b89d7566b9af4f5cb8b54e2614f04c0.1392250669.git.shuah.kh@samsung.com>
References: <cover.1392250669.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1392250669.git.shuah.kh@samsung.com>
In-Reply-To: <cover.1392250669.git.shuah.kh@samsung.com>
References: <cover.1392250669.git.shuah.kh@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, rui.zhang@intel.com
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

fan driver defines acpi_fan_suspend() and acpi_fan_resume() when
CONFIG_PM_SLEEP is defined. This results in the following compile error=
 when
CONFIG_PM_SLEEP is undefined.

drivers/acpi/fan.c:60:8: error: =E2=80=98acpi_fan_suspend=E2=80=99 unde=
clared here (not in a function)
drivers/acpi/fan.c:60:8: error: =E2=80=98acpi_fan_resume=E2=80=99 undec=
lared here (not in a function)

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/acpi/fan.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 1fb6290..09e423f 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -55,6 +55,9 @@ MODULE_DEVICE_TABLE(acpi, fan_device_ids);
 #ifdef CONFIG_PM_SLEEP
 static int acpi_fan_suspend(struct device *dev);
 static int acpi_fan_resume(struct device *dev);
+#else
+#define acpi_fan_suspend NULL
+#define acpi_fan_resume NULL
 #endif
 static SIMPLE_DEV_PM_OPS(acpi_fan_pm, acpi_fan_suspend, acpi_fan_resum=
e);
=20
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
