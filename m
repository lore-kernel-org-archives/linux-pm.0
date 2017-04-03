From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [bug report] thermal: devfreq_cooling: refactor code and add
 get_voltage function
Date: Mon, 3 Apr 2017 12:14:34 +0100
Message-ID: <2d406449-e3dd-d51c-5383-fc885008a3c3@arm.com>
References: <20170331151916.GA24860@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbdDCLOh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Apr 2017 07:14:37 -0400
In-Reply-To: <20170331151916.GA24860@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-pm@vger.kernel.org

Hello Dan,

On 31/03/17 16:19, Dan Carpenter wrote:
> Hello Lukasz Luba,
>
> The patch 88db6ba9fd98: "thermal: devfreq_cooling: refactor code and
> add get_voltage function" from Mar 14, 2017, leads to the following
> static checker warning:
>
> 	drivers/thermal/devfreq_cooling.c:187 get_voltage()
> 	error: 'opp' dereferencing possible ERR_PTR()
>
> drivers/thermal/devfreq_cooling.c
>    176  static unsigned long get_voltage(struct devfreq *df, unsigned long freq)
>    177  {
>    178          struct device *dev = df->dev.parent;
>    179          unsigned long voltage;
>    180          struct dev_pm_opp *opp;
>    181
>    182          opp = dev_pm_opp_find_freq_exact(dev, freq, true);
>    183          if (IS_ERR(opp) && (PTR_ERR(opp) == -ERANGE))
>
> Let's imagine that opp is ERR_PTR(-ENOMEM);
>
>    184                  opp = dev_pm_opp_find_freq_exact(dev, freq, false);
>    185
>    186          voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
>    187          dev_pm_opp_put(opp);
>                                ^^^
> Then we would Oops here.
>
>    188
>    189          if (voltage == 0) {
>    190                  dev_warn_ratelimited(dev,
>    191                                       "Failed to get voltage for frequency %lu: %ld\n",
>    192                                       freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
>    193          }
>    194
>    195          return voltage;
>    196  }
>

Thank you for the feedback.
Yes you are right.
I can see that in mainline, commit:
a4e49c9bc98d099b2a19933b
has this fix (also reported by you).

I will re-base the patch set.

Regards,
Lukasz Luba
