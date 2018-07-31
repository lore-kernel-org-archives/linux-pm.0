From: "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v3 2/4] power: bq25890_charger.c: Remove unused table entries
Date: Tue, 31 Jul 2018 10:43:14 -0600
Message-ID: <20180731164316.32696-3-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731164316.32696-1-angus@akkea.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731164316.32696-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Angus Ainslie (Purism)" <angus@akkea.ca>
List-Id: linux-pm@vger.kernel.org

There are a few table entries that aren't used. Drop them.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/power/supply/bq25890_charger.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 7f0b3a46c50c..ca61278e932e 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -244,10 +244,7 @@ enum bq25890_table_ids {
 	/* range tables */
 	TBL_ICHG,
 	TBL_ITERM,
-	TBL_IPRECHG,
 	TBL_VREG,
-	TBL_BATCMP,
-	TBL_VCLAMP,
 	TBL_BOOSTV,
 	TBL_SYSVMIN,
 
@@ -287,8 +284,6 @@ static const union {
 	[TBL_ICHG] =	{ .rt = {0,	  5056000, 64000} },	 /* uA */
 	[TBL_ITERM] =	{ .rt = {64000,   1024000, 64000} },	 /* uA */
 	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
-	[TBL_BATCMP] =	{ .rt = {0,	  140,     20} },	 /* mOhm */
-	[TBL_VCLAMP] =	{ .rt = {0,	  224000,  32000} },	 /* uV */
 	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
 	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
 
-- 
2.17.1
