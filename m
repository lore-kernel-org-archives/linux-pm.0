From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Cpufreq userspace governor start/stop issue
Date: Wed, 5 Jun 2013 18:34:53 +0530
Message-ID: <CAKohpok=tUf=9peEkriM9Ow8J2NfZxDBuaFQhW+uyfeEVYiRjw@mail.gmail.com>
References: <CAFgnuDd_6z+g2m8QAfZBaCnwUYUPWB6Dku_3KvmTJ4mOrcOa6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAFgnuDd_6z+g2m8QAfZBaCnwUYUPWB6Dku_3KvmTJ4mOrcOa6Q@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg.marvell@gmail.com>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 5 June 2013 08:54, Xiaoguang Chen <chenxg.marvell@gmail.com> wrote:

Though I have tried to simplify userspace governor at the best,
but I think I didn't understood one thing here.

> So consider below case:
> 1) cpu0 tries to hotplug cpu3, it calls userspace governor stop
> function, it should stop cpu3's userspace governor, but it actually
> set cpu0's per_cpu(cpu_is_managed, cpu) to 0.
> 2) cpu0 tries to change cpu freuqency through userspace governor, but
> it will never succeed since cpufreq_set will return err if cpu0'
> percpu variable cpu_is_managed is 0.

This is how it works currently in latest code:
-> hot-unplug cpu3
  -> STOP governor for its policy with policy->cpus set to 0,1,2,3
     -> set managed for policy->cpu (i.e. cpu0) to 0.
  -> START governor for 0,1,2
     -> set managed for policy->cpu (i.e. cpu0) to 1.

And so we are in workable situation again and their is no problem
at all.
