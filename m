From: Sasha Levin <sasha.levin@oracle.com>
Subject: [PATCH] power, test_power: correctly handle empty writes
Date: Tue, 22 Dec 2015 12:43:36 -0500
Message-ID: <1450806216-22600-1-git-send-email-sasha.levin@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, john.stultz@linaro.org, cbouatmailru@gmail.com, Sasha Levin <sasha.levin@oracle.com>
List-Id: linux-pm@vger.kernel.org

Writing 0 length data into test_power makes it access an invalid array
location and kill the system.

Fixes: f17ef9b2d ("power: Make test_power driver more dynamic.")
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 drivers/power/test_power.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/test_power.c b/drivers/power/test_power.c
index 83c42ea..57246cd 100644
--- a/drivers/power/test_power.c
+++ b/drivers/power/test_power.c
@@ -301,6 +301,8 @@ static int map_get_value(struct battery_property_map *map, const char *key,
 	buf[MAX_KEYLENGTH-1] = '\0';
 
 	cr = strnlen(buf, MAX_KEYLENGTH) - 1;
+	if (cr < 0)
+		return def_val;
 	if (buf[cr] == '\n')
 		buf[cr] = '\0';
 
-- 
1.7.10.4
