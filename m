From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] PM: Constify returned PM event name
Date: Mon, 12 Jun 2017 17:19:31 +0200
Message-ID: <20170612151933.7588-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

The pm_verb() returns a pointer to string from .rodata so it should be
marked as const.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 9faee1c893e5..924a5ba7aa27 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -62,7 +62,7 @@ static pm_message_t pm_transition;
 
 static int async_error;
 
-static char *pm_verb(int event)
+static const char *pm_verb(int event)
 {
 	switch (event) {
 	case PM_EVENT_SUSPEND:
-- 
2.9.3
