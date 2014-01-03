From: Jane Li <jiel@marvell.com>
Subject: Re: [PATCH v3] cpufreq: Fix timer/workqueue corruption by protecting
 reading governor_enabled
Date: Fri, 3 Jan 2014 17:19:19 +0800
Message-ID: <52C68097.7070508@marvell.com>
References: <1388731451-10963-1-git-send-email-jiel@marvell.com> <CAKohpomWCpxCSFfG601Pc_FKcbZ3J7G2nsBABMb8qqQJ38h1cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpomWCpxCSFfG601Pc_FKcbZ3J7G2nsBABMb8qqQJ38h1cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On 01/03/2014 02:50 PM, Viresh Kumar wrote:
> On 3 January 2014 12:14,  <jiel@marvell.com> wrote:
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index dc196bb..15c62df 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -389,6 +389,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>>                                     unsigned int relation);
>>   int cpufreq_register_governor(struct cpufreq_governor *governor);
>>   void cpufreq_unregister_governor(struct cpufreq_governor *governor);
>> +extern struct mutex cpufreq_governor_lock;
>>
>>   /* CPUFREQ DEFAULT GOVERNOR */
>>   /*
> Move this to cpufreq_governor.h instead. I don't want this to be available
> for everybody to use it.

OK. Have pushed PATCH v4. Please review again.

Thanks!
