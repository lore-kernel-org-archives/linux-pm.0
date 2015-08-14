From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: max17042_battery: Support regmap to access device's registers
Date: Fri, 14 Aug 2015 12:55:13 +0300
Message-ID: <20150814095513.GA14436@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:18753 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbbHNJzY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 05:55:24 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jonghwa3.lee@samsung.com
Cc: linux-pm@vger.kernel.org

Hello Jonghwa Lee,

The patch 39e7213edc4f: "max17042_battery: Support regmap to access
device's registers" from Oct 25, 2013, leads to the following static
checker warning:

	drivers/power/max17042_battery.c:501 max17042_init_model()
	warn: passing casted pointer 'temp_data' to 'max17042_model_data_compare()' 32 vs 16.

drivers/power/max17042_battery.c
   469  static inline int max17042_model_data_compare(struct max17042_chip *chip,
   470                                          u16 *data1, u16 *data2, int size)
   471  {
   472          int i;
   473  
   474          if (memcmp(data1, data2, size)) {
                                         ^^^^
data2 is size * sizeof(u32) bytes long so we are only checking the first
quarter of the buffer.  data1 is in size of u16s so I wonder how this
memcmp() works at all?

   475                  dev_err(&chip->client->dev, "%s compare failed\n", __func__);
   476                  for (i = 0; i < size; i++)
                                        ^^^^
Here size is in terms of u16 elements.  The original code mixed u16
units with byte units so it was buggy, but now we are using u32 units so
it's even worse.

   477                          dev_info(&chip->client->dev, "0x%x, 0x%x",
   478                                  data1[i], data2[i]);
   479                  dev_info(&chip->client->dev, "\n");
   480                  return -EINVAL;
   481          }
   482          return 0;
   483  }
   484  
   485  static int max17042_init_model(struct max17042_chip *chip)
   486  {
   487          int ret;
   488          int table_size = ARRAY_SIZE(chip->pdata->config_data->cell_char_tbl);

data1 is any array of u16s.

   489          u32 *temp_data;
   490  
   491          temp_data = kcalloc(table_size, sizeof(*temp_data), GFP_KERNEL);

Here "size" (table_size) is in units of u32 elements.

   492          if (!temp_data)
   493                  return -ENOMEM;
   494  
   495          max10742_unlock_model(chip);
   496          max17042_write_model_data(chip, MAX17042_MODELChrTbl,
   497                                  table_size);
   498          max17042_read_model_data(chip, MAX17042_MODELChrTbl, temp_data,
   499                                  table_size);
                                        ^^^^^^^^^^

Here "size" (table_size) is in units of u32 elements.

   500  
   501          ret = max17042_model_data_compare(
   502                  chip,
   503                  chip->pdata->config_data->cell_char_tbl,
   504                  (u16 *)temp_data,
                        ^^^^^^^^^^^^^^^^
This cast is ugly and causes a static checker warning.

   505                  table_size);
   506  
   507          max10742_lock_model(chip);
   508          kfree(temp_data);
   509  
   510          return ret;
   511  }

regards,
dan carpenter
