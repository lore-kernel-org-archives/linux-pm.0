From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Thu, 8 Oct 2015 17:50:52 +0200
Message-ID: <20151008155052.GH11776@xo-6d-61-c0.localdomain>
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
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org
List-Id: linux-pm@vger.kernel.org

HI!

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
> 
> Also, because soon enough we will have to support USB Power Delivery
> with Type C connector, this is bound to change in the coming months.
> 
> Frankly, I wanted all of this to be decided in userland with the
> kernel just providing notification and basic safety checks (we don't
> want to allow a bogus userspace daemon frying anybody's devices).
> 
> How would you feel about that ?

So init=/bin/bash boot no longer provides machine that charges itself?

That would be bad. Traditionally, hardware controls battery charging,
and if hardware needs some help, we should do it in kernel, to mask
the difference from userspace.
								Pavel
