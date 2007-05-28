From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 15:07:09 +0200
Message-ID: <20070528130709.GO18807@elf.ucw.cz>
References: <200705272229.21263.rjw@sisk.pl> <200705272231.54535.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705272231.54535.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Use a hibernation and suspend notifier to disable the firmware requesting
> mechanism before a hibernation/suspend and enable it after the operation.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
>  drivers/base/firmware_class.c |   36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> Index: linux-2.6.22-rc3/drivers/base/firmware_class.c
> ===================================================================
> --- linux-2.6.22-rc3.orig/drivers/base/firmware_class.c	2007-05-27 19:43:03.000000000 +0200
> +++ linux-2.6.22-rc3/drivers/base/firmware_class.c	2007-05-27 19:44:06.000000000 +0200
> @@ -17,6 +17,8 @@
>  #include <linux/bitops.h>
>  #include <linux/mutex.h>
>  #include <linux/kthread.h>
> +#include <linux/notifier.h>
> +#include <linux/suspend.h>
>  
>  #include <linux/firmware.h>
>  #include "base.h"
> @@ -35,6 +37,9 @@ enum {
>  
>  static int loading_timeout = 60;	/* In seconds */
>  
> +/* If set, _request_firmware() will exit immediately returning -EBUSY */
> +static int requesting_firmware_disabled;
> +
>  /* fw_lock could be moved to 'struct firmware_priv' but since it is just
>   * guarding for corner cases a global lock should be OK */
>  static DEFINE_MUTEX(fw_lock);
> @@ -397,6 +402,9 @@ _request_firmware(const struct firmware 
>  	struct firmware *firmware;
>  	int retval;
>  
> +	if (requesting_firmware_disabled)
> +		return -EBUSY;

WARN_ON()? This should not happen, and if it does, we'll end up with
non-working device.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
