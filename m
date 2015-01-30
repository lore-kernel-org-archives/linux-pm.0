From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Set cpufreq_cpu_data to NULL before putting kobject
Date: Fri, 30 Jan 2015 07:35:27 +0530
Message-ID: <CAKohpo=uFZ0BwZ1FLSBpht3Yi1B73LpHDu00Rqk2P3TbzCYsoQ@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422580135.git.viresh.kumar@linaro.org>
	<54CADEAE.2090305@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <54CADEAE.2090305@oracle.com>
Sender: stable-owner@vger.kernel.org
To: ethan zhao <ethan.zhao@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "# 3.13.x" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30 January 2015 at 07:00, ethan zhao <ethan.zhao@oracle.com> wrote:

>  It is another bug.

Hmm, lets see..

>  Yes, here is one bug should be fix. but seems not enough to avoid the issue
> completely,

Did you test it ?

>  how about the Thread B running here
>
>  Thread B: xenbus_thread()
>
>  xenbus_thread()
>    msg->u.watch.handle->callback()
>      handle_vcpu_hotplug_event()
>        vcpu_hotplug()
>          cpu_down()
>            __cpu_notify(CPU_POST_DEAD..)
>              cpufreq_cpu_callback()
>                __cpufreq_remove_dev_prepare
>                  update_policy_cpu(){
>                    ...
>                    down_write(&policy->rwsem);
>                    policy->last_cpu = policy->cpu;
>                    policy->cpu = cpu;
>                    up_write(&policy->rwsem);
>                    ---->
>                 }
>
> And thread A run to the same position as above, don't ignore my work
> blindly, that piece of bandage
> could save your time

Oh, please don't misunderstand me. I didn't had any intention of showing
any kind of disrespect.

Okay, why do you say that the above thread you shown has a bug in there?
Its juse updating policy->cpu and that shouldn't make anything unstable.

Please explain again one more time, in details why do you think you hit a
different bug. Also look at kref.h to see which piece of code has hit that
WARN() and it will happen only in the case I have shown. Lets see if I
missed something :)

--
viresh
