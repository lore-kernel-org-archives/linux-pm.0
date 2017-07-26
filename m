From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] USB: hcd: Mark secondary HCD as dead if the primary one
 died
Date: Wed, 26 Jul 2017 10:21:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1707261021380.1965-100000@iolanthe.rowland.org>
References: <2812577.lIftRZubdO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2812577.lIftRZubdO@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux USB <linux-usb@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 Jul 2017, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make usb_hc_died() clear the HCD_FLAG_RH_RUNNING flag for the shared
> HCD and set HCD_FLAG_DEAD for it, in analogy with what is done for
> the primary one.
> 
> Among other thigs, this prevents check_root_hub_suspended() from
> returning -EBUSY for dead HCDs which helps to work around system
> suspend issues in some situations.
> 
> This actually fixes occasional suspend failures on one of my test
> machines.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/usb/core/hcd.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-pm/drivers/usb/core/hcd.c
> ===================================================================
> --- linux-pm.orig/drivers/usb/core/hcd.c
> +++ linux-pm/drivers/usb/core/hcd.c
> @@ -2485,6 +2485,8 @@ void usb_hc_died (struct usb_hcd *hcd)
>  	}
>  	if (usb_hcd_is_primary_hcd(hcd) && hcd->shared_hcd) {
>  		hcd = hcd->shared_hcd;
> +		clear_bit(HCD_FLAG_RH_RUNNING, &hcd->flags);
> +		set_bit(HCD_FLAG_DEAD, &hcd->flags);
>  		if (hcd->rh_registered) {
>  			clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);

Acked-by: Alan Stern <stern@rowland.harvard.edu>
