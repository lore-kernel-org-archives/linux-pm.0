From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend] cpufreq: Set cpufreq_cpu_data to NULL before
 putting kobject
Date: Mon, 2 Feb 2015 10:24:05 +0530
Message-ID: <CAKohpomYpEAeQeaB7HVT0cBT5H_P8QQ-e+FQ5OqUoOvfz2ZnOQ@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422663249.git.viresh.kumar@linaro.org>
	<54CEECF7.7020504@oracle.com>
	<CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com>
	<54CEF123.5050106@oracle.com>
	<CAKohponOvEnG2Tt5sFPLAHA_bHckHboR7t35-7ey5b_cCKfvKg@mail.gmail.com>
	<54CEF574.6040404@oracle.com>
	<CAKohpom589bFL4-eyR1=qrc6uoRtjck_z_SBHS3XU8dJSc4yFg@mail.gmail.com>
	<54CEF7AA.80401@oracle.com>
	<CAKohponfkJVYFTsj6ijy0iY3t-R=zN=M0ZkoDmYa-WYTzPuvmw@mail.gmail.com>
	<54CEFA23.7040705@oracle.com>
	<CAKohpomBcBVXLW-RW1VXAtkTw-BKd7tHmeFJgmf9CM3vi1Ki-Q@mail.gmail.com>
	<54CF0106.5050601@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:51970 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbbBBEyF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Feb 2015 23:54:05 -0500
Received: by mail-ob0-f169.google.com with SMTP id wp4so734532obc.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2015 20:54:05 -0800 (PST)
In-Reply-To: <54CF0106.5050601@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ethan zhao <ethan.zhao@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 2 February 2015 at 10:15, ethan zhao <ethan.zhao@oracle.com> wrote:
> On 2015/2/2 12:26, Viresh Kumar wrote:

>  But there is no checking against refcount in or before
>
>  cpufreq_policy_free(), that is one issue I mentioned.

As I said earlier, the completion will only fire once the refcount
is zero. And so there is no need of any check here.

>> That routines doesn't have any tricks and simply frees the policy.
>> Because, before calling cpufreq_policy_put_kobj(), we have set
>> the per-cpu variable to NULL, nobody else will get the policy
>
>  It is possible cpufreq_cpu_get() within the PPC thread was called just
>  before __cpufreq_remove_dev_finish() is to be called in another thread,
>  so you set the per_cpu(cpufreq_cpu_data, cpu) to NULL will not prevent
>  the actions between cpufreq_cpu_get and cpufreq_cpu_put().
>
>  And then the freeing happens in __cpufreq_remove_dev_finish().

It will.. You aren't looking closely enough. If cpufreq_cpu_get() is called just
before remove-dev, then cpufreq_cpu_get() will take:

read_lock_irqsave(&cpufreq_driver_lock, flags);

And it will do:

read_unlock_irqrestore(&cpufreq_driver_lock, flags);

only after increasing the refcount with kobject_get().

While on the other side __cpufreq_remove_dev_finish() will do this:

       write_lock_irqsave(&cpufreq_driver_lock, flags);
       policy = per_cpu(cpufreq_cpu_data, cpu);
       per_cpu(cpufreq_cpu_data, cpu) = NULL;
       write_unlock_irqrestore(&cpufreq_driver_lock, flags);

So, it will wait for the read_lock in cpufreq_cpu_get() to finish before
setting per-cpu variable to NULL. And so, after kobject_put() in
cpufreq_policy_put_kobj(), we will wait for the completion to fire
and that will only happen once a corresponding cpufreq_cpu_put()
is issued.
