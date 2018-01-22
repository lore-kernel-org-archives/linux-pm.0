From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] cpufreq: scpi: remove arm_big_little dependency
Date: Mon, 22 Jan 2018 13:48:23 +0300
Message-ID: <20180122104823.GA25283@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:52236 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbeAVKsl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jan 2018 05:48:41 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep.Holla@arm.com
Cc: linux-pm@vger.kernel.org

Hello Sudeep Holla,

The patch 343a8d17fa8d: "cpufreq: scpi: remove arm_big_little
dependency" from Jan 10, 2018, leads to the following static checker
warning:

	drivers/cpufreq/scpi-cpufreq.c:203 scpi_cpufreq_ready()
	warn: 'cdev' isn't an ERR_PTR

drivers/cpufreq/scpi-cpufreq.c
   198  static void scpi_cpufreq_ready(struct cpufreq_policy *policy)
   199  {
   200          struct scpi_data *priv = policy->driver_data;
   201          struct thermal_cooling_device *cdev;
   202  
   203          cdev = of_cpufreq_cooling_register(policy);
   204          if (!IS_ERR(cdev))
   205                  priv->cdev = cdev;

of_cpufreq_cooling_register() returns NULL on error.  Probably just
remove the if statement?

   206  }

regards,
dan carpenter
