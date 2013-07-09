From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 0/6] cpufreq: Add 'load_table' debugfs file to show
 colleced CPUs load
Date: Tue, 09 Jul 2013 16:57:03 +0900
Message-ID: <51DBC24F.5040202@samsung.com>
References: <1373014001-17746-1-git-send-email-cw00.choi@samsung.com>
 <CAKohpokzn4jrO3rr8pjzwd4Xn+0umOK-sMANV2Fj5xn6UhBHVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpokzn4jrO3rr8pjzwd4Xn+0umOK-sMANV2Fj5xn6UhBHVg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com
List-Id: linux-pm@vger.kernel.org

On 07/09/2013 03:50 PM, Viresh Kumar wrote:
> On 5 July 2013 14:16, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> Second, previous performance/powersave governor haven't calculated CPUs load
>> becuase these governor didn't change CPU frequency according to CPUs load. But,
>> load_table debugfs file always should indicate the collected CPUs data regardless
>> of the kind of cpufreq governor. So, the patch3/4/5 implement that performance/
>> powersave governor will check periodically CPUs load by calling dbs_check_cpu()
>> with timer.
> 
> I raised a query on how can we call dbs_check_cpu() from
> performance/powersave? Also, calling this routine will degrade
> performance without any sense. So, I vote not for doing it.

You're right. The performance/powersave don't usually need calling operation
of dbs_check_cpu(). Only, this patch aims at checking CPUs load on
load_table debugfs file.

I'm going to consider more efficient way than this patchset.
For example, 

But, following patctes haven't the dependency about upper description about performance/powersave.
If user changes cpufreq governor from ondemand/conservative to performance/powersave,
patch2 did reset all of the data for load_table.

  cpufreq: Add debugfs directory for cpufreq
  cpufreq: stats: Add 'load_table' debugfs file to show accumulated data of CPUs
  Documentation: cpufreq: load_table: Update load_table debugfs file documentation

So, I'd like you to review patch1,patch2, patch6. If you with that I resend patch1/2/6,
I will resend new patchset incluing in patch1/2/6.

Thanks,

Best Regards,
Chanwoo Choi

