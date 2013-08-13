From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH] cpufreq: add frequency table to at32ap driver
Date: Tue, 13 Aug 2013 11:06:13 +0200
Message-ID: <20130813090613.GA1850@samfundet.no>
References: <1376334657-23578-1-git-send-email-egtvedt@samfundet.no>
 <CAKohpokCsCLS=8FNZpUBgEVi7YropyR4UoLC9XNN+rs5xuigMw@mail.gmail.com>
 <CAKohponh4tW8j3qk7eP9YnfXufutNkK-+iCQRvqSUC2=GwvqeA@mail.gmail.com>
 <20130813065208.GB7055@samfundet.no>
 <CAKohponXSvxQwyx7YJYbcQHD8X2F=EuFpFd31DR5HY3JjvS+rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohponXSvxQwyx7YJYbcQHD8X2F=EuFpFd31DR5HY3JjvS+rQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

Around Tue 13 Aug 2013 12:28:04 +0530 or thereabout, Viresh Kumar wrote:
> On 13 August 2013 12:22, Hans-Christian Egtvedt <egtvedt@samfundet.no> wrote:
>> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>>
>> Thanks for cleaning up (-:
> 
> No problem..
> 
> Actually there is more to it.. We have got a freq table but neither .verify()
> nor .target() uses it :) and so we need to fix those two also to fix it up..
> 
> .verify() looks to be pretty straight forward and so can be replaced by
> the generic routine I wrote for that..

I though you already had a patch to swap verify, hence the need to cleanup
the cpufreq driver first to provide a frequency table?

> But .target() does some calculations which aren't very straight forward
> to replace..
> 
> I believe I can remove all below code and simply get the frequency
> as suggested by cpufreq-core ??
> 
> 	/* Convert target_freq from kHz to Hz */
> 	freq = clk_round_rate(cpuclk, target_freq * 1000);
> 
> 	/* Check if policy->min <= new_freq <= policy->max */
> 	if(freq < (policy->min * 1000) || freq > (policy->max * 1000))
> 		return -EINVAL;

This sanity checks that the frequency the system clock can generate is within
the policy limits. It is initially feed the target_freq frequency.

These values are already calculated during init and added to the table, so
one shouldn't need to perform the clk_round_rate() call anymore.

> 	pr_debug("cpufreq: requested frequency %u Hz\n", target_freq * 1000);
> 
> 	freqs.new = (freq + 500) / 1000;
> 	freqs.flags = 0;

I don't know the details of how the cpufreq-core suggests frequencies. If it
looks up in the frequency table, then we don't need this sanity check in
.target().

-- 
mvh
Hans-Christian Egtvedt
