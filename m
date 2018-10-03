From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH RFC] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
Date: Wed, 3 Oct 2018 12:25:20 +0200
Message-ID: <ab561a7d-9425-7b04-8d11-ed3e85afe971@linaro.org>
References: <1537868328-13405-1-git-send-email-daniel.lezcano@linaro.org>
 <4200780.ZjVhNjpZ67@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4200780.ZjVhNjpZ67@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: linux-pm@vger.kernel.org, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Colin Cross <ccross@android.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 03/10/2018 10:58, Rafael J. Wysocki wrote:
> On Tuesday, September 25, 2018 11:38:44 AM CEST Daniel Lezcano wrote:
>> The function get_loadavg() returns almost always zero. To be more
>> precise, statistically speaking for a total of 1023379 times passing
>> to the function, the load is equal to zero 1020728 times, greater than
>> 100, 610 times, the remaining is between 0 and 5.
>>
>> I'm putting in question this metric. Is it worth to keep it?
> 
> The honest answer is that I'm not sure.
> 
> Using the CPU load for driving idle state selection is questionable in general
> (there need not be any connection between the two in principle) and this
> particular function is questionable either.  If it really makes no difference
> in addition to that, then yes it would be good to get rid of it.
> 
> That said it looks like that may be quite workload-dependent, so maybe there
> are workloads where it does make a difference?  Like networking or similar?

Perhaps initially the load was not the same:


commit 69d25870f20c4b2563304f2b79c5300dd60a067e
Author: Arjan van de Ven <arjan@infradead.org>
Date:   Mon Sep 21 17:04:08 2009 -0700

    cpuidle: fix the menu governor to boost IO performance


The function get_loadavg() was:

static int get_loadavg(void)
{
       unsigned long this = this_cpu_load();

       return LOAD_INT(this) * 10 + LOAD_FRAC(this) / 10;
}

With:

unsigned long this_cpu_load(void)
{
        struct rq *this = this_rq();
        return this->cpu_load[0];
}


Now we pass the load we got from get_iowait_load() which is:

void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
{
        struct rq *rq = this_rq();
        *nr_waiters = atomic_read(&rq->nr_iowait);
        *load = rq->load.weight;
}

Colin Cross did some measurements a few years ago and concluded it is
zero most of the time, otherwise the number is so high it has no
meaning. The get_loadavg() call is removed from Android since 2011 [1].

I can hack my server (bi Xeon - 6 cores), add statistics regarding this
metric and let it run during several days, sure a lot of different
workloads will happen on it (compilation, network, throughput computing,
...) in a real use case manner. That is what I did with an ARM64
evaluation board.

However I won't be able to do that right now and that will take a bit of
time. If you think it is really useful, I can plan to do that in the
next weeks.

 -- Daniel

[1]
https://android.googlesource.com/kernel/common/+/4dedd9f124703207895777ac6e91dacde0f7cc17



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
