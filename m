From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 11/18] power: supply: Fix power_supply_am_i_supplied to return
 -ENODEV when apropriate
Date: Sun,  6 Aug 2017 14:35:48 +0200
Message-ID: <20170806123555.5124-12-hdegoede@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170806123555.5124-1-hdegoede@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit 2848e039c562 ("power: supply: Make power_supply_am_i_supplied return
-ENODEV if there are no suppliers") was supposed to make
power_supply_am_i_supplied() return -ENODEV when there are no supplies
which supply the supply passed to it.

But instead it will only return -ENODEV when there are no supplies at
all as data->count++; is incremented on every call of the iterator, rather
then only when __power_supply_is_supplied_by returns true. This commit
fixes this.

Fixes: 2848e039c562 ("power: supply: Make power_supply_am_i_supplied ...")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 540d3e0aa011..0741fcef3b44 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -314,11 +314,12 @@ static int __power_supply_am_i_supplied(struct device *dev, void *_data)
 	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct psy_am_i_supplied_data *data = _data;
 
-	data->count++;
-	if (__power_supply_is_supplied_by(epsy, data->psy))
+	if (__power_supply_is_supplied_by(epsy, data->psy)) {
+		data->count++;
 		if (!epsy->desc->get_property(epsy, POWER_SUPPLY_PROP_ONLINE,
 					&ret))
 			return ret.intval;
+	}
 
 	return 0;
 }
-- 
2.13.3
