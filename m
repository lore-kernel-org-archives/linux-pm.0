From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Date: Wed, 19 Dec 2018 11:14:42 +0530
Message-ID: <20181219054442.ffkyv6bcmrlkgcga@vireshk-i7>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
 <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
 <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
 <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
 <20181218054545.k77jh5lxvmj2zott@vireshk-i7>
 <154516038159.238328.2917665370794230521@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154516038159.238328.2917665370794230521@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On 18-12-18, 11:13, Stephen Boyd wrote:
> I don't see any failure returned from cpufreq_dt's cpufreq_init()
> function. Maybe put a static int counter = 0 and then fail
> cpufreq_init() the second time that it's called for the same policy
> pointer? I have a system with two policies, so I made it fail and return
> -EINVAL when the counter == 2 and I see the lockdep splat.

Yuck. You were so clear on this earlier, how can I forget it. :(

Here is the additional diff. And I do get this print message on my screen while
I try to online CPU4.

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 639feca22d27..b836e93fd87d 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -151,6 +151,11 @@ static int cpufreq_init(struct cpufreq_policy *policy)
        const char *name;
        int ret;
 
+       if (policy->count++) {
+               pr_info("%s: %d\n", __func__, __LINE__);
+               return -EINVAL;
+       }
+
        cpu_dev = get_cpu_device(policy->cpu);
        if (!cpu_dev) {
                pr_err("failed to get cpu%d device\n", policy->cpu);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 882a9b9e34bc..643141a2013f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -151,6 +151,7 @@ struct cpufreq_policy {
 
        /* For cpufreq driver's internal use */
        void                    *driver_data;
+       int                     count;
 };

> I did the following:
> 
>   grep . /sys/devices/system/cpu/cpufreq/*/* >/dev/null
>   echo 0 > /sys/devices/system/cpu/cpu4/online 
>   echo 0 > /sys/devices/system/cpu/cpu5/online 
>   echo 0 > /sys/devices/system/cpu/cpu6/online 
>   echo 0 > /sys/devices/system/cpu/cpu7/online 
>   echo 1 > /sys/devices/system/cpu/cpu4/online 
>   dmesg
> 
> And boom, lockdep splat.

  502  grep . /sys/devices/system/cpu/cpufreq/*/*
  503  echo 0 > /sys/devices/system/cpu/cpu4/online
  504  echo 0 > /sys/devices/system/cpu/cpu5/online
  505  echo 0 > /sys/devices/system/cpu/cpu6/online
  506  echo 0 > /sys/devices/system/cpu/cpu7/online
  507  grep . /sys/devices/system/cpu/cpufreq/*/*
  508  echo 1 > /sys/devices/system/cpu/cpu4/online
  509  dmesg 


But still no lockdep :(

Can you try that on mainline as well ?

-- 
viresh
