From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 02/14] extcon: Make extcon_register_notifier use extcon_get_extcon_dev_by_cable_id
Date: Mon, 19 Dec 2016 01:07:19 +0100
Message-ID: <20161219000731.10188-3-hdegoede@redhat.com>
References: <20161219000731.10188-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219000731.10188-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

Implement extcon_register_notifier's support for a NULL edev argument
using the new extcon_get_extcon_dev_by_cable_id function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 505c272..2816187 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -933,32 +933,19 @@ int extcon_register_notifier(struct extcon_dev *edev, unsigned int id,
 	if (!nb)
 		return -EINVAL;
 
-	if (edev) {
-		idx = find_cable_index_by_id(edev, id);
-		if (idx < 0)
-			return idx;
+	if (!edev) {
+		edev = extcon_get_extcon_dev_by_cable_id(id);
+		if (!edev)
+			return -ENODEV;
+	}
 
-		spin_lock_irqsave(&edev->lock, flags);
-		ret = raw_notifier_chain_register(&edev->nh[idx], nb);
-		spin_unlock_irqrestore(&edev->lock, flags);
-	} else {
-		struct extcon_dev *extd;
-
-		mutex_lock(&extcon_dev_list_lock);
-		list_for_each_entry(extd, &extcon_dev_list, entry) {
-			idx = find_cable_index_by_id(extd, id);
-			if (idx >= 0)
-				break;
-		}
-		mutex_unlock(&extcon_dev_list_lock);
+	idx = find_cable_index_by_id(edev, id);
+	if (idx < 0)
+		return idx;
 
-		if (idx >= 0) {
-			edev = extd;
-			return extcon_register_notifier(extd, id, nb);
-		} else {
-			ret = -ENODEV;
-		}
-	}
+	spin_lock_irqsave(&edev->lock, flags);
+	ret = raw_notifier_chain_register(&edev->nh[idx], nb);
+	spin_unlock_irqrestore(&edev->lock, flags);
 
 	return ret;
 }
-- 
2.9.3
