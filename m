From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] thermal: devfreq_cooling: refactor code and add
 get_voltage function
Date: Fri, 31 Mar 2017 18:19:16 +0300
Message-ID: <20170331151916.GA24860@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:28562 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933035AbdCaPT2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 11:19:28 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org

Hello Lukasz Luba,

The patch 88db6ba9fd98: "thermal: devfreq_cooling: refactor code and
add get_voltage function" from Mar 14, 2017, leads to the following
static checker warning:

	drivers/thermal/devfreq_cooling.c:187 get_voltage()
	error: 'opp' dereferencing possible ERR_PTR()

drivers/thermal/devfreq_cooling.c
   176  static unsigned long get_voltage(struct devfreq *df, unsigned long freq)
   177  {
   178          struct device *dev = df->dev.parent;
   179          unsigned long voltage;
   180          struct dev_pm_opp *opp;
   181  
   182          opp = dev_pm_opp_find_freq_exact(dev, freq, true);
   183          if (IS_ERR(opp) && (PTR_ERR(opp) == -ERANGE))

Let's imagine that opp is ERR_PTR(-ENOMEM);

   184                  opp = dev_pm_opp_find_freq_exact(dev, freq, false);
   185  
   186          voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
   187          dev_pm_opp_put(opp);
                               ^^^
Then we would Oops here.

   188  
   189          if (voltage == 0) {
   190                  dev_warn_ratelimited(dev,
   191                                       "Failed to get voltage for frequency %lu: %ld\n",
   192                                       freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
   193          }
   194  
   195          return voltage;
   196  }

regards,
dan carpenter
