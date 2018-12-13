From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] driver core: Add missing dev->bus->need_parent_lock checks
Date: Thu, 13 Dec 2018 20:06:28 +0100
Message-ID: <CAKMK7uFFpqFy8tksvMxW2X6_gT-Se8Y9Jbtcxun99e4vRSdgQA@mail.gmail.com>
References: <7586985.G9YL5ver76@aspire.rjw.lan> <20181213185304.GB18107@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213185304.GB18107@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, liumartin@google.com, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 13, 2018 at 7:53 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 13, 2018 at 07:27:47PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > __device_release_driver() has to check dev->bus->need_parent_lock
> > before dropping the parent lock and acquiring it again as it may
> > attempt to drop a lock that hasn't been acquired or lock a device
> > that shouldn't be locked and create a lock imbalance.
> >
> > Fixes: 8c97a46af04b (driver core: hold dev's parent lock when needed)
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This should go into -stable for everything over 4.18 methinks.
>
> Does this fix Daniel's lockdep splat?

Nah, separate issue. Afaiui bus->need_parent_lock is only set for usb,
I'm unbinding pci devices. I guess the combination of someone
unbinding an usb device through sysfs which also has some device links
attached doesn't happen.

Since I've dug around in this, for this patch here from Rafael:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel

>
> thanks,
>
> greg k-h



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
