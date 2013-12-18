From: Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH] cpufreq: Apply default governor for setpolicy drivers
Date: Wed, 18 Dec 2013 16:35:04 -0500
Message-ID: <52B21508.3000303@akamai.com>
References: <20131218203102.9F9692036@prod-mail-relay06.akamai.com> <1451068.r0h0sa1DaG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from prod-mail-xrelay07.akamai.com ([72.246.2.115]:40218 "EHLO
	prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754485Ab3LRVfG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 16:35:06 -0500
In-Reply-To: <1451068.r0h0sa1DaG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>

On 12/18/2013 04:38 PM, Rafael J. Wysocki wrote:
> On Wednesday, December 18, 2013 08:31:02 PM Jason Baron wrote:
>> When configuring a default governor (via CONFIG_CPU_FREQ_DEFAULT_*) with the
>> 'intel_pstate' driver, I found that the default is not honored. For example,
>> configure 'CONFIG_CPU_FREQ_GOV_PERFORMANCE', and then do:
> intel_pstate doesn't use any cpufreq governors, so all of this is pointless
> for that particular driver anyway.
>
> Thanks!
>

Ok, but if I look at 'intel_pstate', I see a 'set_policy' call that does different
things if the policy is 'performance' vs. 'powersave'. Same for the 'longrun'
driver. So yes, they don't use the 'governors', but changing the governors
at runtime does appear to change change how they behave. What am
I missing?

Thanks,

-Jason
