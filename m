From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] apds9802als: add runtime PM support
Date: Fri, 29 Oct 2010 10:17:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010291009010.1588-100000@iolanthe.rowland.org>
References: <1288340224.19329.835.camel@hongdev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1288340224.19329.835.camel@hongdev>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hong Liu <hong.liu@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 29 Oct 2010, Hong Liu wrote:

> Hi, Alan
> 
> Thanks for your help, I still have some questions about the runtime PM
> after reading the doc you mentioned.
> 
> 
> On Wed, 2010-10-27 at 22:13 +0800, Alan Stern wrote:
> > On Wed, 27 Oct 2010, Hong Liu wrote:
> > 
> > > In apds9802als_resume, I just want to power up the device, do some
> > > configuration, and then runtime_suspend the device.
> > 
> > Then you should change the function the way I suggested.  The PM core
> > will automatically do a runtime suspend after the system has fully
> > woken up.
> 
> Would you please point out which part of the code does this? I am trying
> to find out...

In drivers/base/power/main.c:dpm_complete() there is a call to
pm_runtime_put_sync().

> I am still not very clear about who will be in charge of putting the
> device into runtime suspend state after the probe(). I saw code in
> e1000e driver, before your patch (f3ec4f8), it will manually schedule a
> runtime suspend after 1 second. But with your new code, I can't see
> which part of the code will put e1000e to runtime suspend.
> 
> @@ -5721,11 +5721,8 @@ static int __devinit e1000_probe(struct pci_dev *pdev,
>  
>         e1000_print_device_info(adapter);
>  
> -       if (pci_dev_run_wake(pdev)) {
> -               pm_runtime_set_active(&pdev->dev);
> -               pm_runtime_enable(&pdev->dev);
> -       }
> -       pm_schedule_suspend(&pdev->dev, MSEC_PER_SEC);
> +       if (pci_dev_run_wake(pdev))
> +               pm_runtime_put_noidle(&pdev->dev);
>  
>         return 0;

I'm not surprised you couldn't find the code; you were looking in the
wrong place.  After a probe, the runtime suspend is done by either
drivers/base/dd.c:driver_probe_device() or device_attach(), depending
on whether the driver was already loaded when the device was
registered.  Both functions call pm_runtime_put_sync().

> I think the runtime PM is working at bottom-up way, the child device
> will be in charge of itself, and once it decides to put itself into
> runtime suspend, it's parent will be notified, and if all children are
> runtime suspended, then the parent can runtime suspend itself. While for
> runtime resume, the child will runtime resume the parent first.

That's right.

> > > We don't have runtime_idle() implemented, so I have to manually put the
> > > device into runtime suspend.
> > 
> > The problem is that the device can be runtime-resumed by code other 
> > than your own, and that other code will not always do a runtime-suspend 
> > afterward -- it will do a runtime-idle.  That's why you need to define 
> > a runtime_idle() callback.
> 
> I saw subsystem level runtime_idle will call runtime_suspend if no
> runtime_idle is defined for the driver. So do we need to define a
> runtime_idle in the driver just to call runtime_suspend()?

I didn't realize the subsystem defined runtime_idle for you.  In that 
case no, you don't need to define your own version.  But you also don't 
have to manually put the device into runtime suspend (as you wrote 
above).

Alan Stern
