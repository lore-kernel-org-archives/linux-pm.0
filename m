From: Colin King <colin.king@canonical.com>
Subject: [PATCH][V2] power: supply: cros_usbpd: remove unused pointer 'dev'
Date: Wed, 29 Aug 2018 15:51:06 +0100
Message-ID: <20180829145106.9847-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sameer Nanda <snanda@chromium.org>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'dev' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
variable 'dev' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: change subject to include 'cros_usbpd' and also send to Sameer.

---
 drivers/power/supply/cros_usbpd-charger.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 688a16bacfbb..f2b8de502b82 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -378,12 +378,10 @@ static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
 {
 	struct cros_ec_device *ec_device;
 	struct charger_data *charger;
-	struct device *dev;
 	u32 host_event;
 
 	charger = container_of(nb, struct charger_data, notifier);
 	ec_device = charger->ec_device;
-	dev = charger->dev;
 
 	host_event = cros_ec_get_host_event(ec_device);
 	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
-- 
2.17.1
