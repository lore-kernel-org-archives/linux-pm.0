From: Marek Belisko <marek.belisko@open-nandra.com>
Subject: [RFC PATCH 1/5] dt-bindings: power: Add battery types
Date: Tue,  1 Aug 2017 22:55:22 +0200
Message-ID: <1501620926-22669-2-git-send-email-marek.belisko@open-nandra.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, pavel@ucw.cz, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Marek Belisko <marek.belisko@gmail.com>

Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
---
 include/dt-bindings/power/power.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 include/dt-bindings/power/power.h

diff --git a/include/dt-bindings/power/power.h b/include/dt-bindings/power/power.h
new file mode 100644
index 0000000..ea36d7f
--- /dev/null
+++ b/include/dt-bindings/power/power.h
@@ -0,0 +1,11 @@
+#ifndef _DT_BINDINGS_POWER_H
+#define _DT_BINDINGS_POWER_H
+
+#define POWER_SUPPLY_TECHNOLOGY_NiMH 1
+#define POWER_SUPPLY_TECHNOLOGY_LION 2
+#define POWER_SUPPLY_TECHNOLOGY_LIPO 3
+#define POWER_SUPPLY_TECHNOLOGY_LiFe 4
+#define POWER_SUPPLY_TECHNOLOGY_NiCd 5
+#define POWER_SUPPLY_TECHNOLOGY_LiMn 6
+
+#endif /* _DT_BINDINGS_POWER_H */
-- 
2.7.4
