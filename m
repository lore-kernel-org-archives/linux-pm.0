From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: [PATCH 1/2] bq2415x_charger: Remove unnecessary else after return
Date: Thu,  5 Mar 2015 13:23:56 +0200
Message-ID: <1425554637-26782-2-git-send-email-anda-maria.nicolae@intel.com>
References: <1425554637-26782-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425554637-26782-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: anda-maria.nicolae@intel.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Fix coding style to comply with checkpatch.pl

Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
---
 drivers/power/bq2415x_charger.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index e384844..628a2ed 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -352,8 +352,7 @@ static int bq2415x_exec_command(struct bq2415x_device *bq,
 			BQ2415X_BIT_CE);
 		if (ret < 0)
 			return ret;
-		else
-			return ret > 0 ? 0 : 1;
+		return ret > 0 ? 0 : 1;
 	case BQ2415X_CHARGER_ENABLE:
 		return bq2415x_i2c_write_bit(bq, BQ2415X_REG_CONTROL,
 				0, BQ2415X_BIT_CE);
@@ -426,20 +425,17 @@ static enum bq2415x_chip bq2415x_detect_chip(struct bq2415x_device *bq)
 		case 0:
 			if (bq->chip == BQ24151A)
 				return bq->chip;
-			else
-				return BQ24151;
+			return BQ24151;
 		case 1:
 			if (bq->chip == BQ24150A ||
 				bq->chip == BQ24152 ||
 				bq->chip == BQ24155)
 				return bq->chip;
-			else
-				return BQ24150;
+			return BQ24150;
 		case 2:
 			if (bq->chip == BQ24153A)
 				return bq->chip;
-			else
-				return BQ24153;
+			return BQ24153;
 		default:
 			return BQUNKNOWN;
 		}
@@ -450,8 +446,7 @@ static enum bq2415x_chip bq2415x_detect_chip(struct bq2415x_device *bq)
 		case 0:
 			if (bq->chip == BQ24156A)
 				return bq->chip;
-			else
-				return BQ24156;
+			return BQ24156;
 		case 2:
 			return BQ24158;
 		default:
@@ -480,8 +475,7 @@ static int bq2415x_detect_revision(struct bq2415x_device *bq)
 	case BQ24152:
 		if (ret >= 0 && ret <= 3)
 			return ret;
-		else
-			return -1;
+		return -1;
 	case BQ24153:
 	case BQ24153A:
 	case BQ24156:
@@ -491,13 +485,11 @@ static int bq2415x_detect_revision(struct bq2415x_device *bq)
 			return 0;
 		else if (ret == 1)
 			return 1;
-		else
-			return -1;
+		return -1;
 	case BQ24155:
 		if (ret == 3)
 			return 3;
-		else
-			return -1;
+		return -1;
 	case BQUNKNOWN:
 		return -1;
 	}
-- 
1.7.9.5
