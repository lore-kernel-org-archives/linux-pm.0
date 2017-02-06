From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] PM / OPP: Make _find_opp_table_unlocked() static
Date: Mon,  6 Feb 2017 14:29:55 +0000
Message-ID: <20170206142955.790-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33256 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdBFOaB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 09:30:01 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so9250134pgd.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2017 06:30:01 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/base/power/opp/core.c:49:18: warning:
 symbol '_find_opp_table_unlocked' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 541d32c..91ec323 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -46,7 +46,7 @@ static struct opp_device *_find_opp_dev(const struct device *dev,
 	return NULL;
 }
 
-struct opp_table *_find_opp_table_unlocked(struct device *dev)
+static struct opp_table *_find_opp_table_unlocked(struct device *dev)
 {
 	struct opp_table *opp_table;

