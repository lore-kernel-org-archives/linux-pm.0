From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 16/16] MAINTAINERS: Add AXP288 PMIC entry
Date: Tue, 26 Dec 2017 13:59:14 +0100
Message-ID: <20171226125914.10235-16-hdegoede@redhat.com>
References: <20171226125914.10235-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbdLZM7f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Dec 2017 07:59:35 -0500
In-Reply-To: <20171226125914.10235-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Add an entry for the AXP288 PMIC drivers with myself as maintainer.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0749864ee655..95e99695f919 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14857,6 +14857,12 @@ F:	include/linux/workqueue.h
 F:	kernel/workqueue.c
 F:	Documentation/core-api/workqueue.rst
 
+X-POWERS AXP288 PMIC DRIVERS
+M:	Hans de Goede <hdegoede@redhat.com>
+S:	Maintained
+N:	axp288
+F:	drivers/acpi/pmic/intel_pmic_xpower.c
+
 X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS
 M:	Chen-Yu Tsai <wens@csie.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.14.3
