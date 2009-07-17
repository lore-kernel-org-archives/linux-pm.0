From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH] [suspend] pci_raw_set_power_state: replace
 msleep by udelay in resuming procedure
Date: Fri, 17 Jul 2009 10:10:43 +0800
Message-ID: <1247796643.19112.77.camel__30041.970316279$1247796710$gmane$org@falcon>
References: <Pine.LNX.4.44L0.0907161259510.2952-100000@iolanthe.rowland.org>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0907161259510.2952-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: len.brown@intel.com, yanh@lemote.com, linux-kernel@vger.kernel.org, zhangfx@lemote.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, 2009-07-16 at 13:02 -0400, Alan Stern wrote:
> On Thu, 16 Jul 2009, Wu Zhangjin wrote:
> 
> > we can not call msleep() when resuming from STR/Standby: if the
> > current_state of the pci device is PCI_D3hot, means we are in the
> > procedure of resuming, in this procedure, we can not re-schedule,
> > otherwise, there will be a deadlock.
> 
> I don't understand.
> 
> First of all, why does current_state == PCI_D3hot mean the system is
> resuming from sleep?  Isn't it possible that the PCI device is going
> through a runtime resume?
> 
> Secondly, why will scheduling during a resume cause a deadlock?

Sorry, I'm stupid to make conclusion before describing the problem
clearly, here is the problem I encountered:

when I enabled SUSPEND=y in linux-2.6.30.1(with relative patches) on a
loongson-based machine(yeeloong laptop,loongson is mips-compatiable), I
tried to suspend it via "echo standby > /sys/power/state", with the
serial port debugging support, I found it enter into the standby mode
successfully. and then, tried to wake it up via the keyboard interrupt,
but it stopped at the "Power_up_devices:" of kernel/power/main.c.

here is a short path of this procedure:

suspend_enter:
	...
	device_power_down
	...
	arch_suspend_disable_irqs
	...
	sysdev_suspend
	...
	suspend_ops->enter  (board-specific part)
	...
	sysdev_resume
	...
	arch_suspend_enable_irqs
	...
	device_power_up	 <-----------------------stop here
	...
	
and then I continue to trace it:

device_power_up:
	dpm_power_up:
		list_for_each_entry(dev, &dpm_list, power.entry)
			<<DEBUG>>
                if (dev->power.status > DPM_OFF) {
                        int error;

                        dev->power.status = DPM_OFF;
                        error = resume_device_noirq(dev, state);
                        if (error)
                                pm_dev_err(dev, state, " early", error);
                }   

I tried to add prom_putchar() at <<DEBUG>> to print something, and This
will make it resume from standby mode successfully. seems,
prom_putchar() have influenced the power.status, and make some devices
not enter into the condition statement, and make dpm_power_up return
directly. (this is very weird, not sure why?)

so, I removed the prom_putchar() from <<DEBUG>>, and it stopped at
resume_device_noirq, here is the following tracing path:
	
resume_device_noirq:
   --> pm_noirq_op
   --> ops->resume_noirq (dev) <--> pci_pm_resume_noirq:
	   --> pci_pm_default_resume_noirq
	   --> pci_restore_standard_config
	   --> pci_set_power_state
           --> pci_raw_set_power_state
           --> msleep    <-----------------------[ stop here]

msleep:
	--> schedule_timeout_uninterruptible
	--> schedule_timeout
	     --> ... 
	     --> __mod_timer
             --> ...
	     --> schedule ---> a new scheduling happen and never return

and then I tried to trace schedule(), and even added a prom_putchar() to
the end of the schedule() function, it output something successfully,
but never return to schedule_timeout(dead? no keyboard response), seems
very weird! this is reproductive, perhaps I have missed something here.
 
so, to avoid this 'weird' situation, I think it's better not to
re-schedule in the resuming procedure from standby. and here, I can not
find another condition to judge the resuming procedure from standby, so,
I use "current_state == PCI_D3hot"(so, my pre-expression is really wrong
for it maybe not resume from standby as you indicated). and is there
another condition to judge we are resuming from standby? perhaps this is
better:

   ((current_state == PCI_D3hot) && (state == PCI_D0))

but seems this also can not indicate we are resuming from standby.

Regards,
Wu Zhangjin
