From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 1/3] Runtime PM support for named power states
Date: Sun, 2 Oct 2005 22:37:46 +0200
Message-ID: <20051002203746.GA2239@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0509301614340.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37777839788379453=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509301614340.4470-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============37777839788379453==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Index: usb-2.6/drivers/base/power/sysfs.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/sysfs.c
> +++ usb-2.6/drivers/base/power/sysfs.c
> @@ -3,12 +3,21 @@
>   */
>  
>  #include <linux/device.h>
> +#include <linux/string.h>
>  #include "power.h"
>  
> +const char pm_name_ON[] = "on";
> +const char pm_name_SUSPEND[] = "suspend";
> +EXPORT_SYMBOL_GPL(pm_name_ON);
> +EXPORT_SYMBOL_GPL(pm_name_SUSPEND);
> +

Oops, I believe we still want non-GPL drivers to work correctly with
our kernel...

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============37777839788379453==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============37777839788379453==--
