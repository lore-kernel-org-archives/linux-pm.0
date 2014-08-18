From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: RE: [BUG]  usb_dev_resume returns -113 due to work items queued by
 usb on pm_wq is not executed before suspending.
Date: Mon, 18 Aug 2014 10:22:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1408181019470.1332-100000@iolanthe.rowland.org>
References: <0C18FE92A7765D4EB9EE5D38D86A563A01BA7FD0@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0C18FE92A7765D4EB9EE5D38D86A563A01BA7FD0-0J0gbvR4kTggGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Du, ChangbinX" <changbinx.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Nyman, Mathias" <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "pavel-+ZI9xUNit7I@public.gmane.org" <pavel-+ZI9xUNit7I@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Wu, Hao" <hao.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 18 Aug 2014, Du, ChangbinX wrote:

> > On Fri, 15 Aug 2014, Du, ChangbinX wrote:
> > > If my analysis is correct, could you share your ideas for this issue?
> > 
> > Hasn't this already been fixed?  See commit d6236f6d1d88 (xhci: Fix runtime
> > suspended xhci from blocking system suspend).
> > 
> > Alan Stern
> 
> Hi, Stern,
> These are two different issues. Commit d6236f6d1d88 fixes issue that xhci runtime
> pm logical blocks system suspend. But the issue we are encountering is usb device
> resuming fail and lead to device reset.

Yes, the issues are different, but I think the fix is the same.  You
should test a kernel that includes commit d6236f6d1d88.

> This issue can be reproduced by below steps:
> 1) Plug a usb device to usb3 host, and make sure this device can enter runtime
>   suspend state.
> 2) Wait HCD entering runtime suspend state.( xhci_suspend() will be called)
> 3) Make system starts system suspending. On this step, PM core freeze threads and
>   resume hcd & the usb device to runtime active state(xhci_resume() will be called, 
>   and roothub resuming work item is queued). Then calls the suspend callbacks of devices'.

Commit d6236f6d1d88 prevents the roothub resuming work item from being
queued.

> 4) We force system suspending process aborted (by modifying code) just after the usb
>   Device suspend callback is invoked.
> 5) Then PM core will call resume callback of the usb device to recovery. On this step
>   usb_dev_resume() invokes and it return -113 error. Because the can_submit flag of
>   root hub is 0. Root hub resuming work item is still pending.

I still think that commit has already fixed your problem.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
