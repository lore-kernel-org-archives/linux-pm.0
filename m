From: ethan zhao <ethan.zhao@oracle.com>
Subject: Re: [PATCH Resend] cpufreq: Set cpufreq_cpu_data to NULL before putting
 kobject
Date: Mon, 02 Feb 2015 11:56:36 +0800
Message-ID: <54CEF574.6040404@oracle.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422663249.git.viresh.kumar@linaro.org> <54CEECF7.7020504@oracle.com> <CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com> <54CEF123.5050106@oracle.com> <CAKohponOvEnG2Tt5sFPLAHA_bHckHboR7t35-7ey5b_cCKfvKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51693 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbbBBD44 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Feb 2015 22:56:56 -0500
In-Reply-To: <CAKohponOvEnG2Tt5sFPLAHA_bHckHboR7t35-7ey5b_cCKfvKg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>


On 2015/2/2 11:43, Viresh Kumar wrote:
> On 2 February 2015 at 09:08, ethan zhao <ethan.zhao@oracle.com> wrote:
>>> We take cpufreq_driver_lock() here, and so this will
>>> block thread B.
>>   No, there is no  cpufreq_driver_lock acquired between
>>
>>   cpufreq_cpu_get()  and cpufreq_cpu_put()
> I am not saying that the lock is taken between them. But within
> cpufreq_cpu_get() to make sure policy doesn't get freed while we
> are doing kobject_get().
  How to prevent the policy to be freed between

cpufreq_cpu_get()  and cpufreq_cpu_put() ?

>>>>              beginning the deference of policy        Thread B:
>>>>              ... ... __cpufreq_remove_dev_finish()
>>>> cpufreq_policy_free(policy);
>>>>
>>>>
>>>> Perhaps move policy->rwsem out side the policy structure is a way to
>>>> avoid
>>>> it completely.
>>>> and you could stopping the PPC thread stepping forward as my patch as
>>>> temporary workaround.
>>> I couldn't understand your problem completely. Apart from giving a
>>> detailed
>>> look of what's going on both threads, always specify where the BUG
>>> actually
>>> is..
>> The problem is you are using a rwsem inside policy structure to protect its
>> assessment, that is bad design.
> What is the current bug you are facing right now, I haven't understood it well.
> Also a lock within the structure isn't new. Its all over the kernel. I
> don't understand
> why you say its a bad design.
You are maxing up the water with sand ?

Thanks,
Ethan

>
> --
> viresh

