From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v5 1/2] PM / sleep: Go direct_complete if driver has no
 callbacks
Date: Tue, 29 Sep 2015 10:39:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509291036520.1511-100000@iolanthe.rowland.org>
References: <1443529760-17612-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52607 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751426AbbI2OjV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2015 10:39:21 -0400
In-Reply-To: <1443529760-17612-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, 29 Sep 2015, Tomeu Vizoso wrote:

> If a suitable prepare callback cannot be found for a given device and
> its driver has no PM callbacks at all, assume that it can go direct to
> complete when the system goes to sleep.
> 
> The reason for this is that there's lots of devices in a system that do
> no PM at all and there's no reason for them to prevent their ancestors
> to do direct_complete if they can support it.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

> +void device_check_pm_callbacks(struct device *dev)
> +{
> +	dev->power.no_pm_callbacks =
> +		(!dev->bus || pm_ops_is_empty(dev->bus->pm)) &&
> +		(!dev->class || pm_ops_is_empty(dev->class->pm)) &&
> +		(!dev->type || pm_ops_is_empty(dev->type->pm)) &&
> +		(!dev->pm_domain || pm_ops_is_empty(&dev->pm_domain->ops)) &&
> +		(!dev->driver || pm_ops_is_empty(dev->driver->pm));
> +}

One fairly minor point: You should lock dev->power.lock before setting
this bitfield.  This is because bitfields are not SMP-safe.

Alan Stern

