From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: [Bug 8498], [Bug 8510], and Re: Can't s2ram 22-rc2
Date: Mon, 21 May 2007 17:10:00 +0200
Message-ID: <1179760200.4082.1.camel__26648.6262124547$1179760355$gmane$org@localhost>
References: <Pine.LNX.4.44L0.0705211040330.4496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705211040330.4496-100000@iolanthe.rowland.org>
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
Cc: Jiri Slaby <jirislaby@gmail.com>, Avuton Olrich <avuton@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-05-21 at 10:51 -0400, Alan Stern wrote:
> On Sat, 19 May 2007, Greg KH wrote:

> It turns out that the patch I originally wrote to fix this is in
> conflict with one of Raphael's patches (make freezeable workqueues
> singlethread) already added to 2.6.22-rc2.  So here's an updated
> version for that kernel.
> 
> Andrey, Soeren, and Avuton: Please try this patch with 2.6.22-rc2 or 
> later and see if it fixes your problems.
> 
> Greg, if this works then I'll send it in the proper form for a patch, 
> and you can use it to replace
> 
> 	usb-make-the-autosuspend-workqueue-thread-freezable.patch


works perfect, i.e. the machine survived 3 s2ram cycles and rebooted
cleanly :-))

apply! apply!

Soeren

> Alan Stern
> 
> 
> Index: 2.6.22-rc2/drivers/usb/core/usb.c
> ===================================================================
> --- 2.6.22-rc2.orig/drivers/usb/core/usb.c
> +++ 2.6.22-rc2/drivers/usb/core/usb.c
> @@ -205,7 +205,7 @@ struct device_type usb_device_type = {
>  
>  static int ksuspend_usb_init(void)
>  {
> -	ksuspend_usb_wq = create_singlethread_workqueue("ksuspend_usbd");
> +	ksuspend_usb_wq = create_freezeable_workqueue("ksuspend_usbd");
>  	if (!ksuspend_usb_wq)
>  		return -ENOMEM;
>  	return 0;
> 
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
