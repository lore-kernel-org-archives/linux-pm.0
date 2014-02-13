From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH 5/6] drivers/acpi: fix sbs driver compile error when CONFIG_PM_SLEEP is undefined
Date: Wed, 12 Feb 2014 20:19:09 -0700
Message-ID: <9b235e287cc48364565278baeee69accc96264e7.1392250669.git.shuah.kh@samsung.com>
References: <cover.1392250669.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:41472 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752023AbaBMDTT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2014 22:19:19 -0500
In-Reply-To: <cover.1392250669.git.shuah.kh@samsung.com>
In-Reply-To: <cover.1392250669.git.shuah.kh@samsung.com>
References: <cover.1392250669.git.shuah.kh@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, rui.zhang@intel.com
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, shuahkhan@gmail.com

sbs driver defines acpi_sbs_resume() when CONFIG_PM_SLEEP is defined. T=
his
results in the following compile error when CONFIG_PM_SLEEP is undefine=
d.

  CC [M]  drivers/acpi/sbs.o
drivers/acpi/sbs.c:674:8: error: =E2=80=98acpi_sbs_resume=E2=80=99 unde=
clared here (not in a function)

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/acpi/sbs.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index d465ae6..48c92c6 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -668,6 +668,8 @@ static int acpi_sbs_resume(struct device *dev)
 	acpi_sbs_callback(sbs);
 	return 0;
 }
+#else
+#define acpi_sbs_resume NULL
 #endif
=20
 static SIMPLE_DEV_PM_OPS(acpi_sbs_pm, NULL, acpi_sbs_resume);
--=20
1.7.10.4

