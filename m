From: ethan zhao <ethan.zhao@oracle.com>
Subject: Re: [PATCH] cpufreq: Set cpufreq_cpu_data to NULL before putting
 kobject
Date: Fri, 30 Jan 2015 10:10:20 +0800
Message-ID: <54CAE80C.4060406@oracle.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422580135.git.viresh.kumar@linaro.org> <54CADEAE.2090305@oracle.com> <CAKohpo=uFZ0BwZ1FLSBpht3Yi1B73LpHDu00Rqk2P3TbzCYsoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:32959 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383AbbA3CKi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 21:10:38 -0500
In-Reply-To: <CAKohpo=uFZ0BwZ1FLSBpht3Yi1B73LpHDu00Rqk2P3TbzCYsoQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "# 3.13.x" <stable@vger.kernel.org>

Viresh,

On 2015/1/30 10:05, Viresh Kumar wrote:
> On 30 January 2015 at 07:00, ethan zhao <ethan.zhao@oracle.com> wrote:
>
>>   It is another bug.
> Hmm, lets see..
>
>>   Yes, here is one bug should be fix. but seems not enough to avoid the issue
>> completely,
> Did you test it ?
For a PPC notification and xen-bus thread race, could you tell me a way how
to reproduce it by trigger the PPC notification and xen-bus events 
manually ?
You really want me write some code into a test kernel to flood the PPC 
and xen-bus at the same time ? if we could analysis code and get the 
issue clearly,
we wouldn't wait the users to yell out.

Thanks,
Ethan

>
>>   how about the Thread B running here
>>
>>   Thread B: xenbus_thread()
>>
>>   xenbus_thread()
>>     msg->u.watch.handle->callback()
>>       handle_vcpu_hotplug_event()
>>         vcpu_hotplug()
>>           cpu_down()
>>             __cpu_notify(CPU_POST_DEAD..)
>>               cpufreq_cpu_callback()
>>                 __cpufreq_remove_dev_prepare
>>                   update_policy_cpu(){
>>                     ...
>>                     down_write(&policy->rwsem);
>>                     policy->last_cpu = policy->cpu;
>>                     policy->cpu = cpu;
>>                     up_write(&policy->rwsem);
>>                     ---->
>>                  }
>>
>> And thread A run to the same position as above, don't ignore my work
>> blindly, that piece of bandage
>> could save your time
> Oh, please don't misunderstand me. I didn't had any intention of showing
> any kind of disrespect.
>
> Okay, why do you say that the above thread you shown has a bug in there?
> Its juse updating policy->cpu and that shouldn't make anything unstable.
>
> Please explain again one more time, in details why do you think you hit a
> different bug. Also look at kref.h to see which piece of code has hit that
> WARN() and it will happen only in the case I have shown. Lets see if I
> missed something :)
>
> --
> viresh

