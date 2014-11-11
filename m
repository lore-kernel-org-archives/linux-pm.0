From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: PM / clock_ops: Add pm_clk_add_clk()
Date: Tue, 11 Nov 2014 16:04:14 +0300
Message-ID: <20141111130414.GB19962@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42805 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaKKNDE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Nov 2014 08:03:04 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: geert+renesas@glider.be
Cc: linux-pm@vger.kernel.org

Hello Geert Uytterhoeven,

The patch 245bd6f6af8a: "PM / clock_ops: Add pm_clk_add_clk()" from
Nov 6, 2014, leads to the following static checker warning:

	drivers/base/power/clock_ops.c:98 __pm_clk_add()
	warn: 'ce->clk' isn't an ERR_PTR

drivers/base/power/clock_ops.c
    74  static int __pm_clk_add(struct device *dev, const char *con_id,
    75                          struct clk *clk)
    76  {
    77          struct pm_subsys_data *psd = dev_to_psd(dev);
    78          struct pm_clock_entry *ce;
    79  
    80          if (!psd)
    81                  return -EINVAL;
    82  
    83          ce = kzalloc(sizeof(*ce), GFP_KERNEL);
    84          if (!ce) {
    85                  dev_err(dev, "Not enough memory for clock entry.\n");
    86                  return -ENOMEM;
    87          }
    88  
    89          if (con_id) {
    90                  ce->con_id = kstrdup(con_id, GFP_KERNEL);
    91                  if (!ce->con_id) {
    92                          dev_err(dev,
    93                                  "Not enough memory for clock connection ID.\n");
    94                          kfree(ce);
    95                          return -ENOMEM;
    96                  }
    97          } else {
    98                  if (IS_ERR(ce->clk) || !__clk_get(clk)) {
                                   ^^^^^^^
ce->clk is still zero because it comes from kzalloc().  I don't know
what was intended here.

    99                          kfree(ce);
   100                          return -ENOENT;
   101                  }
   102                  ce->clk = clk;
   103          }

regards,
dan carpenter
