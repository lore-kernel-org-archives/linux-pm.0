From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v7 1/5] PM / Domains: prepare for multiple states
Date: Fri, 1 May 2015 10:31:45 -0600
Message-ID: <20150501163145.GD6388@linaro.org>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
 <1430391335-7588-2-git-send-email-ahaslam@baylibre.com>
 <20150430152959.GD424@linaro.org>
 <5542530E.80803@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33468 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbbEAQbr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2015 12:31:47 -0400
Received: by igbpi8 with SMTP id pi8so30700752igb.0
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2015 09:31:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5542530E.80803@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net, bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

On Thu, Apr 30 2015 at 10:06 -0600, Axel Haslam wrote:
>Hi Lina,
>
>On 30/04/2015 17:29, Lina Iyer wrote:
>>On Thu, Apr 30 2015 at 04:57 -0600, ahaslam@baylibre.com wrote:
>>>From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>>
>>>prepare generic power domain init function parameters
>>>to accept a pointer to the states structure that describes
>>>the possible states that a power domain can enter.
>>>
>>>There is no functional change, as support for multiple
>>>domains will be added in subsequent patches.
>>>
>>>Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
>>
>><...>
>>
>>>extern void pm_genpd_init(struct generic_pm_domain *genpd,
>>>-              struct dev_power_governor *gov, bool is_off);
>>>+              struct dev_power_governor *gov,
>>>+              const struct genpd_power_state *states,
>>>+              unsigned int state_count, bool is_off);
>>>
>>
>>Wouldnt it be better to setup another function pm_genpd_init_simple()
>>that calls into pm_genpd_init() with no arguments?
>>
>>static inline void pm_genpd_init_simple(struct generic_pm_domain *genpd,
>>                               struct dev_power_governor *gov, bool is_off)
>>{
>>     return pm_genpd_init(genpd, gov, NULL, 0, is_off);
>>}
>
>Im not against adding the wrapper if it simplifies things. But, in 
>general, i think all latencies should be set, otherwise genpd may 
>violate device constraints by turning a power domain off when it 
>should not. So maybe, by leaving the arguments, it kind of sends the 
>message to the developer that something important is needed.

hmm. Alright.

>
>Regards,
>Axel
>
>>
>>It would be explicit that way to indicate the new genpd feature that
>>would let
>>domains support multiple states.
>>
>>Thanks,
>>Lina
