From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH 2/6] drivers/acpi: fix battery driver compile error when CONFIG_PM_SLEEP is undefined
Date: Wed, 12 Feb 2014 20:19:06 -0700
Message-ID: <3983d1980b59ffb8522b0e26e60f8587c554438d.1392250669.git.shuah.kh@samsung.com>
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

battery driver defines acpi_battery_resume() when CONFIG_PM_SLEEP is de=
fined.
This results in the following compile error when CONFIG_PM_SLEEP is und=
efined.

drivers/acpi/battery.c:847:8: error: =E2=80=98acpi_battery_resume=E2=80=
=99 undeclared here (not in a function)

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/acpi/battery.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 018a428..797a693 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -841,6 +841,8 @@ static int acpi_battery_resume(struct device *dev)
 	acpi_battery_update(battery);
 	return 0;
 }
+#else
+#define acpi_battery_resume NULL
 #endif
=20
 static SIMPLE_DEV_PM_OPS(acpi_battery_pm, NULL, acpi_battery_resume);
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
