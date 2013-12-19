From: Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH] cpufreq: Apply default governor for setpolicy drivers
Date: Wed, 18 Dec 2013 22:51:26 -0500
Message-ID: <52B26D3E.2070600@akamai.com>
References: <20131218203102.9F9692036@prod-mail-relay06.akamai.com> <1451068.r0h0sa1DaG@vostro.rjw.lan> <52B21508.3000303@akamai.com> <2651749.Dr3egRT25J@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from prod-mail-xrelay07.akamai.com ([72.246.2.115]:34538 "EHLO
	prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752467Ab3LSDv1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 22:51:27 -0500
In-Reply-To: <2651749.Dr3egRT25J@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>

On 12/18/2013 06:33 PM, Rafael J. Wysocki wrote:
> On Wednesday, December 18, 2013 04:35:04 PM Jason Baron wrote:
>> On 12/18/2013 04:38 PM, Rafael J. Wysocki wrote:
>>> On Wednesday, December 18, 2013 08:31:02 PM Jason Baron wrote:
>>>> When configuring a default governor (via CONFIG_CPU_FREQ_DEFAULT_*) with the
>>>> 'intel_pstate' driver, I found that the default is not honored. For example,
>>>> configure 'CONFIG_CPU_FREQ_GOV_PERFORMANCE', and then do:
>>> intel_pstate doesn't use any cpufreq governors, so all of this is pointless
>>> for that particular driver anyway.
>>>
>>> Thanks!
>>>
>> Ok, but if I look at 'intel_pstate', I see a 'set_policy' call that does different
>> things if the policy is 'performance' vs. 'powersave'. Same for the 'longrun'
>> driver. So yes, they don't use the 'governors', but changing the governors
>> at runtime does appear to change change how they behave.
> OK, so you want the initial policy to be set in accordance with the
> CONFIG_CPU_FREQ_DEFAULT_* setting.  That makes sense, although it is not
> immediately clear from the patch changelog.
>
> That said the change in the patch looks kind of overly complicated.
> What about adding something like this instead?

Agreed - this is better. Will you just pull the below patch, or should
I re-post with a better changelog?

Thanks,

-Jason

> +       if (cpufreq_driver->setpolicy) {
> +               unsigned int ret;
> +
> +       	/* Use the default policyt if it is valid. */
> +               if (!cpufreq_parse_governor(policy->governor->name, &ret, NULL))
> +                       new_policy.policy = ret;
> +       }
>
> Rafael
>

