From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Set cpufreq_cpu_data to NULL before putting kobject
Date: Fri, 30 Jan 2015 07:43:14 +0530
Message-ID: <CAKohponF_fqoDj_g4kZuoYa=gz9G_yRn67eJoWT6mnPkejWkjw@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422580135.git.viresh.kumar@linaro.org>
	<54CADEAE.2090305@oracle.com>
	<CAKohpo=uFZ0BwZ1FLSBpht3Yi1B73LpHDu00Rqk2P3TbzCYsoQ@mail.gmail.com>
	<54CAE80C.4060406@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <54CAE80C.4060406@oracle.com>
Sender: stable-owner@vger.kernel.org
To: ethan zhao <ethan.zhao@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "# 3.13.x" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30 January 2015 at 07:40, ethan zhao <ethan.zhao@oracle.com> wrote:
> For a PPC notification and xen-bus thread race, could you tell me a way how
> to reproduce it by trigger the PPC notification and xen-bus events manually
> ?
> You really want me write some code into a test kernel to flood the PPC and
> xen-bus at the same time ? if we could analysis code and get the issue
> clearly, we wouldn't wait the users to yell out.

I thought you already have a test where you are hitting the issue you originally
reported. Atleast Santosh did confirm that he is hitting 3/5 times in his kernel
during boot..

My reasoning of why your observation doesn't fit here:

Copying from your earlier mail..

 Thread A: Workqueue: kacpi_notify

 acpi_processor_notify()
   acpi_processor_ppc_has_changed()
         cpufreq_update_policy()
           cpufreq_cpu_get()
             kobject_get()

This tries to increment the count and the warning you have mentioned
happen because:

WARN_ON_ONCE(atomic_inc_return(&kref->refcount) < 2);

i.e. even after incrementing the count, it is < 2. Which I believe will be
1. Which means that we have tried to do kobject_get() on a kobject
for which kobject_put() is already done.

 Thread B: xenbus_thread()

 xenbus_thread()
   msg->u.watch.handle->callback()
     handle_vcpu_hotplug_event()
       vcpu_hotplug()
         cpu_down()
           __cpu_notify(CPU_DOWN_PREPARE..)
             cpufreq_cpu_callback()
               __cpufreq_remove_dev_prepare()
                 update_policy_cpu()
                   kobject_move()


Okay, where is the race or kobject_put() here ? We are just moving
the kobject and it has nothing to do with the refcount of kobject.

Why do you see its a race ?
