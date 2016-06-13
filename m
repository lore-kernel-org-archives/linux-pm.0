From: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [RESEND PATCH v11 1/4] gadget: Introduce the usb charger
 framework
Date: Mon, 13 Jun 2016 15:13:11 +0000
Message-ID: <AM4PR04MB21308ECE74B23A44E51C42B689530@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <cover.1465807514.git.baolin.wang@linaro.org>
 <710550bd6c860d7dbdd3e7225ef51b59ae9c39fb.1465807514.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <710550bd6c860d7dbdd3e7225ef51b59ae9c39fb.1465807514.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel@vge>
List-Id: linux-pm@vger.kernel.org

Hi

> -----Original Message-----
> From: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-usb-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Baolin Wang
> Sent: Monday, June 13, 2016 4:47 PM
> To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
> Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org; stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org; r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org;
> yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org; lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org; patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org;
> baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: [RESEND PATCH v11 1/4] gadget: Introduce the usb charger
> framework
> 
> This patch introduces the usb charger driver based on usb gadget that
> makes an enhancement to a power driver. It works well in practice but that
> requires a system with suitable hardware.
> 
> The basic conception of the usb charger is that, when one usb charger is
> added or removed by reporting from the usb gadget state change or the
> extcon device state change, the usb charger will report to power user to
> set the current limitation.
> 
> The usb charger will register notifiees on the usb gadget or the extcon
> device to get notified the usb charger state. It also supplies the
> notification mechanism to userspace When the usb charger state is changed.
> 
> Power user will register a notifiee on the usb charger to get notified by
> status changes from the usb charger. It will report to power user to set
> the current limitation when detecting the usb charger is added or removed
> from extcon device state or usb gadget state.
> 
> This patch doesn't yet integrate with the gadget code, so some functions
> which rely on the 'gadget' are not completed, that will be implemented in
> the following patches.
> 
> Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Reviewed-by: Li Jun <jun.li-3arQi8VN3Tc@public.gmane.org>
Tested-by: Li Jun <jun.li-3arQi8VN3Tc@public.gmane.org>

> ---
>  drivers/usb/gadget/Kconfig       |    7 +
>  drivers/usb/gadget/udc/Makefile  |    1 +
>  drivers/usb/gadget/udc/charger.c |  770
> ++++++++++++++++++++++++++++++++++++++
>  include/linux/usb/charger.h      |  191 ++++++++++
>  include/uapi/linux/usb/charger.h |   31 ++
>  5 files changed, 1000 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/charger.c  create mode 100644
> include/linux/usb/charger.h  create mode 100644
> include/uapi/linux/usb/charger.h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
