From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v7 1/5] PM / Domains: prepare for multiple states
Date: Thu, 30 Apr 2015 18:06:38 +0200
Message-ID: <5542530E.80803@baylibre.com>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com> <1430391335-7588-2-git-send-email-ahaslam@baylibre.com> <20150430152959.GD424@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33936 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbD3QGn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 12:06:43 -0400
Received: by wicmx19 with SMTP id mx19so16632505wic.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2015 09:06:42 -0700 (PDT)
In-Reply-To: <20150430152959.GD424@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net, bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

Hi Lina,

On 30/04/2015 17:29, Lina Iyer wrote:
> On Thu, Apr 30 2015 at 04:57 -0600, ahaslam@baylibre.com wrote:
>> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>
>> prepare generic power domain init function parameters
>> to accept a pointer to the states structure that describes
>> the possible states that a power domain can enter.
>>
>> There is no functional change, as support for multiple
>> domains will be added in subsequent patches.
>>
>> Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
>
> <...>
>
>> extern void pm_genpd_init(struct generic_pm_domain *genpd,
>> -              struct dev_power_governor *gov, bool is_off);
>> +              struct dev_power_governor *gov,
>> +              const struct genpd_power_state *states,
>> +              unsigned int state_count, bool is_off);
>>
>
> Wouldnt it be better to setup another function pm_genpd_init_simple()
> that calls into pm_genpd_init() with no arguments?
>
> static inline void pm_genpd_init_simple(struct generic_pm_domain *genpd,
>                                struct dev_power_governor *gov, bool is_off)
> {
>      return pm_genpd_init(genpd, gov, NULL, 0, is_off);
> }

Im not against adding the wrapper if it simplifies things. But, in 
general, i think all latencies should be set, otherwise genpd may 
violate device constraints by turning a power domain off when it should 
not. So maybe, by leaving the arguments, it kind of sends the message to 
the developer that something important is needed.

Regards,
Axel

>
> It would be explicit that way to indicate the new genpd feature that
> would let
> domains support multiple states.
>
> Thanks,
> Lina
