From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v10 3/6] PM / Domains: make governor select deepest state
Date: Tue, 10 Nov 2015 14:58:13 +0100
Message-ID: <5641F7F5.2040901@baylibre.com>
References: <1445347589-5626-1-git-send-email-ahaslam@baylibre.com>	<1445347589-5626-4-git-send-email-ahaslam@baylibre.com> <CAN2waFvS9sphJTi2_8H2_amnRspgQ_pO1-OJCN0XXcJq03OxAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36698 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbbKJN6S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2015 08:58:18 -0500
Received: by wmww144 with SMTP id w144so118796823wmw.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2015 05:58:16 -0800 (PST)
In-Reply-To: <CAN2waFvS9sphJTi2_8H2_amnRspgQ_pO1-OJCN0XXcJq03OxAw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, geert@glider.be, k.kozlowski.k@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, mturquette@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>

Hi Zhaoyang,


>> @@ -209,14 +186,52 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>>           * The difference between the computed minimum subdomain or device off
>>           * time and the time needed to turn the domain on is the maximum
>>           * theoretical time this domain can spend in the "off" state.
>> -        * Use the only available state, until multiple state support is added
>> -        * to the governor.
>>           */
>>          genpd->max_off_time_ns = min_off_time_ns -
>> -               genpd->states[0].power_on_latency_ns;
>> +                       genpd->states[state].power_on_latency_ns;
>>          return true;
>>   }
> [question]: Does it mean that the sleep level is just decided by
> comparing the pre-configure on_off time with the gpd_timing_data? How
> about the next timer event which affect the sleep depth on cpuidle
> framework?



There are a couple of patches on the list ill try to summarize
what i understand, Lina, Marc please correct me if im wrong!

I did this patches thinking generally about devices in a power domain 
and not so much about a cpu. So these patches are not aimed at replacing 
cpuidle, but were meant for power domains that may have intermediate 
states, for example some logic may be implemented with retention flip-flops.

There is the proposal by Lina [1] to add cpus clusters to powerdomins
and by Marc[2] that tie cluster idle states to the powerdomain handler.
but i think the effort here is to complement cpuidle rather than to
replace it.

regards
Axel

1. https://lwn.net/Articles/653579/
2. https://lwn.net/Articles/658461/

>>
>> +static bool default_power_down_ok(struct dev_pm_domain *pd)
>> +{
>> +       struct generic_pm_domain *genpd = pd_to_genpd(pd);
>> +       unsigned int last_state_idx = genpd->state_count - 1;
>> +       struct gpd_link *link;
>> +       bool retval = false;
>> +       unsigned int i;
>> +
>> +       /*
>> +        * if there was no change on max_off_time, we can return the
>> +        * cached value and we dont need to find a new target_state
>> +        */
>> +       if (!genpd->max_off_time_changed)
>> +               return genpd->cached_power_down_ok;
>> +
>> +       /*
>> +        * We have to invalidate the cached results for the masters, so
>> +        * use the observation that default_power_down_ok() is not
>> +        * going to be called for any master until this instance
>> +        * returns.
>> +        */
>> +       list_for_each_entry(link, &genpd->slave_links, slave_node)
>> +               link->master->max_off_time_changed = true;
>> +
>> +       genpd->max_off_time_ns = -1;
>> +       genpd->max_off_time_changed = false;
>> +
>> +       /* find a state to power down to, starting from the deepest */
>> +       for (i = 0; i < genpd->state_count; i++) {
>> +               if (power_down_ok_for_state(pd, last_state_idx - i)) {
>> +                       genpd->state_idx = last_state_idx - i;
>> +                       retval = true;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       genpd->cached_power_down_ok = retval;
>> +       return retval;
>> +}
>> +
>>   static bool always_on_power_down_ok(struct dev_pm_domain *domain)
>>   {
>>          return false;
> [question]How the TICK_NOHZ treated if we substitute cpuidle framework
> with this one?
>> --
>> 2.4.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
