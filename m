From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] usb: avoid PM error messages during resume
	if a device was disconnected
Date: Mon, 23 Mar 2009 23:25:02 +0100
Message-ID: <200903232325.04181.elendil__24293.7492359944$1237847410$gmane$org@planet.nl>
References: <Pine.LNX.4.44L0.0903231738300.3610-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0903231738300.3610-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 23 March 2009, Alan Stern wrote:
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index d0a21a5..97ea69b 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -1727,6 +1727,10 @@ int usb_external_resume_device(struct usb_device *udev, pm_message_t msg)
> >     status = usb_resume_both(udev, msg);
> >  	udev->last_busy = jiffies;
> >  	usb_pm_unlock(udev);
> > +
> > +	if (status == -ENODEV)
> > +		return 0;
> > +
> >  	if (status == 0)
> >  		do_unbind_rebind(udev, DO_REBIND);
>
> Please include a short comment explaining the reason for this test
> (i.e., that there's no advantage in producing an error message since
> the regular disconnect messages will be generated shortly).

Will do if there are no other comments.

> Or do you think maybe it would be better to move this test up into the
> PM core?  After all, other subsystems will face the same issue.  I
> think that would be the best approach.  Yes?

I did look at that option, but implementing it in the USB subsystem seemed
more logical to me, for example as other subsystems possibly would want to
display an info message.

And is -ENODEV safe to ignore in all cases? Would there be other errors that
should be ignored too?

if Rafael would be happy with a generic test for -ENODEV, it could be done.
If not, maybe some other special error code would need to be used but then
you'd still need to test in the subsystem to set that error.
Disadvantage is also that it would make resume_device() and related PM
driver core functions quite a bit less clean than they currently are.

Implementing the test in USB was quite a bit simpler (for me at least ;-)

Thanks,
FJP
