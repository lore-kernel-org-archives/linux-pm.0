From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: power_supply: Add support for TI BQ25890 charger chip
Date: Tue, 26 May 2015 12:04:41 +0300
Message-ID: <20150526090441.GA18601@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1050.oracle.com ([141.146.126.70]:36876 "EHLO
	aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbEZPee (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2015 11:34:34 -0400
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
	by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4Q95pfU022015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2015 09:05:51 GMT
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: laurentiu.palcu@intel.com
Cc: linux-pm@vger.kernel.org

Hello Laurentiu Palcu,

The patch 4aeae9cb0dad: "power_supply: Add support for TI BQ25890
charger chip" from May 19, 2015, leads to the following static
checker warning:

	drivers/power/bq25890_charger.c:843 bq25890_probe()
	warn: impossible condition '(bq->chip_id < 0) => (0-255 < 0)'

drivers/power/bq25890_charger.c
   841  
   842          bq->chip_id = bq25890_field_read(bq, F_PN);
   843          if (bq->chip_id < 0) {
                    ^^^^^^^^^^^^^^^
Never true.

   844                  dev_err(dev, "Cannot read chip ID.\n");
   845                  return ret;
   846          }
   847  

regards,
dan carpenter
