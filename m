From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Thu, 11 Aug 2016 11:14:08 +0800
Message-ID: <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com>
References: <cover.1470034830.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1470034830.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Felipe,

On 1 August 2016 at 15:09, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Currently the Linux kernel does not provide any standard integration of this
> feature that integrates the USB subsystem with the system power regulation
> provided by PMICs meaning that either vendors must add this in their kernels
> or USB gadget devices based on Linux (such as mobile phones) may not behave
> as they should. Thus provide a standard framework for doing this in kernel.
>
> Now introduce one user with wm831x_power to support and test the usb charger,
> which is pending testing. Moreover there may be other potential users will use
> it in future.

Could you please apply this patchset into your 'next' branch if you
have no comments about it? Thank you.

>
> CHanges since v15:
>  - Add charger state checking to avoid sending out duplicate notifies to users.
>  - Add one work to notify power users the current has been changed.
>
> Changes since v14:
>  - Add kernel documentation for struct usb_cahrger.
>  - Remove some redundant WARN() functions.
>
> Changes since v13:
>  - Remove the charger checking in usb_gadget_vbus_draw() function.
>  - Rename some functions in charger.c file.
>  - Rebase on git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git tags/usb-for-v4.8
>
> Changes since v12:
>  - Remove the class and device things.
>  - Link usb charger to udc-core.ko.
>  - Create one "charger" subdirectory which holds all charger-related attributes.
>
> Changes since v11:
>  - Reviewed and tested by Li Jun.
>
> Changes since v10:
>  - Introduce usb_charger_get_state() function to check charger state.
>  - Remove the mutex lock in usb_charger_set_cur_limit_by_type() function
>  in case will be issued in atomic context.
>
> Baolin Wang (4):
>   usb: gadget: Introduce the usb charger framework
>   usb: gadget: Support for the usb charger framework
>   usb: gadget: Integrate with the usb gadget supporting for usb charger
>   power: wm831x_power: Support USB charger current limit management
>
>  drivers/power/wm831x_power.c     |   69 ++++
>  drivers/usb/gadget/Kconfig       |    8 +
>  drivers/usb/gadget/udc/Makefile  |    1 +
>  drivers/usb/gadget/udc/charger.c |  780 ++++++++++++++++++++++++++++++++++++++
>  drivers/usb/gadget/udc/core.c    |   17 +
>  include/linux/mfd/wm831x/pdata.h |    3 +
>  include/linux/usb/charger.h      |  186 +++++++++
>  include/linux/usb/gadget.h       |    3 +
>  include/uapi/linux/usb/charger.h |   31 ++
>  9 files changed, 1098 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/charger.c
>  create mode 100644 include/linux/usb/charger.h
>  create mode 100644 include/uapi/linux/usb/charger.h
>
> --
> 1.7.9.5
>



-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
