From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: GPF in
 run_workqueue()/list_del_init(cwq->worklist.next) on resume (was: Re: Help
 needed: Resume problems in 2.6.32-rc,
 perhaps related to preempt_count leakage in keventd)
Date: Fri, 13 Nov 2009 00:08:32 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0911130004110.24119__931.807075585489$1258067434$gmane$org@localhost.localdomain>
References: <200911091250.31626.rjw@sisk.pl> <200911122153.12419.rjw@sisk.pl>
	<alpine.LFD.2.00.0911122153320.24119@localhost.localdomain>
	<200911122355.11675.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911122355.11675.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Mike Galbraith <efault@gmx.de>, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Nov 2009, Rafael J. Wysocki wrote:
> > debugobjects should catch the attempt to free the memory which holds
> > the work_struct, cancel it and print a backtrace where this happened.
> 
> I got the appended trace, so I guess it works.

Yup. I assume the box survived otherwise you wouldnt have retrieved
the backtrace.

> [   93.028997] ODEBUG: free active object type: work_struct

Active work_struct is freed

> [   93.039180]  [<ffffffff810c8d7c>] kfree+0x71/0x88
> [   93.039282]  [<ffffffffa03d36f1>] btusb_destruct+0x10/0x12 [btusb]

Here is the offending code and it's call chain.

> [   93.039282]  [<ffffffffa03d36d0>] btusb_disconnect+0x81/0x92 [btusb]
> [   93.039282]  [<ffffffffa00c6612>] usb_unbind_interface+0x5e/0xe1 [usbcore]
> [   93.039282]  [<ffffffff811ebead>] __device_release_driver+0x70/0xbe
> [   93.039282]  [<ffffffff811ebfc6>] device_release_driver+0x1e/0x2b
> [   93.040317]  [<ffffffff811ebb46>] bus_remove_device+0x83/0x92
> [   93.040317]  [<ffffffff811e9940>] device_del+0x12e/0x170
> [   93.040317]  [<ffffffffa00c3adf>] usb_disable_device+0x76/0xf5 [usbcore]
> [   93.040317]  [<ffffffffa00becfb>] usb_disconnect+0x96/0xfa [usbcore]
> [   93.040317]  [<ffffffffa00bf927>] hub_thread+0x493/0xe2c [usbcore]
> [   93.040317]  [<ffffffff81058465>] ? autoremove_wake_function+0x0/0x38
> [   93.040317]  [<ffffffff81293de6>] ? preempt_schedule+0x3b/0x41
> [   93.040317]  [<ffffffffa00bf494>] ? hub_thread+0x0/0xe2c [usbcore]
> [   93.040317]  [<ffffffff8105823e>] kthread+0x69/0x71
> [   93.040317]  [<ffffffff8100c16a>] child_rip+0xa/0x20
> [   93.042128]  [<ffffffff810581d5>] ? kthread+0x0/0x71
> [   93.042393]  [<ffffffff8100c160>] ? child_rip+0x0/0x20
> [   93.042478] ---[ end trace 6915b286c29296ce ]---

That does not necessary tell you which of the work_structs in the
bluetooth code it is, but it limits the search of culprits
significantly.

Thanks for testing and confirming.

       tglx
