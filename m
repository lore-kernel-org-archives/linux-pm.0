From: John Blackwood <john.blackwood@ccur.com>
Subject: Re: [PATCH] cpufreq_conservative: initialize the cpu_dbs_info_s cpu
 field
Date: Tue, 23 Apr 2013 10:27:22 -0500
Message-ID: <5176A85A.7090609@ccur.com>
References: <51769DB3.7030404@ccur.com> <CAOh2x=nZir=RohrbVJa1iWR47nmLKfG3it1UnWdt49oAKrBhWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOh2x=nZir=RohrbVJa1iWR47nmLKfG3it1UnWdt49oAKrBhWw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04/23/2013 10:19 AM, Viresh Kumar wrote:
> On Tue, Apr 23, 2013 at 8:11 PM, John Blackwood <john.blackwood@ccur.com> wrote:
>> In the cpufreq conservative module, the cpu field in the cpu_dbs_info_s
>> structure was not being initialized, and thus all cpus were scheduling
>> their do_dbs_timer() delayed work processing on cpu 0.
>>
>> Signed-off-by: John Blackwood <john.blackwood@ccur.com>
>> Index: b/drivers/cpufreq/cpufreq_conservative.c
>> ===================================================================
>> --- a/drivers/cpufreq/cpufreq_conservative.c
>> +++ b/drivers/cpufreq/cpufreq_conservative.c
>> @@ -506,6 +506,7 @@ static int cpufreq_governor_dbs(struct c
>>                  }
>>                  this_dbs_info->down_skip = 0;
>>                  this_dbs_info->requested_freq = policy->cur;
>> +               this_dbs_info->cpu = cpu;
>>
>>                  mutex_init(&this_dbs_info->timer_mutex);
>>                  dbs_enable++;
>
> What have you rebased this on? I don't think its the latest code and is probably
> a bit old.
>

Hi Viresh,

Yes, you are right.
This has been fixed in a different way in the newer kernel source.
My apologies.

