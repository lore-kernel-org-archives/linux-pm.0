From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [PATCH] max17042_battery: fix model download bug.
Date: Thu, 28 Jul 2016 14:07:17 -0400
Message-ID: <CAGngYiULgg3Dzgu4q==wqefNBa4aL7Ai7b0-LDKNE2TjSBebKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:32823 "EHLO
	mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbcG1SHS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2016 14:07:18 -0400
Received: by mail-ua0-f194.google.com with SMTP id 39so2866373uah.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2016 11:07:18 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>

The device's model download function returns the model data as
an array of u32s, which is later compared to the reference
model data. However, since the latter is an array of u16s,
the comparison does not happen correctly, and model verification
fails. This in turn breaks the POR initialization sequence.

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 drivers/power/max17042_battery.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 9c65f13..da7a75f 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -457,13 +457,16 @@ static inline void
max17042_write_model_data(struct max17042_chip *chip,
 }

 static inline void max17042_read_model_data(struct max17042_chip *chip,
- u8 addr, u32 *data, int size)
+ u8 addr, u16 *data, int size)
 {
  struct regmap *map = chip->regmap;
  int i;
+ u32 tmp;

- for (i = 0; i < size; i++)
- regmap_read(map, addr + i, &data[i]);
+ for (i = 0; i < size; i++) {
+ regmap_read(map, addr + i, &tmp);
+ data[i] = (u16)tmp;
+ }
 }

 static inline int max17042_model_data_compare(struct max17042_chip *chip,
@@ -486,7 +489,7 @@ static int max17042_init_model(struct max17042_chip *chip)
 {
  int ret;
  int table_size = ARRAY_SIZE(chip->pdata->config_data->cell_char_tbl);
- u32 *temp_data;
+ u16 *temp_data;

  temp_data = kcalloc(table_size, sizeof(*temp_data), GFP_KERNEL);
  if (!temp_data)
@@ -501,7 +504,7 @@ static int max17042_init_model(struct max17042_chip *chip)
  ret = max17042_model_data_compare(
  chip,
  chip->pdata->config_data->cell_char_tbl,
- (u16 *)temp_data,
+ temp_data,
  table_size);

  max10742_lock_model(chip);
@@ -514,7 +517,7 @@ static int max17042_verify_model_lock(struct
max17042_chip *chip)
 {
  int i;
  int table_size = ARRAY_SIZE(chip->pdata->config_data->cell_char_tbl);
- u32 *temp_data;
+ u16 *temp_data;
  int ret = 0;

  temp_data = kcalloc(table_size, sizeof(*temp_data), GFP_KERNEL);
-- 
1.9.1
