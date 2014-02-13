From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH 3/6] drivers/acpi: fix button driver compile error when CONFIG_PM_SLEEP is undefined
Date: Wed, 12 Feb 2014 20:19:07 -0700
Message-ID: <c70a2e451d6f3800c0e571d6bfafa75b7a84b7e2.1392250669.git.shuah.kh@samsung.com>
References: <cover.1392250669.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:56470 "EHLO
	qmta03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462AbaBMDTR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2014 22:19:17 -0500
In-Reply-To: <cover.1392250669.git.shuah.kh@samsung.com>
In-Reply-To: <cover.1392250669.git.shuah.kh@samsung.com>
References: <cover.1392250669.git.shuah.kh@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, rui.zhang@intel.com
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, shuahkhan@gmail.com

button driver defines acpi_button_resume() when CONFIG_PM_SLEEP is defi=
ned.
This results in the following compile error when CONFIG_PM_SLEEP is und=
efined.

drivers/acpi/button.c:85:8: error: =E2=80=98acpi_button_resume=E2=80=99=
 undeclared here (not in a function)

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/acpi/button.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 11c11f6..714e957 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -80,6 +80,8 @@ static void acpi_button_notify(struct acpi_device *de=
vice, u32 event);
=20
 #ifdef CONFIG_PM_SLEEP
 static int acpi_button_resume(struct device *dev);
+#else
+#define acpi_button_resume NULL
 #endif
 static SIMPLE_DEV_PM_OPS(acpi_button_pm, NULL, acpi_button_resume);
=20
--=20
1.7.10.4

