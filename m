From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] PM / sleep: Let devices force direct_complete
Date: Thu, 14 May 2015 14:12:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505141409060.1107-100000@iolanthe.rowland.org>
References: <1431610673-16801-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33162 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751978AbbENSNB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 14:13:01 -0400
In-Reply-To: <1431610673-16801-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

On Thu, 14 May 2015, Tomeu Vizoso wrote:

> Introduce a new per-device flag power.force_direct_complete that will
> instruct the PM core to let that device remain in runtime suspend when
> the system goes into a sleep power state, regardless of the PM state of
> any of its descendants.
> 
> This is needed because otherwise it would be needed to get dozens of
> drivers to implement the prepare() callback and be runtime PM active
> even if they don't have a 1-to-1 relationship with a piece of HW.
> 
> This only applies to devices that aren't wakeup-capable, as those would
> need to setup their IRQs as wakeup-capable in their prepare() callbacks.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

There's one little problem in this...

> @@ -1605,9 +1607,13 @@ static int device_prepare(struct device *dev, pm_message_t state)
>  	 * will do the same thing with all of its descendants".  This only
>  	 * applies to suspend transitions, however.
>  	 */
> -	spin_lock_irq(&dev->power.lock);
> -	dev->power.direct_complete = ret > 0 && state.event == PM_EVENT_SUSPEND;
> -	spin_unlock_irq(&dev->power.lock);
> +	if (state.event == PM_EVENT_SUSPEND) {
> +		spin_lock_irq(&dev->power.lock);
> +		dev->power.direct_complete = ret > 0 ||
> +			(dev->power.force_direct_complete &&
> +			 !device_can_wakeup(dev));
> +		spin_unlock_irq(&dev->power.lock);
> +	}

When state.event is not PM_EVENT_SUSPEND, this fails to set 
dev->power.direct_complete to 0.  Sticking closer to the original code 
arrangement would help.

Aside from that small issue:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern


