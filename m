From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
Date: Fri, 21 Sep 2018 15:11:00 +0200
Message-ID: <87d0t70zdn.fsf@vitty.brq.redhat.com>
References: <20180913160851.18169-1-vkuznets@redhat.com>
        <4793718.OcKebjM5bH@aspire.rjw.lan>
        <87d0tg88l3.fsf@vitty.brq.redhat.com>
        <20180914162103.GA11171@redhat.com>
        <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com>
        <20180917165518.GA25931@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917165518.GA25931@redhat.com> (Oleg Nesterov's message of
        "Mon, 17 Sep 2018 18:55:18 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 09/17, Rafael J. Wysocki wrote:
>>
>> On Fri, Sep 14, 2018 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
>> >
>> > > > Since you are adding the notifier anyway, what about designing it to make
>> > > > the thread wait on _PREPARE until the notifier kicks it again on exit
>> > > > fron suspend/hibernation?
>> >
>> > Well. I agree that freezable kthreads are not nice, but it seems you are
>> > going to add another questionable interface ;)
>>
>> Why would it be questionable?
>>
>> The watchdog needs to be disarmed somehow before tasks are frozen and
>> re-armed after they have been thawed or it may report false-positives
>> on the way out.  PM notifiers can be used for that.
>
> Or watchdog() can simply use set_freezable/freezing interface we already
> have, without additional complications.
>
> Yes, this is not "before tasks are frozen", but probably should work?
>
> OK, I won't argue.

I was hoping you and Rafael will come to an agreement but the discussion
just died ... so where do we stand on this? I see the following options:

1) The v1 patch is good, no freezing/disabling/parking required.
2) Make the kthread freezable (btw, I tested your patch and it seems to
work).
3) kthread_stop/kthread_run() (as you said 'no parking').
4) Drop the patch and wait for the root cause (increasing jiffies) to
dissolve.
5) ???

Ideas?

-- 
  Vitaly
