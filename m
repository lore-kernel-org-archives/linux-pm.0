From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Wed, 4 May 2016 00:23:52 -0700
Message-ID: <CAJFUiJizA=ZxXh5BNj-eL6xsVrNEbTnd0Z5yePPDxAR8YjGibw@mail.gmail.com>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com>
 <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com>
 <alpine.DEB.2.11.1604221834430.3941@nanos> <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com>
 <alpine.DEB.2.11.1604251018090.3941@nanos> <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com>
 <alpine.DEB.2.11.1604271216400.3941@nanos> <CAJFUiJir_zvQDXub=1zwPKJoZm_AnWNpGXuSUiCeHAEwEEUCMQ@mail.gmail.com>
 <alpine.DEB.2.11.1604280813570.3941@nanos> <CAJFUiJgUDSYE+6MG3riVyFjhhqckeY_3nEqer52tkUOy_yBeOw@mail.gmail.com>
 <alpine.DEB.2.11.1604290240560.3718@nanos> <CAJFUiJgSDwtpXWPcGu704=5tggOntmyfk=muOtDLRcSUJQc8Rg@mail.gmail.com>
 <alpine.DEB.2.11.1605021007310.3692@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1605021007310.3692@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 2, 2016 at 1:11 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 29 Apr 2016, Lianwei Wang wrote:
>> On Thu, Apr 28, 2016 at 5:44 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > Wrong. This is the symptom. The root cause is in #1. Therefor you are trying
>> > to fix the symptom and not the root cause
>> >
>> I don't understand why you keep saying that the issue is in the pm
>> notifier callback. As I told you, the pm notifier return an error(or
>> NOTIFY_BAD) on purpose to abort the suspend process. This is work as
>> design. Any driver can abort the suspend process if it is not ready to
>> suspend.
>
> Right. That's not the issue. The issue is that as a consequence we end up with
> an unbalanced count. So how do we end up with an unbalanced count? That's what
> needs to be fixed and not worked around.
>
In this example, the unbalanced count is caused by the
cpu_hotplug_pm_callback pm notifier callback function. We can add a
variable to avoid the unbalanced call of cpu_hotplug_enable ,e.g.
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3e3f6e49eabb..aa6694f0e9d3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1140,16 +1140,21 @@ static int
 cpu_hotplug_pm_callback(struct notifier_block *nb,
                        unsigned long action, void *ptr)
 {
+       static int disabled;
+
        switch (action) {

        case PM_SUSPEND_PREPARE:
        case PM_HIBERNATION_PREPARE:
                cpu_hotplug_disable();
+               disabled = 1;
                break;

        case PM_POST_SUSPEND:
        case PM_POST_HIBERNATION:
-               cpu_hotplug_enable();
+               if (disabled)
+                       cpu_hotplug_enable();
+               disabled = 0;
                break;

        default:

Please let me know if you like to fix it in this way.

But actually I think we don't need to add a new variable to check if
the cpu_hotplug_disable() is called or not. We already have a disable
counter which can be used to check if the cpu_hotpug_disable is called
or not, as my original patch do in cpu_hotplug_enable() function.
Maybe the reset comments and reset cpu_hotplug_disabled to 0 operation
confuse you. I should check it firstly and do nothing if it is already
0.
e.g.
+static void _cpu_hotplug_enable(void)
+{
+       if (WARN(!cpu_hotplug_disabled, "Unbalanced cpu hotplug enable\n"))
+               return;
+
+       cpu_hotplug_disabled--;
+}

I like to fix it in the cpu_hotplug_enable because it is a public
kernel API and fix in it can prevent any other unbalanced calling. I
will update the patch.

>> > I completely understand that you are tyring to put the cart before the horse.
>> No. Your understanding is wrong.
>
> My understanding is very correct. We have a situation which leads to an
> unbalanced count. Instead of fixing that, you fix up the unbalanced count.
>
Yes, that's right. We are on the same page. The only difference is
that where/how to fix it. See my two solutions above and let me know
which one you like?
> Thanks,
>
>         tglx
