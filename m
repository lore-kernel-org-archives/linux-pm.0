From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] power: ab8500: cleanup with list_first_entry_or_null()
Date: Tue, 13 Sep 2016 03:23:21 +0900
Message-ID: <1473704601-3217-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The combo of list_empty() check and return list_first_entry()
can be replaced with list_first_entry_or_null().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/power/ab8500_fg.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 5a36cf8..84b7fa9 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -245,13 +245,8 @@ static LIST_HEAD(ab8500_fg_list);
  */
 struct ab8500_fg *ab8500_fg_get(void)
 {
-	struct ab8500_fg *fg;
-
-	if (list_empty(&ab8500_fg_list))
-		return NULL;
-
-	fg = list_first_entry(&ab8500_fg_list, struct ab8500_fg, node);
-	return fg;
+	return list_first_entry_or_null(&ab8500_fg_list, struct ab8500_fg,
+					node);
 }
 
 /* Main battery properties */
-- 
1.9.1
