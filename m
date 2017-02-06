From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] PM / OPP: Update OPP users to put reference
Date: Mon, 6 Feb 2017 11:52:31 +0300
Message-ID: <20170206083100.GA13489@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:33028 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdBFIwq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 03:52:46 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org

Hello Viresh Kumar,

The patch 8a31d9d94297: "PM / OPP: Update OPP users to put reference"
from Jan 23, 2017, leads to the following static checker warning:

	drivers/thermal/devfreq_cooling.c:193 get_static_power()
	error: 'opp' dereferencing possible ERR_PTR()

drivers/thermal/devfreq_cooling.c
   177  static unsigned long
   178  get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
   179  {
   180          struct devfreq *df = dfc->devfreq;
   181          struct device *dev = df->dev.parent;
   182          unsigned long voltage;
   183          struct dev_pm_opp *opp;
   184  
   185          if (!dfc->power_ops->get_static_power)
   186                  return 0;
   187  
   188          opp = dev_pm_opp_find_freq_exact(dev, freq, true);
   189          if (IS_ERR(opp) && (PTR_ERR(opp) == -ERANGE))

You could just write:

		if (PTR_ERR(opp) == -ERANGE))

Or was || intended instead of &&?

   190                  opp = dev_pm_opp_find_freq_exact(dev, freq, false);
   191  
   192          voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
   193          dev_pm_opp_put(opp);

Anyway, we added a new dereference here, inside the function.

   194  
   195          if (voltage == 0) {
   196                  dev_warn_ratelimited(dev,
   197                                       "Failed to get voltage for frequency %lu: %ld\n",
   198                                       freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
   199                  return 0;
   200          }
   201  
   202          return dfc->power_ops->get_static_power(df, voltage);
   203  }

The same thing for get_static_power() in drivers/thermal/cpu_cooling.c.

    drivers/thermal/cpu_cooling.c:399 get_static_power()
    error: 'opp' dereferencing possible ERR_PTR()


regards,
dan carpenter
