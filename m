From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [BUG]  usb_dev_resume returns -113 due to work items queued by
 usb on pm_wq is not executed before suspending.
Date: Fri, 15 Aug 2014 10:19:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1408151018410.1144-100000@iolanthe.rowland.org>
References: <0C18FE92A7765D4EB9EE5D38D86A563A01BA6392@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0C18FE92A7765D4EB9EE5D38D86A563A01BA6392-0J0gbvR4kTggGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Du, ChangbinX" <changbinx.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Nyman, Mathias" <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "pavel-+ZI9xUNit7I@public.gmane.org" <pavel-+ZI9xUNit7I@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Wu, Hao" <hao.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 15 Aug 2014, Du, ChangbinX wrote:

> Hi, All,
> As described in runtime_pm.txt for pm_wq:
> The power management work queue pm_wq in which bus types and device
> drivers can put their PM-related work items. It is strongly recommended that
> pm_wq be used for queuing all work items related to runtime PM, because
> this allows them to be synchronized with system-wide power transitions
> (suspend to RAM, hibernation and resume from system sleep states).
> 
> Per my understanding, all runtime PM related works items queued on pm_wq
> should be completed before suspend to RAM. So to ensure device state is
> runtime active before suspending. Having checked the pm code, I found this is
> not true for work items queued by drivers.
> 
> Now usb driver has used this pm_wq to run a work item that resumes root hub
> (see function xhci_resume()->usb_hcd_resume_root_hub()). But sometimes
> this work is not completed before usb device suspend. That is to say root hub
> device may still in runtime suspend state before suspending. And this can result
> in problem. One case is that as below error log shows,
> 
> [  108.046248] PM: Entering mem sleep
> [  108.050487] Suspending console(s) (use no_console_suspend to debug)
> [  108.426510] active wakeup source: event5-576
> [  108.426529] PM: Some devices failed to suspend
> [  108.426887] dpm_run_callback(): usb_dev_resume+0x0/0x20 returns -113
> [  108.426918] PM: Device 1-2 failed to resume async: error -113
> [  108.428299] PM: resume of devices complete after 1.755 msecs
> 
> The usb_dev_resume() return error -113, which mean host is in suspend state
> when resuming a device. The scenario is:
> 1) Just before system suspending, pm core will run hcd runtime resume
>   routine if host is in runtime suspend state.
> 2) Hcd runtime resume function xhci_resume() returns, and roothub resume
>   worker was queued by usb_hcd_resume_root_hub().
> 3) system suspend continue going before roothub resume worker starts executing.
>   Thus host is still in runtime suspend state.
> 4) One event make suspending process aborted before hcd suspended. Then pm
>   core will call resume routines for just suspended device. But when resuming
>   a usb device it find the host is in suspended. Then return error -113.
> 
> If my analysis is correct, could you share your ideas for this issue?

Hasn't this already been fixed?  See commit d6236f6d1d88 (xhci: Fix 
runtime suspended xhci from blocking system suspend).

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
