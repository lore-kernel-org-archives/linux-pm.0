From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Mon, 06 Oct 2014 08:41:20 +0200
Message-ID: <54323990.6000401@i2se.com>
References: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de>	<1412258352.4875.5.camel@pengutronix.de>	<878902771.162556.1412262099998.JavaMail.open-xchange@oxbaltgw01.schlund.de>	<1412263338.2313.1.camel@pengutronix.de> <CAKohpom_kJadzUiPAT9GBJjvcu=38L9fO1atoi24xGwrq9XDFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:52656 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbaJFGlZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 02:41:25 -0400
In-Reply-To: <CAKohpom_kJadzUiPAT9GBJjvcu=38L9fO1atoi24xGwrq9XDFg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Am 06.10.2014 um 06:21 schrieb Viresh Kumar:
> On 2 October 2014 20:52, Lucas Stach <l.stach@pengutronix.de> wrote:
>> It's harmless in your case. But to get rid of it you might try the
>> attached patch which may be an acceptable solution.
>>
>> ------------------------------>8-----------------------------------
>> From db9e708edf6451b619ee73f68c3fcde2eccd7b0c Mon Sep 17 00:00:00 2001
>> From: Lucas Stach <l.stach@pengutronix.de>
>> Date: Thu, 2 Oct 2014 17:20:09 +0200
>> Subject: [PATCH] cpufreq: generic: try preserve some accuracy while
>> converting
>>  from Hz to kHz
>>
>> ---
>>  drivers/cpufreq/cpufreq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index d9fdeddcef96..459830c6576f 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -187,7 +187,7 @@ unsigned int cpufreq_generic_get(unsigned int cpu)
>>                 return 0;
>>         }
>>
>> -       return clk_get_rate(policy->clk) / 1000;
>> +       return DIV_ROUND_CLOSEST(clk_get_rate(policy->clk), 1000);
>>  }
>>  EXPORT_SYMBOL_GPL(cpufreq_generic_get);
> Absolutely NOT..
>
> This can't be an acceptable solution to the problem you have in your DT.
> This routine is used for getting the current frequency of a CPU and we
> can't play with that..

I thought about it and agree with you.

> The problem that Stefan is getting is: The boot loader has programmed
> cpu to a frequency which isn't present in your DT table. And so kernel
> tries to adjust CPU frequency to one of the listed frequencies.

Here comes the real problem, i'm not able to specify the exact frequency
of the cpu. The clock has a value in Hz, but in the DT we have kHz. So
there are always rounding issues. The question is how to handle it.

> Solutions:
> - Add another entry to your DT table to reflect the currently programmed
> frequency.
> - Just ignore the error, as that is just for information.

Ignoring errors isn't a solution. I have another idea. I've looked a
little bit at the code in the cpufreq-(cpu0/dt). Usually the frequencies
are rounded down, but in cpu0_set_target() with
dev_pm_opp_find_freq_ceil(cpu_dev, &freq_Hz) they are rounded up. From
my point of view that's wrong.

I fixed the problem by decreasing frequency in DT and replacing
dev_pm_opp_find_freq_ceil() with dev_pm_opp_find_freq_floor() in
cpufreq-cpu0.c . Unfortunatelly this will break all other DTS files with
roundings in OPPs.

Stefan
