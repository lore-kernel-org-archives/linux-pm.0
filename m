From: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/9] power/reset: brcmstb: Add support for old 65nm chips
Date: Tue, 25 Nov 2014 16:49:48 -0800
Message-ID: <1416962994-27095-4-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marc.ceeeee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The register bit fields are a little different, so add an entry and a
compatible string to accommodate them.

Signed-off-by: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt | 4 +++-
 drivers/power/reset/brcmstb-reboot.c                   | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
index 3c436cc..430608e 100644
--- a/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
@@ -79,7 +79,9 @@ reboot
 Required properties
 
     - compatible
-        The string property "brcm,brcmstb-reboot".
+        The string property "brcm,brcmstb-reboot" for 40nm/28nm chips with
+        the new SYS_CTRL interface, or "brcm,bcm7038-reboot" for 65nm
+        chips with the old SUN_TOP_CTRL interface.
 
     - syscon
         A phandle / integer array that points to the syscon node which describes
diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 4e61c3f..33af4f3 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -88,8 +88,14 @@ static const struct reset_reg_mask reset_bits_40nm = {
 	.sw_mstr_rst_mask = BIT(0),
 };
 
+static const struct reset_reg_mask reset_bits_65nm = {
+	.rst_src_en_mask = BIT(3),
+	.sw_mstr_rst_mask = BIT(31),
+};
+
 static const struct of_device_id of_match[] = {
 	{ .compatible = "brcm,brcmstb-reboot", .data = &reset_bits_40nm },
+	{ .compatible = "brcm,bcm7038-reboot", .data = &reset_bits_65nm },
 	{},
 };
 
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
