From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/3 v6] cpufreq: Add debugfs directory for cpufreq
Date: Wed, 24 Jul 2013 17:46:22 +0900
Message-ID: <51EF945E.3080802@samsung.com>
References: <1374146275-5758-1-git-send-email-cw00.choi@samsung.com>
 <1374146275-5758-2-git-send-email-cw00.choi@samsung.com>
 <CAKohpo=oTsEjzi_51UaZ8ww8UEfZ6hwKAnu9rFgGBkt=TfHi8A@mail.gmail.com>
 <51EF2D06.7000704@samsung.com>
 <CAKohpok7B6DaqFPWZcODEgK5GRSoAQYZ27-h2=AQ1HBBP4gH8Q@mail.gmail.com>
 <51EF8590.7030405@samsung.com>
 <CAKohpom19C7JHSX6w31pSDrwcAR_PZn1HzP0Jui5iZL=bALDPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpom19C7JHSX6w31pSDrwcAR_PZn1HzP0Jui5iZL=bALDPQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 07/24/2013 05:07 PM, Viresh Kumar wrote:
> I just realized I missed answering few questions:
> 
> On 24 July 2013 13:13, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> On 07/24/2013 02:05 PM, Viresh Kumar wrote:
>>> On 24 July 2013 06:55, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>> On 07/22/2013 07:11 PM, Viresh Kumar wrote:
>>>>> On 18 July 2013 16:47, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> 
>>>>>> +static void cpufreq_move_debugfs_dir(struct cpufreq_policy *policy,
>>>>>> +                                    unsigned int new_cpu)
>>>>>> +{
>>>>>> +       struct dentry *old_entry, *new_entry;
>>>>>> +       char new_dir_name[CPUFREQ_NAME_LEN];
>>>>>> +       unsigned int j, old_cpu = policy->cpu;
>>>>>> +
>>>>>> +       if (!policy->cpu_debugfs[new_cpu])
>>>>>> +               return;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * Remove symbolic link of debugfs directory except for debugfs
>>>>>> +        * directory of old_cpu.
>>>>>> +        */
>>>>>> +       for_each_present_cpu(j) {
>>>>>> +               if (old_cpu == j)
>>>>>> +                       continue;
>>>>>> +
>>>>>> +               debugfs_remove(policy->cpu_debugfs[j]);
>>>>>
>>>>> Why you need this? We aren't removing the earlier dentry at all here.
>>>
>>> haven't answered this.
>>
>> The debugfs entry of 'old_cpu' include child debugfs file(e.g., load_table)
>> If cpu is last user of policy and core call __cpufre_remove_dev() to remove last cpu,
>> core call cpufreq_move_debugfs_dir(). I have to move the data of debugfs directory/file and
>> child data for 'old_cpu' to debugfs directory for 'new_cpu'.
>>
>> If I remove earlier dentry of 'old_cpu', I can't get the child debugfs dir/file.
>> So I didn't remove the earlier dentry of 'old_cpu'.
> 
> Okay.. The original question was: why do you need to remove & add
> entries or links for cpus other than policy->cpu? Because we are renaming
> the entry, wouldn't that work straight away?
> 

In case that all CPUs share same cpufreq policy. Each debugfs dentry of CPU[1-3]
except for CPU0 has symbolic link to CPU0's debugfs directory as following.

-sh-4.1# ls -al /sys/kernel/debug/cpufreq/
total 0
drwxr-xr-x  3 root root 0 Jan  1 09:00 .
drwx------ 28 root root 0 Jan  1 09:00 ..
drwxr-xr-x  2 root root 0 Jan  1 09:00 cpu0		(policy->cpu is 0)
lrwxrwxrwx  1 root root 0 Jan  1 09:00 cpu1 -> ./cpu0
lrwxrwxrwx  1 root root 0 Jan  1 09:00 cpu2 -> ./cpu0
lrwxrwxrwx  1 root root 0 Jan  1 09:00 cpu3 -> ./cpu0

If turn off CPU0 state, I have to move debugfs directory data from cpu0 to cpu1
and again create link to cpu1's debugfs directory for CPU[2-3] debugfs directory.
So, I removed dentry link of CPU[1-3] before creating link again. 

cpu1
cpu2 -> ./cpu1
cpu3 -> ./cpu1

But I can rewrite new link of CPU[2-3] to previous dentry link(policy->cpu_debugfs[2] or policy->cpu_debugfs[3])
for reducing unnecessary code without revmoval sequence.



