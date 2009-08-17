From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Mon, 17 Aug 2009 23:31:48 +0200
Message-ID: <4A89CC44.2000506@gmail.com>
References: <200908172028.26817.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0908171640590.2680-100000@iolanthe.rowland.org>
	<20090817211413.GA30252@kroah.com>
	<20090817211514.GA30538@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090817211514.GA30538@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On 08/17/2009 11:15 PM, Greg KH wrote:
> Oh wait, I think this is only needed on top of the rest of the tty tree,
> Linus's tree should not need this.
> 
> But I think Jiri is tracking down something in this area, Jiri?

Yes, but I think it's unrelated. My problem lies probably somewhere in
kernel/cpu.c.

Anyway I use the following. The function is called with interrupts
disabled during resume. Won't it help you by a chance?

commit e5a02f5ee04b20aa84295c4912259d4fa5b7642b
Author: Jiri Slaby <jirislaby@gmail.com>
Date:   Thu Aug 13 21:53:18 2009 +0200

    fix load_debug_register locking

diff --git a/kernel/hw_breakpoint.c b/kernel/hw_breakpoint.c
index c1f64e6..bc5368d 100644
--- a/kernel/hw_breakpoint.c
+++ b/kernel/hw_breakpoint.c
@@ -80,17 +80,15 @@ void load_debug_registers(void)
        unsigned long flags;
        struct task_struct *tsk = current;

-       spin_lock_bh(&hw_breakpoint_lock);
+       spin_lock_irqsave(&hw_breakpoint_lock, flags);

        /* Prevent IPIs for new kernel breakpoint updates */
-       local_irq_save(flags);
        arch_update_kernel_hw_breakpoint(NULL);
-       local_irq_restore(flags);

        if (test_tsk_thread_flag(tsk, TIF_DEBUG))
                arch_install_thread_hw_breakpoint(tsk);

-       spin_unlock_bh(&hw_breakpoint_lock);
+       spin_unlock_irqrestore(&hw_breakpoint_lock, flags);
 }

 /*
