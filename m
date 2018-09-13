From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC] kernel/hung_task.c: disable on suspend
Date: Thu, 13 Sep 2018 17:27:20 +0200
Message-ID: <CAJZ5v0gmwvVa_YT8JQvDsW58xmubtKT58bH77zz8c5FdA8Py8Q@mail.gmail.com>
References: <20180912161119.2692-1-vkuznets@redhat.com> <CAJZ5v0jeq=PoF10OZgO9ST_nuRW3Z8emPmX=nTrOSsLKYzZuww@mail.gmail.com>
 <20180913152307.GA31894@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913152307.GA31894@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 13, 2018 at 5:23 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 09/13, Rafael J. Wysocki wrote:
> >
> > On Wed, Sep 12, 2018 at 6:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > >
> > > It is possible to observe hung_task complaints when system goes to
> > > suspend-to-idle state:
> > >
> > >  PM: Syncing filesystems ... done.
> > >  Freezing user space processes ... (elapsed 0.001 seconds) done.
> > >  OOM killer disabled.
> > >  Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> > >  sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > >  INFO: task bash:1569 blocked for more than 120 seconds.
> > >        Not tainted 4.19.0-rc3_+ #687
> > >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > >  bash            D    0  1569    604 0x00000000
> > >  Call Trace:
> > >   ? __schedule+0x1fe/0x7e0
> > >   schedule+0x28/0x80
> > >   suspend_devices_and_enter+0x4ac/0x750
> > >   pm_suspend+0x2c0/0x310
> >
> > This actually is a good catch, but the problem is related to what
> > happens to the monotonic clock during suspend to idle.
> >
> > The clock issue needs to be addressed anyway IMO and then this problem
> > will go away automatically.
>
> I don't understand your discussion with Vitaly, but shouldn't we make
> khungtaskd thread freezable anyway?

Well, if the Vitaly's patch is applied, that shouldn't be necessary
and I wouldn't like to add more freezable kernel threads if that's
avoidable TBH.

Cheers,
Rafael
