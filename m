From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 01/14] PM / Domains: Allow domain power states to be
 read from DT
Date: Thu, 4 Aug 2016 09:08:54 -0600
Message-ID: <20160804150854.GB1207@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-2-git-send-email-lina.iyer@linaro.org>
 <20160804132407.GA1732@brendan-thinkstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35991 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964853AbcHDPI5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2016 11:08:57 -0400
Received: by mail-pf0-f180.google.com with SMTP id h186so87413351pfg.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2016 08:08:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160804132407.GA1732@brendan-thinkstation>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brendan Jackman <brendan.jackman@arm.com>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>

On Thu, Aug 04 2016 at 07:24 -0600, Brendan Jackman wrote:
>Hi Lina,
>
>Couple of nitpicks here:
>
>On Fri, Jul 29, 2016 at 03:56:12PM -0600, Lina Iyer wrote:
>> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>
>> This patch allows domains to define idle states in the DT. SoC's can
>> define domain idle states in DT using the "power-states" property of the
>> domain provider. Calling of_pm_genpd_init() will  read the idle states
>> and initialize the genpd for the domain.
>>
>
>The commit message got out of sync here, the idle states property is not
>"power-states" but "domain-idle-states" now.
>
Ah, yes. Will amend the comit text.
>> In addition to the entry and exit latency for idle state, also add
>> residency and state-param properties. A domain idling in a state is only
>> power effecient if it stays idle for a certain period in that state. The
>> residency provides this minimum time for the idle state to provide power
>> benefits. The state-param is a state specific u32 value that the
>> platform may use for that idle state.
>>
>
>And "state-param" isn't used any more, since the patchset switched to using
>arm,idle-state.
>
Ok.

>> [snip]
>> +int pm_genpd_of_parse_power_states(struct generic_pm_domain *genpd)
>> +{
>> +	struct device_node *np;
>> +	int i, err = 0;
>> +
>> +	for (i = 0; i < GENPD_MAX_NUM_STATES; i++) {
>> +		np = of_parse_phandle(genpd->of_node, "domain-idle-states", i);
>> +		if (!np)
>> +			break;
>> +
>> +		err = genpd_of_get_power_state(&genpd->states[i], np);
>> +		if (err) {
>> +			pr_err
>> +			    ("Parsing idle state node %s failed with err %d\n",
>> +			     np->full_name, err);
>> +			err = -EINVAL;
>
>I guess there should be an of_node_put here.
>
Right. Will add it in.

Thanks,
Lina

>> +			break;
>> +		}
>> +		of_node_put(np);
>> +	}
>> +
>> +	if (err)
>> +		return err;
>> +
>> +	genpd->state_count = i;
>> +	return 0;
>> +}
