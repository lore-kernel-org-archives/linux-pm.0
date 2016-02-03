From: Mason <slash.tmp@free.fr>
Subject: Re: Plain DFS (no voltage scaling)
Date: Wed, 3 Feb 2016 16:35:10 +0100
Message-ID: <56B21E2E.1070606@free.fr>
References: <56B11B67.3090600@free.fr> <20160203021052.GK31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:58147 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892AbcBCPfQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Feb 2016 10:35:16 -0500
In-Reply-To: <20160203021052.GK31828@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 03/02/2016 03:10, Viresh Kumar wrote:
> On 02-02-16, 22:11, Mason wrote:
>> Hello,
>>
>> I plan to enable the on-demand governor on the tango platform:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/tango4-smp8758.dtsi
>>
>> I found the cpufreq-dt binding doc:
>>
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/opp/opp.txt
>>
>> Something is not clear to me:
>>
>> If my platform cannot scale the voltage, what information
>> should I put in the voltage part of the DT?
> 
> Wouldn't matter if there is no regulator. i.e. you should keep 0, but
> even if they have something non-zero, core code will ignore it. But
> yeah, it makes sense to keep it zero.

Hmmm, I am missing something obvious.

My config contains:

CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPUFREQ_DT=y

Yet, neither dt_cpufreq_probe() nor cpufreq_init() are being called.

Could someone please point to my mistake?

Regards.

