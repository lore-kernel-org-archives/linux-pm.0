From: Colin King <colin.king@canonical.com>
Subject: [PATCH] PM / Domains: check for negative return from of_count_phandle_with_args
Date: Tue, 25 Oct 2016 17:33:27 +0100
Message-ID: <20161025163327.2179-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41529 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757781AbcJYQdf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 12:33:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The return from of_count_phandle_with_args can be negative, so we
should avoid kcalloc of a negative count of genpd_power_stat structs
by sanity checking if count is zero or less.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index aac656a..661737c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2113,7 +2113,7 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 	struct of_phandle_iterator it;
 
 	count = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
-	if (!count)
+	if (count <= 0)
 		return -EINVAL;
 
 	st = kcalloc(count, sizeof(*st), GFP_KERNEL);
-- 
2.9.3

