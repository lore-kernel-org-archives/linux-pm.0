From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC/RFT][PATCH v2 6/7] PM / runtime: Use device links
Date: Mon, 12 Sep 2016 11:47:58 +0200
Message-ID: <20160912094758.GA517@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <5200011.6uCldMmN4m@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:35343 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757647AbcILJrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2016 05:47:45 -0400
Content-Disposition: inline
In-Reply-To: <5200011.6uCldMmN4m@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Thu, Sep 08, 2016 at 11:30:26PM +0200, Rafael J. Wysocki wrote:
> Modify the runtime PM framework to use device links to ensure that
> supplier devices will not be suspended if any of their consumer
> devices are active.

I think it's inconsistent to runtime resume/suspend suppliers in
__rpm_callback() whereas the parent is treated in rpm_suspend()
and rpm_resume().

Instead I'd suggest to amend struct dev_pm_ops with:
	atomic_t		consumer_count;

Amend rpm_check_suspend_allowed() with:
	else if (atomic_read(&dev->power.consumer_count) > 0)
		retval = -EBUSY;

Amend rpm_suspend(), rpm_resume() and __pm_runtime_set_status()
to decrement/increment consumer_count where we're doing the same
for the parent's child_count, and runtime resume/idle suppliers
as necessary.


> The idea is to reference count suppliers on the consumer's resume
> and drop references to them on its suspend.  The information on
> whether or not the supplier has been reference counted by the
> consumer's (runtime) resume is stored in a new field (rpm_active)
> in the link object for each link.

So the rpm_active variable indicates if the runtime ref on the
supplier is currently held. I don't see why this is needed.
If DEVICE_LINK_PM_RUNTIME is not set, we never acquire a runtime
ref in the first place. If it's set, a ref is acquired upon
resuming the consumer and released upon suspending it. So whether
the ref is held is discernable from the consumer's runtime PM state.
Why do you need to track this in a separate variable?


> @@ -718,8 +718,12 @@ enum device_link_status {
>   * Device link flags.
>   *
>   * PERSISTENT: Do not delete the link on consumer device driver unbind.
> + * PM_RUNTIME: If set, the runtime PM framework will use this link.
> + * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
>   */
>  #define DEVICE_LINK_PERSISTENT	(1 << 0)
> +#define DEVICE_LINK_PM_RUNTIME	(1 << 1)
> +#define DEVICE_LINK_RPM_ACTIVE	(1 << 2)

I don't understand the need for DEVICE_LINK_RPM_ACTIVE: If the
consumer is in runtime resumed state when the link is added and
DEVICE_LINK_PM_RUNTIME is set, then of course the supplier needs
to be in runtime resumed state as well. Conversely if the consumer
is in runtime suspended state, the supplier need not be in runtime
resumed state either. So the value of the flag can be derived from
the consumer's runtime PM state. Why do we need the flag at all?

Thanks,

Lukas
