From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 25/26] cpu_cooling: Use cpufreq_dev->freq_table for
 finding level/freq
Date: Wed, 3 Dec 2014 10:40:11 +0530
Message-ID: <CAKohponQ0vr7QXFun3GmPsMCGj6VOd3P0of6Hd5p4ZBG-_PxdQ@mail.gmail.com>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
	<8c0412592bfd5524e638252a42edaf08f81f0976.1417167599.git.viresh.kumar@linaro.org>
	<20141202233626.GA3969@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:51245 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbaLCFKM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 00:10:12 -0500
Received: by mail-oi0-f53.google.com with SMTP id x69so10404393oia.12
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 21:10:11 -0800 (PST)
In-Reply-To: <20141202233626.GA3969@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Zhang Rui <rui.zhang@intel.com>

On 3 December 2014 at 05:06, Eduardo Valentin <edubezval@gmail.com> wrote:
>> -     ret = get_property(cpufreq_device, state, &clip_freq, GET_FREQ);
>> -     if (ret)
>> -             return ret;
>> -
>> +     clip_freq = cpufreq_device->freq_table[state];
>
> There should be some check for valid state here..

What about this ??

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 6bd95bc..6e76417 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -228,6 +228,10 @@ static int cpufreq_set_cur_state(struct
thermal_cooling_device *cdev,
        unsigned int cpu = cpumask_any(&cpufreq_device->allowed_cpus);
        unsigned int clip_freq;

+       /* Request state should be less than max_level */
+       if (WARN_ON(state > cpufreq_device->max_level))
+               return -EINVAL;
+
        /* Check if the old cooling action is same as new cooling action */
        if (cpufreq_device->cpufreq_state == state)
                return 0;
