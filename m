From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: add frequency table to at32ap driver
Date: Tue, 13 Aug 2013 14:39:45 +0530
Message-ID: <CAKohpokqMt2L_r3WR=vTPyW0kUS5wZ8FxS3ii=B=H=Yizuu=ig@mail.gmail.com>
References: <1376334657-23578-1-git-send-email-egtvedt@samfundet.no>
	<CAKohpokCsCLS=8FNZpUBgEVi7YropyR4UoLC9XNN+rs5xuigMw@mail.gmail.com>
	<CAKohponh4tW8j3qk7eP9YnfXufutNkK-+iCQRvqSUC2=GwvqeA@mail.gmail.com>
	<20130813065208.GB7055@samfundet.no>
	<CAKohponXSvxQwyx7YJYbcQHD8X2F=EuFpFd31DR5HY3JjvS+rQ@mail.gmail.com>
	<20130813090613.GA1850@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:60607 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab3HMJJp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2013 05:09:45 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so9959872obc.24
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2013 02:09:45 -0700 (PDT)
In-Reply-To: <20130813090613.GA1850@samfundet.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On 13 August 2013 14:36, Hans-Christian Egtvedt <egtvedt@samfundet.no> wrote:
> Around Tue 13 Aug 2013 12:28:04 +0530 or thereabout, Viresh Kumar wrote:

>> .verify() looks to be pretty straight forward and so can be replaced by
>> the generic routine I wrote for that..
>
> I though you already had a patch to swap verify, hence the need to cleanup
> the cpufreq driver first to provide a frequency table?

Yes, that's what.. That generic routine can be used instead of your .verify()..

>> But .target() does some calculations which aren't very straight forward
>> to replace..
>>
>> I believe I can remove all below code and simply get the frequency
>> as suggested by cpufreq-core ??
>>
>>       /* Convert target_freq from kHz to Hz */
>>       freq = clk_round_rate(cpuclk, target_freq * 1000);
>>
>>       /* Check if policy->min <= new_freq <= policy->max */
>>       if(freq < (policy->min * 1000) || freq > (policy->max * 1000))
>>               return -EINVAL;
>
> This sanity checks that the frequency the system clock can generate is within
> the policy limits. It is initially feed the target_freq frequency.

This is already done in core.

> These values are already calculated during init and added to the table, so
> one shouldn't need to perform the clk_round_rate() call anymore.

good.

>>       pr_debug("cpufreq: requested frequency %u Hz\n", target_freq * 1000);
>>
>>       freqs.new = (freq + 500) / 1000;
>>       freqs.flags = 0;
>
> I don't know the details of how the cpufreq-core suggests frequencies. If it
> looks up in the frequency table, then we don't need this sanity check in
> .target().

Yes, it just picks the best match from freq table, though here is the actual
implementation..

https://lkml.org/lkml/2013/8/12/404
