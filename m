From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [bug report] cpufreq: scpi: remove arm_big_little dependency
Date: Mon, 22 Jan 2018 14:39:58 +0000
Message-ID: <43ad2be9-4d21-727b-b315-d7330b2256b4@arm.com>
References: <20180122104823.GA25283@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59648 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbeAVOkB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jan 2018 09:40:01 -0500
In-Reply-To: <20180122104823.GA25283@mwanda>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org

Hi Dan,

On 22/01/18 10:48, Dan Carpenter wrote:
> Hello Sudeep Holla,
> 
> The patch 343a8d17fa8d: "cpufreq: scpi: remove arm_big_little
> dependency" from Jan 10, 2018, leads to the following static checker
> warning:
> 
> 	drivers/cpufreq/scpi-cpufreq.c:203 scpi_cpufreq_ready()
> 	warn: 'cdev' isn't an ERR_PTR
> 
> drivers/cpufreq/scpi-cpufreq.c
>    198  static void scpi_cpufreq_ready(struct cpufreq_policy *policy)
>    199  {
>    200          struct scpi_data *priv = policy->driver_data;
>    201          struct thermal_cooling_device *cdev;
>    202  
>    203          cdev = of_cpufreq_cooling_register(policy);
>    204          if (!IS_ERR(cdev))
>    205                  priv->cdev = cdev;
> 
> of_cpufreq_cooling_register() returns NULL on error.  Probably just
> remove the if statement?
> 
>    206  }
> 

Thanks for the report, will post the fix soon.

-- 
Regards,
Sudeep
