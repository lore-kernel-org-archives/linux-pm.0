From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Fri, 2 Oct 2015 07:41:07 +0200
Message-ID: <20151002054107.GB18406@kroah.com>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151001172932.GG4469@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 01, 2015 at 12:29:32PM -0500, Felipe Balbi wrote:
> On Thu, Sep 24, 2015 at 10:39:23AM -0700, Baolin Wang wrote:
> > The usb charger framework is based on usb gadget. The usb charger
> > need to be notified the state changing of usb gadget to confirm the
> > usb charger state.
> > 
> > Thus this patch adds a notifier mechanism for usb gadget to report a
> > event to usb charger when the usb gadget state is changed.
> > 
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/usb/gadget/udc/udc-core.c | 32 ++++++++++++++++++++++++++++++++
> >  include/linux/usb/gadget.h        | 18 ++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> > index f660afb..4238fc3 100644
> > --- a/drivers/usb/gadget/udc/udc-core.c
> > +++ b/drivers/usb/gadget/udc/udc-core.c
> > @@ -129,6 +129,32 @@ void usb_gadget_giveback_request(struct usb_ep *ep,
> >  }
> >  EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
> >  
> > +int usb_gadget_register_notify(struct usb_gadget *gadget,
> > +			       struct notifier_block *nb)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&gadget->lock);
> > +	ret = raw_notifier_chain_register(&gadget->nh, nb);
> > +	mutex_unlock(&gadget->lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(usb_gadget_register_notify);
> > +
> > +int usb_gadget_unregister_notify(struct usb_gadget *gadget,
> > +				 struct notifier_block *nb)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&gadget->lock);
> > +	ret = raw_notifier_chain_unregister(&gadget->nh, nb);
> 
> Greg, this is the kind of thing I wanted to avoid adding more of.
> 
> I was wondering if you would accept subsystems using kdbus for
> this sort of notification. I'm okay waiting for kdbus for another
> couple merge windows (if we have to) before that's merged, but
> if we take this raw notifier approach now, we will end up having
> to support it forever.

kdbus is userspace <-> userspace messages, it doesn't do kernel <->
userspace messages, sorry.

> Also, because soon enough we will have to support USB Power Delivery
> with Type C connector, this is bound to change in the coming months.
> 
> Frankly, I wanted all of this to be decided in userland with the
> kernel just providing notification and basic safety checks (we don't
> want to allow a bogus userspace daemon frying anybody's devices).
> 
> How would you feel about that ?

I agree I don't like new notifier chains being added, but as this is all
in-kernel, we can change the api in the future and there would not be a
problem, right?

And yeah, I'm worried about the USB Power delivery patches, I haven't
seen them yet, but I hear about different groups doing different things
here, and that worries me.

thanks,

greg k-h
