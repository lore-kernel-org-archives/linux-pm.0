From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 4/5] PM / runtime: Use device links
Date: Sun, 18 Dec 2016 15:01:22 +0100
Message-ID: <20161218140122.GA13141@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <11468990.WB1J8sxXpS@vostro.rjw.lan>
 <5653461.FkScaTIbLn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:55119 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbcLROBR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Dec 2016 09:01:17 -0500
Content-Disposition: inline
In-Reply-To: <5653461.FkScaTIbLn@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

Hi Rafael,

spotted what looks like a bug in the device links runtime PM code:

When resuming a device, __rpm_callback() calls rpm_get_suppliers(dev):

> +			retval = rpm_get_suppliers(dev);
> +			if (retval)
> +				goto fail;


This will walk the list of suppliers and call pm_runtime_get_sync()
for each of them:

> +static int rpm_get_suppliers(struct device *dev)
> +{
> +	struct device_link *link;
> +
> +	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
> +		int retval;
[...]
> +		retval = pm_runtime_get_sync(link->supplier);
> +		if (retval < 0) {
> +			pm_runtime_put_noidle(link->supplier);
> +			return retval;


If pm_runtime_get_sync() failed, e.g. because runtime PM is disabled
on a supplier, the function will put the reference of the failed
supplier and return.

Back in __rpm_callback() we jump to the fail mark, where we call
rpm_put_suppliers().

> + fail:
> +			rpm_put_suppliers(dev);
> +
> +			device_links_read_unlock(idx);


This walks the list of suppliers and releases a ref for each of them:

> +static void rpm_put_suppliers(struct device *dev)
> +{
> +	struct device_link *link;
> +
> +	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> +		if (link->rpm_active &&
> +		    READ_ONCE(link->status) != DL_STATE_SUPPLIER_UNBIND) {
> +			pm_runtime_put(link->supplier);
> +			link->rpm_active = false;
> +		}
> +}


This looks wrong:  We've already put a ref on the failed supplier, so here
we're putting another one.  And if there are further suppliers in the list
following the failed one, we'll decrement their refcount even though we've
never incremented it.

Thanks,

Lukas
