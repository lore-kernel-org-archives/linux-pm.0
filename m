From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Fri, 6 May 2016 00:06:44 -0700
Message-ID: <CAJFUiJhryV7vHAofFSCc8iEL2FgYQ-qt8xzW3vPj9EQ3di-51g@mail.gmail.com>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com>
 <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com>
 <alpine.DEB.2.11.1604221834430.3941@nanos> <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com>
 <alpine.DEB.2.11.1604251018090.3941@nanos> <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com>
 <alpine.DEB.2.11.1604271216400.3941@nanos> <CAJFUiJir_zvQDXub=1zwPKJoZm_AnWNpGXuSUiCeHAEwEEUCMQ@mail.gmail.com>
 <alpine.DEB.2.11.1604280813570.3941@nanos> <CAJFUiJgUDSYE+6MG3riVyFjhhqckeY_3nEqer52tkUOy_yBeOw@mail.gmail.com>
 <alpine.DEB.2.11.1604290240560.3718@nanos> <CAJFUiJgSDwtpXWPcGu704=5tggOntmyfk=muOtDLRcSUJQc8Rg@mail.gmail.com>
 <alpine.DEB.2.11.1605021007310.3692@nanos> <CAJFUiJizA=ZxXh5BNj-eL6xsVrNEbTnd0Z5yePPDxAR8YjGibw@mail.gmail.com>
 <alpine.DEB.2.11.1605051404290.3540@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1605051404290.3540@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 5, 2016 at 5:13 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 4 May 2016, Lianwei Wang wrote:
>> In this example, the unbalanced count is caused by the
>> cpu_hotplug_pm_callback pm notifier callback function.
>
> I doubt that.
>
>> We can add a variable to avoid the unbalanced call of cpu_hotplug_enable
>> ,e.g.
>
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 3e3f6e49eabb..aa6694f0e9d3 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -1140,16 +1140,21 @@ static int
>>  cpu_hotplug_pm_callback(struct notifier_block *nb,
>>                         unsigned long action, void *ptr)
>>  {
>> +       static int disabled;
>> +
>>         switch (action) {
>>
>>         case PM_SUSPEND_PREPARE:
>>         case PM_HIBERNATION_PREPARE:
>>                 cpu_hotplug_disable();
>> +               disabled = 1;
>>                 break;
>>
>>         case PM_POST_SUSPEND:
>>         case PM_POST_HIBERNATION:
>> -               cpu_hotplug_enable();
>> +               if (disabled)
>> +                       cpu_hotplug_enable();
>> +               disabled = 0;
>>                 break;
>>
>>         default:
>>
>> Please let me know if you like to fix it in this way.
>
> So you are moving the work around one step down w/o providing any reasonable
> explanation how this asymetric call of that callback can happen.
>
> Can you eventually come up with a coherent explanation of the problem down to
> the root cause or are we going to play this "move the workaround one step
> down" game for another 10 rounds?
>
Do you agree that any driver can abort the suspend process by
returning an error or NOTIFY_BAD if it is not ready to suspend?
I have explain it and I also copied the example code that abort
suspend by returning an error or NOTIFY_BAD in the pm notifier
callback function.
The cpu_hotplug_disable and cpu_hotplug_enable are called in one of
the PM notifier callback. And they are called from two difference
place.
Below is how it happened:
  pm_suspend
    |--enter_state
        |--suspend_prepare
            |--pm_notifier_call_chain(PM_SUSPEND_PREPARE)
            |    |--call_back_1
            |    |--call_back_..
            |    |--call_back_n ===> return NOTIFY_BAD to abort call chain and
            |    |                                suspend process here
            |    |--cpu_hotplug_pm_callback()
            |    |   |--cpu_hotplug_disable  =====> remember it is not
called yet
            |    |--call_back_..
            |
            |--pm_notifier_call_chain(PM_POST_SUSPEND)
            |    |--call_back_1
            |    |--call_back_..
            |    |--call_back_n
            |    |--cpu_hotplug_pm_callback()
            |    |   |--cpu_hotplug_enable  =====> Here it is unbalanced called
            |    |--call_back_..
            |
So, keep in mind that for pm notifier call chain, the
PM_SUSPEND_PREPARE notifier and PM_POST_SUSPEND notifier is not always
paired called. Sometimes for a driver's pm notifier callback, the
PM_POST_SUSPEND is called without PM_SUSPEND_PREPARE.

>> +static void _cpu_hotplug_enable(void)
>> +{
>> +       if (WARN(!cpu_hotplug_disabled, "Unbalanced cpu hotplug enable\n"))
>> +               return;
>> +
>> +       cpu_hotplug_disabled--;
>> +}
>>
>> I like to fix it in the cpu_hotplug_enable because it is a public
>
> You CANNOT fix it there. The problem is the call site and NOT
> cpu_hotplug_enable(). Can you finally accept this?
I know what you mean. But why let the driver unconditionally do
"--cpu_hotplug_disabled" without any checking. It should do nothing if
it detect a unbalanced enable. A good example for unbalanced checking
from enable_irq is here:
http://lxr.free-electrons.com/source/kernel/irq/manage.c#L512

It's the cpu hotplug driver's responsibility to guarantee that the cpu
hotplug always working well even others failed do something to it. And
the driver can check and handle it itself, why not let the driver to
handle it and make the cpu hotplug driver more strong?
>
>> kernel API and fix in it can prevent any other unbalanced calling.
>
> It cannot prevent any unbalanced calls. It mitigates the issue, but that's a
> different problem.
It did not migrate the issue. It give a warning message to log the
unbalanced issue and it also make sure the cpu hotplug continue to
work well even someone do an unbalanced call. It is a good checking as
the enable_irq/disable_irq do. There are some other unbalanced
checking in kernel too. All make sure the kernel has a better
stability.
>
> We can discuss that seperately after fixing the offending call site.
>
> Thanks,
>
>         tglx
