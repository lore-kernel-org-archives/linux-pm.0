From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v8 3/6] power: supply: Add error checking of psy desc during
 registration
Date: Mon, 23 Apr 2018 15:10:58 +0100
Message-ID: <627b8dcdee758c2598c6cf68b0ce536d3e557ca4.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

Currently there's no error checking of this parameter in the
registration function and it's blindly added to psy class and
subsequently used as is. For example if this is NULL the call
to psy_register_thermal() will try to dereference the pointer
thus causing a kernel dump.

This commit updates the registration code to add some basic
checks on the desc pointer validity, name, and presence of
properties.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/power/supply/power_supply_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index feac7b0..a7984af 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -849,6 +849,9 @@ static void psy_unregister_cooler(struct power_supply *psy)
 		pr_warn("%s: Expected proper parent device for '%s'\n",
 			__func__, desc->name);
 
+	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
+		return ERR_PTR(-EINVAL);
+
 	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
 	if (!psy)
 		return ERR_PTR(-ENOMEM);
-- 
1.9.1
