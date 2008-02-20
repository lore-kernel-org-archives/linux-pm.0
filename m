From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Remove unbalanced mutex_unlock() from dpm_resume()
Date: Wed, 20 Feb 2008 11:13:39 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802201112010.4828-100000@iolanthe.rowland.org>
References: <200802200201.42543.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200802200201.42543.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, 20 Feb 2008, Rafael J. Wysocki wrote:

> Hi Greg,
> 
> Please consider taking the following fix for 2.6.25.

Don't just consider it!  :-)  It's a real bug fix.

> Thanks,
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Remove an unnecessary unlocking of dpm_list_mtx in the error path
> in drivers/base/power/main.c:dpm_suspend() .
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/base/power/main.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> Index: linux-2.6/drivers/base/power/main.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/main.c
> +++ linux-2.6/drivers/base/power/main.c
> @@ -479,7 +479,6 @@ static int dpm_suspend(pm_message_t stat
>  			mutex_lock(&dpm_list_mtx);
>  			if (list_empty(&dev->power.entry))
>  				list_add(&dev->power.entry, &dpm_locked);
> -			mutex_unlock(&dpm_list_mtx);
>  			break;
>  		}
>  		mutex_lock(&dpm_list_mtx);

Acked-by: Alan Stern <stern@rowland.harvard.edu>

