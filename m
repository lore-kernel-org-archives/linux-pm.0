From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 2/8] tools/thermal: tmon: add min/max macros
Date: Tue, 17 Feb 2015 18:18:30 -0800
Message-ID: <1424225916-13488-3-git-send-email-computersforpeace@gmail.com>
References: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, jacob.jun.pan@linux.intel.com
Cc: Neil Horman <nhorman@tuxdriver.com>, Brian Norris <computersforpeace@gmail.com>, Javi Merino <javi.merino@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 tools/thermal/tmon/tui.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 89f8ef0e15c8..43c5aecf71da 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -30,6 +30,18 @@
 
 #include "tmon.h"
 
+#define min(x, y) ({				\
+	typeof(x) _min1 = (x);			\
+	typeof(y) _min2 = (y);			\
+	(void) (&_min1 == &_min2);		\
+	_min1 < _min2 ? _min1 : _min2; })
+
+#define max(x, y) ({				\
+	typeof(x) _max1 = (x);			\
+	typeof(y) _max2 = (y);			\
+	(void) (&_max1 == &_max2);		\
+	_max1 > _max2 ? _max1 : _max2; })
+
 static PANEL *data_panel;
 static PANEL *dialogue_panel;
 static PANEL *top;
-- 
1.9.1
