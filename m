From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] PM / OPP: Make local function ti_opp_supply_set_opp() static
Date: Wed, 20 Dec 2017 05:44:40 +0000
Message-ID: <1513748680-163750-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:2735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751698AbdLTFj4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Dec 2017 00:39:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org

Fixes the following sparse warning:

drivers/opp/ti-opp-supply.c:276:5: warning:
 symbol 'ti_opp_supply_set_opp' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/opp/ti-opp-supply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index 44dae3e..370eff3 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -273,7 +273,7 @@ static int _opp_set_voltage(struct device *dev,
  *
  * Return: If successful, 0, else appropriate error value.
  */
-int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
+static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
 {
 	struct dev_pm_opp_supply *old_supply_vdd = &data->old_opp.supplies[0];
 	struct dev_pm_opp_supply *old_supply_vbb = &data->old_opp.supplies[1];
