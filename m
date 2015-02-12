From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH 1/5] regulator: Rename regulator_set_optimum_mode
Date: Wed, 11 Feb 2015 19:35:27 -0800
Message-ID: <1423712131-23795-2-git-send-email-bjorn.andersson@sonymobile.com>
References: <1423712131-23795-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423712131-23795-1-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rename the regulator_set_optimum_mode() function regulator_set_load() to
better represent what's going on.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 Documentation/power/regulator/consumer.txt |  2 +-
 drivers/regulator/core.c                   |  8 ++++----
 include/linux/regulator/consumer.h         | 12 +++++++++---
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/power/regulator/consumer.txt b/Documentation/power/regulator/consumer.txt
index 8afb236c..e51564c 100644
--- a/Documentation/power/regulator/consumer.txt
+++ b/Documentation/power/regulator/consumer.txt
@@ -137,7 +137,7 @@ Indirect operating mode control.
 Consumer drivers can request a change in their supply regulator operating mode
 by calling :-
 
-int regulator_set_optimum_mode(struct regulator *regulator, int load_uA);
+int regulator_set_load(struct regulator *regulator, int load_uA);
 
 This will cause the core to recalculate the total load on the regulator (based
 on all its consumers) and change operating mode (if necessary and permitted)
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 27fb349..b137578 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3018,7 +3018,7 @@ unsigned int regulator_get_mode(struct regulator *regulator)
 EXPORT_SYMBOL_GPL(regulator_get_mode);
 
 /**
- * regulator_set_optimum_mode - set regulator optimum operating mode
+ * regulator_set_load - set regulator load
  * @regulator: regulator source
  * @uA_load: load current
  *
@@ -3041,9 +3041,9 @@ EXPORT_SYMBOL_GPL(regulator_get_mode);
  * DRMS will sum the total requested load on the regulator and change
  * to the most efficient operating mode if platform constraints allow.
  *
- * Returns the new regulator mode or error.
+ * On error a negative errno is returned.
  */
-int regulator_set_optimum_mode(struct regulator *regulator, int uA_load)
+int regulator_set_load(struct regulator *regulator, int uA_load)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
@@ -3055,7 +3055,7 @@ int regulator_set_optimum_mode(struct regulator *regulator, int uA_load)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(regulator_set_optimum_mode);
+EXPORT_SYMBOL_GPL(regulator_set_load);
 
 /**
  * regulator_allow_bypass - allow the regulator to go into bypass mode
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index d17e1ff..6d4e9d2 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -238,7 +238,7 @@ int regulator_get_current_limit(struct regulator *regulator);
 
 int regulator_set_mode(struct regulator *regulator, unsigned int mode);
 unsigned int regulator_get_mode(struct regulator *regulator);
-int regulator_set_optimum_mode(struct regulator *regulator, int load_uA);
+int regulator_set_load(struct regulator *regulator, int load_uA);
 
 int regulator_allow_bypass(struct regulator *regulator, bool allow);
 
@@ -479,8 +479,7 @@ static inline unsigned int regulator_get_mode(struct regulator *regulator)
 	return REGULATOR_MODE_NORMAL;
 }
 
-static inline int regulator_set_optimum_mode(struct regulator *regulator,
-					int load_uA)
+static inline int regulator_set_load(struct regulator *regulator, int load_uA)
 {
 	return REGULATOR_MODE_NORMAL;
 }
@@ -555,4 +554,11 @@ static inline int regulator_is_supported_voltage_tol(struct regulator *regulator
 					      target_uV + tol_uV);
 }
 
+/* TEMP: Wrapper to keep bisectability */
+static inline int regulator_set_optimum_mode(struct regulator *regulator,
+					     int load_uA)
+{
+	return regulator_set_load(regulator, load_uA);
+}
+
 #endif
-- 
1.8.2.2
