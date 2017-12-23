From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] battery: hook_mutex can be static
Date: Sat, 23 Dec 2017 19:04:30 +0800
Message-ID: <20171223110430.GA50455@xian>
References: <20171220151536.GA12278@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32800 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbdLWLEn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 23 Dec 2017 06:04:43 -0500
Content-Disposition: inline
In-Reply-To: <20171220151536.GA12278@thinkpad>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: kbuild-all@01.org, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>


Fixes: 19380b8e214c ("battery: Add the battery hooking API")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 battery.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 1794408..9324591 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -640,9 +640,9 @@ static const struct device_attribute alarm_attr = {
 
 LIST_HEAD(acpi_battery_list);
 LIST_HEAD(battery_hook_list);
-DEFINE_MUTEX(hook_mutex);
+static DEFINE_MUTEX(hook_mutex);
 
-void __battery_hook_unregister(struct acpi_battery_hook *hook, int force)
+static void __battery_hook_unregister(struct acpi_battery_hook *hook, int force)
 {
 	struct list_head *position;
 	struct acpi_battery *battery;
