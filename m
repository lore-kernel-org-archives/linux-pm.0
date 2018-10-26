From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4] kernel/hung_task.c: disable on suspend
Date: Fri, 26 Oct 2018 11:23:34 +0200
Message-ID: <1827523.RqSiaKuRRv@aspire.rjw.lan>
References: <20181017112355.12763-1-vkuznets@redhat.com> <CAJZ5v0iJmn4x+zqNhQ4zfYCucnZhYb2hK3o096xPX6Ju2zV2oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iJmn4x+zqNhQ4zfYCucnZhYb2hK3o096xPX6Ju2zV2oQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, October 18, 2018 9:32:42 AM CEST Rafael J. Wysocki wrote:
> On Wed, Oct 17, 2018 at 1:24 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >
> > It is possible to observe hung_task complaints when system goes to
> > suspend-to-idle state:
> >
> >  # echo freeze > /sys/power/state
> >
> >  PM: Syncing filesystems ... done.
> >  Freezing user space processes ... (elapsed 0.001 seconds) done.
> >  OOM killer disabled.
> >  Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> >  sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >  INFO: task bash:1569 blocked for more than 120 seconds.
> >        Not tainted 4.19.0-rc3_+ #687
> >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >  bash            D    0  1569    604 0x00000000
> >  Call Trace:
> >   ? __schedule+0x1fe/0x7e0
> >   schedule+0x28/0x80
> >   suspend_devices_and_enter+0x4ac/0x750
> >   pm_suspend+0x2c0/0x310
> >
> > Register a PM notifier to disable the detector on suspend and re-enable
> > back on wakeup.
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Thanks for your patience with this!
> 
> Are there any objections or concerns regarding this patch?

Seeing none, so applied.

Thanks,
Rafael
