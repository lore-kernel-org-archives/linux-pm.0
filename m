From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC PATCHv2 04/19] power_supply: sysfs: Use power_supply_*() API for
 accessing function attrs
Date: Mon, 05 Jan 2015 16:47:47 +0100
Message-ID: <1420472882-10463-5-git-send-email-k.kozlowski@samsung.com>
References: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Replace direct calls to power supply function attributes with wrappers.
Wrappers provide safe access in case of unregistering the power
supply (e.g. by removing the driver). Replace:
 - get_property -> power_supply_get_property
 - set_property -> power_supply_set_property
 - property_is_writeable -> power_supply_property_is_writeable

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Jonghwa Lee <jonghwa3.lee@samusng.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/power/power_supply_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index 62653f50a524..f817aab80813 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -76,7 +76,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 	if (off == POWER_SUPPLY_PROP_TYPE) {
 		value.intval = psy->type;
 	} else {
-		ret = psy->get_property(psy, off, &value);
+		ret = power_supply_get_property(psy, off, &value);
 
 		if (ret < 0) {
 			if (ret == -ENODATA)
@@ -125,7 +125,7 @@ static ssize_t power_supply_store_property(struct device *dev,
 
 	value.intval = long_val;
 
-	ret = psy->set_property(psy, off, &value);
+	ret = power_supply_set_property(psy, off, &value);
 	if (ret < 0)
 		return ret;
 
@@ -223,7 +223,7 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 
 		if (property == attrno) {
 			if (psy->property_is_writeable &&
-			    psy->property_is_writeable(psy, property) > 0)
+			    power_supply_property_is_writeable(psy, property) > 0)
 				mode |= S_IWUSR;
 
 			return mode;
-- 
1.9.1
