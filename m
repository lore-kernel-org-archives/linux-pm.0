From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC] kernel/hung_task.c: disable on suspend
Date: Thu, 13 Sep 2018 11:04:34 +0200
Message-ID: <CAJZ5v0gEGfHTEPQ3MpFQeviDBv174aoJjGR45NJfzkRerxQhjQ@mail.gmail.com>
References: <20180912161119.2692-1-vkuznets@redhat.com> <CAJZ5v0jeq=PoF10OZgO9ST_nuRW3Z8emPmX=nTrOSsLKYzZuww@mail.gmail.com>
 <875zz9ainn.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <875zz9ainn.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 13, 2018 at 10:47 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Wed, Sep 12, 2018 at 6:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> It is possible to observe hung_task complaints when system goes to
> >> suspend-to-idle state:
> >>
> >>  PM: Syncing filesystems ... done.
> >>  Freezing user space processes ... (elapsed 0.001 seconds) done.
> >>  OOM killer disabled.
> >>  Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> >>  sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >>  INFO: task bash:1569 blocked for more than 120 seconds.
> >>        Not tainted 4.19.0-rc3_+ #687
> >>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>  bash            D    0  1569    604 0x00000000
> >>  Call Trace:
> >>   ? __schedule+0x1fe/0x7e0
> >>   schedule+0x28/0x80
> >>   suspend_devices_and_enter+0x4ac/0x750
> >>   pm_suspend+0x2c0/0x310
> >
> > This actually is a good catch, but the problem is related to what
> > happens to the monotonic clock during suspend to idle.
> >
> > The clock issue needs to be addressed anyway IMO and then this problem
> > will go away automatically.
>
> Do I understand it correctly that the suggestion is to fully suspend
> monothonic clock in s2idle (and don't advance it after resume)?

Something like that.

We already do that to some extent, but kind of with the assumption
that it will not grow too much in s2idle_loop(), but it may actually
grow too much in there, so we need to compensate for that to make the
s2idle behavior reflect the suspend-to-RAM one.

I have a patch for that, will post it shortly.

Thanks,
Rafael
