From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: use pm_op methods for device types
Date: Thu, 25 Sep 2008 23:27:02 +0200
Message-ID: <200809252327.03305.rjw__46906.2823839069$1222377891$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0809251704580.2181-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0809251704580.2181-100000@iolanthe.rowland.org>
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
Cc: Jiri Slaby <jirislaby@gmail.com>, USB list <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 25 of September 2008, Alan Stern wrote:
> This patch (as1141) adds code to use the device type's pm_op methods,
> if they are defined.  It fixes a regression in the USB PM code; the
> various suspend and resume methods are defined in the device type
> rather than in the bus, because USB devices have to be handled
> differently from USB interfaces.  Without the patch, those methods
> never get called.
> 
> The patch also fixes a couple of spelling errors.

Hm, these changes are not needed in the current mainline, so there's a patch
in -next that removes the code added by this patch.

It might be better to find that patch and drop it instead, IMO.

> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Tested-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
> 
> This should be merged before 2.6.27 is released, if possible.  
> Otherwise people will find their systems refuse to suspend when any USB
> devices are attached.
> 
> 
> 
> Index: usb-2.6/drivers/base/power/main.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/main.c
> +++ usb-2.6/drivers/base/power/main.c
> @@ -107,7 +107,7 @@ void device_pm_remove(struct device *dev
>  }
>  
>  /**
> - *	pm_op - execute the PM operation appropiate for given PM event
> + *	pm_op - execute the PM operation appropriate for given PM event
>   *	@dev:	Device.
>   *	@ops:	PM operations to choose from.
>   *	@state:	PM transition of the system being carried out.
> @@ -166,7 +166,7 @@ static int pm_op(struct device *dev, str
>  }
>  
>  /**
> - *	pm_noirq_op - execute the PM operation appropiate for given PM event
> + *	pm_noirq_op - execute the PM operation appropriate for given PM event
>   *	@dev:	Device.
>   *	@ops:	PM operations to choose from.
>   *	@state: PM transition of the system being carried out.
> @@ -363,6 +363,13 @@ static int resume_device(struct device *
>  			goto End;
>  	}
>  
> +	if (dev->type && dev->type->pm) {
> +		pm_dev_dbg(dev, state, "type ");
> +		error = pm_op(dev, dev->type->pm, state);
> +		if (error)
> +			goto End;
> +	}
> +
>  	if (dev->class) {
>  		if (dev->class->pm) {
>  			pm_dev_dbg(dev, state, "class ");
> @@ -596,6 +603,13 @@ static int suspend_device(struct device 
>  			goto End;
>  	}
>  
> +	if (dev->type && dev->type->pm) {
> +		pm_dev_dbg(dev, state, "type ");
> +		error = pm_op(dev, dev->type->pm, state);
> +		if (error)
> +			goto End;
> +	}
> +
>  	if (dev->bus) {
>  		if (dev->bus->pm) {
>  			pm_dev_dbg(dev, state, "");
> 
> 
> 
