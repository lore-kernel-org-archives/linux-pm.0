From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v4 3/3] USB / PM: Allow USB devices to remain runtime-suspended when sleeping
Date: Fri, 17 Jul 2015 02:41:55 +0200
Message-ID: <1624796.mhhJfdIHrQ@vostro.rjw.lan>
References: <1436964008-15151-1-git-send-email-tomeu.vizoso@collabora.com> <7175055.CJlfILVf3s@vostro.rjw.lan> <CAAObsKD_pKmzCLLij3YhO8pPOqXi-z0FNiGrXXcqr6Dt+V-KXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAObsKD_pKmzCLLij3YhO8pPOqXi-z0FNiGrXXcqr6Dt+V-KXw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 16, 2015 02:09:41 PM Tomeu Vizoso wrote:
> On 16 July 2015 at 02:42, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> > On Wednesday, July 15, 2015 02:40:08 PM Tomeu Vizoso wrote:
> >> Have dev_pm_ops.prepare return 1 for USB devices and ports so that USB
> >> devices can remain runtime-suspended when the system goes to a sleep
> >> state, if their wakeup state is correct and they have runtime PM enabled.
> >>
> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> >> ---
> >>
> >>  drivers/usb/core/port.c |  6 ++++++
> >>  drivers/usb/core/usb.c  | 11 ++++++++++-
> >>  2 files changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> >> index 210618319f10..f49707d73b5a 100644
> >> --- a/drivers/usb/core/port.c
> >> +++ b/drivers/usb/core/port.c
> >> @@ -168,12 +168,18 @@ static int usb_port_runtime_suspend(struct device *dev)
> >>
> >>       return retval;
> >>  }
> >> +
> >> +static int usb_port_prepare(struct device *dev)
> >> +{
> >> +     return 1;
> >> +}
> >>  #endif
> >>
> >>  static const struct dev_pm_ops usb_port_pm_ops = {
> >>  #ifdef CONFIG_PM
> >>       .runtime_suspend =      usb_port_runtime_suspend,
> >>       .runtime_resume =       usb_port_runtime_resume,
> >> +     .prepare =              usb_port_prepare,
> >>  #endif
> >>  };
> >>
> >> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> >> index 8d5b2f4113cd..cf4dde11db1c 100644
> >> --- a/drivers/usb/core/usb.c
> >> +++ b/drivers/usb/core/usb.c
> >> @@ -316,7 +316,16 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
> >>
> >>  static int usb_dev_prepare(struct device *dev)
> >>  {
> >> -     return 0;               /* Implement eventually? */
> >> +     struct usb_device *udev = to_usb_device(dev);
> >> +
> >> +     if (!pm_runtime_enabled(dev))
> >
> > Why just enabled and not suspended?
> 
> Hmm, the core checks if it's runtime suspended before going
> direct_complete, but it's true that the API docs say that it should
> return a positive value only if it's runtime suspended.
> 
> Is there a reason why the prepare() implementations have to check that
> instead of leaving it to the core?

The concern is that they generally need to check the state of the device
which is meaningless from the suspend suitability (so to speak) perspective
if the device is not (runtime) suspended when the check is made.

But this particular case seems to be exceptional as ->prepare doesn't realy
check the device's (hardware) state, but only its software configuration
(if I'm not mistaken).  So checking the RPM status is not needed here.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
