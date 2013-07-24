From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/3 v6] cpufreq: Add debugfs directory for cpufreq
Date: Wed, 24 Jul 2013 15:14:12 +0900
Message-ID: <51EF70B4.2010806@samsung.com>
References: <1374146275-5758-1-git-send-email-cw00.choi@samsung.com>
 <1374146275-5758-2-git-send-email-cw00.choi@samsung.com>
 <CAKohpo=oTsEjzi_51UaZ8ww8UEfZ6hwKAnu9rFgGBkt=TfHi8A@mail.gmail.com>
 <51EF2D06.7000704@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <51EF2D06.7000704@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

>>> +       if (!policy->cpu_debugfs[idx]) {
>>> +               pr_err("creating debugfs directory failed\n");
>>> +               return -ENODEV;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int cpufreq_create_debugfs_symlink(struct cpufreq_policy *policy,
>>> +                                          unsigned int src_cpu,
>>> +                                          unsigned int dest_cpu)
>>
>> Only use policy and cpu for which symlink has to be created as param
>> to this routine. And create link to policy->cpu.
>>
> 
> OK, I'll simplify function prototype(cpufreq_create_debugfs_symlink) by removing
> unnecessary parameter.
> 

I considered the parameter type of cpufreq_create_debugfs_symlink() and then
I need following function declaration because this function didn't always need to
create symbolic link to policy->cpu. This function declaration is capable of creating
symbolic link as 'dest_cpu -> src_cpu'

	+static int cpufreq_create_debugfs_symlink(unsigned int src_cpu,
	+                                          unsigned int dest_cpu)

Thanks,
Chanwoo Choi


