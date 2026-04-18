Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FA8287E;
	Sat, 18 Apr 2026 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776511430; cv=none; b=eGks2qdWWywYrXbzlZwNzjrrSX3lSjWPzzZ4bjLSWzPriKJgDv9q2p3c+5oajWvlr64d5uM5+hv6Equ01k0ReZ/wSGuOo4OigZUQ03QRSBR0tsWqdtdOsAWmwa1j9dsEe6w+rBJTSYSGzueWlnOjGnjt9lQPuvd+TCHzXygBXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776511430; c=relaxed/simple;
	bh=qmkxHMeyJSV68nZDal6E0M3LUkI/ZBWkIqKBNMIJZlA=;
	h=Content-Type:Date:Message-Id:To:From:Subject:Cc:Mime-Version:
	 References:In-Reply-To; b=i6qW9Gri6tXNjJuFuSrBEI6yjg66LP0Pjf88/2Vwg1oQ4NkNS2/JP4LOkFGQTmX18zti5fIKDDjaOi39dUp1HqL9W+cZBvyjsSptXAYp3lergxS8EVxLwssPuwdugFYsq9z/opUlNw97BKaa7rDRZLgM/3PQdusrFmqb8aHEklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxH4t3QQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxH4t3QQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207C9C2BCB4;
	Sat, 18 Apr 2026 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776511430;
	bh=qmkxHMeyJSV68nZDal6E0M3LUkI/ZBWkIqKBNMIJZlA=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=lxH4t3QQpK+6qWcBgGgkxbDwi1u1XBquksvhEonYSB99cgcu9K/u1KpEzl6elEh1C
	 wwoct9m8iiWix6MIRx7TgoUcEG/gyQwUSf8DMC944YmvgsloPM0x+8bDyxM9AKRzV9
	 Qswk8N0DWApztIltYY64xlL1Rm6HvNEwUJXFQfH75kZ/D+asFazR0sOqoDKLlvpGvc
	 mL7FX6yrTQYWpl92Wt8hPQqCydjW4h6ymBGp005PpYt2ubboI5M5FZ9eLNltIk4TpM
	 j9cpbCytcvwAA00RjKifKzAN5gSlKr6c0z/rrmtcRTTuZ9HSIjEkrIKxCw3OdIeRRM
	 x86wlj9ADterg==
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Apr 2026 13:23:44 +0200
Message-Id: <DHW8QPU1VU1F.3P6PH69HLFBYC@kernel.org>
To: "Ulf Hansson" <ulf.hansson@linaro.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/9] driver core: Enable suppliers to implement fine
 grained sync_state support
Cc: "Saravana Kannan" <saravanak@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-pm@vger.kernel.org>, "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Cristian Marussi" <cristian.marussi@arm.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Abel Vesa" <abel.vesa@oss.qualcomm.com>, "Peng
 Fan" <peng.fan@oss.nxp.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Maulik Shah"
 <maulik.shah@oss.qualcomm.com>, "Konrad Dybcio" <konradybcio@kernel.org>,
 "Thierry Reding" <thierry.reding@gmail.com>, "Jonathan Hunter"
 <jonathanh@nvidia.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 <driver-core@lists.linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
 <20260410104058.83748-2-ulf.hansson@linaro.org>
In-Reply-To: <20260410104058.83748-2-ulf.hansson@linaro.org>

On Fri Apr 10, 2026 at 12:40 PM CEST, Ulf Hansson wrote:
> The common sync_state support isn't fine grained enough for some types of
> suppliers, like power domains for example. Especially when a supplier
> provides multiple independent power domains, each with their own set of
> consumers. In these cases we need to wait for all consumers for all the
> provided power domains before invoking the supplier's ->sync_state().
>
> To allow a more fine grained sync_state support to be implemented on per
> supplier's driver basis, let's add a new optional callback. As soon as
> there is an update worth to consider in regards to managing sync_state fo=
r
> a supplier device, __device_links_queue_sync_state() invokes the callback=
.
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/core.c           | 7 ++++++-
>  include/linux/device/driver.h | 7 +++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 09b98f02f559..4085a011d8ca 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1106,7 +1106,9 @@ int device_links_check_suppliers(struct device *dev=
)
>   * Queues a device for a sync_state() callback when the device links wri=
te lock
>   * isn't held. This allows the sync_state() execution flow to use device=
 links
>   * APIs.  The caller must ensure this function is called with
> - * device_links_write_lock() held.
> + * device_links_write_lock() held.  Note, if the optional queue_sync_sta=
te()
> + * callback has been assigned too, it gets called for every update to al=
lowing a

s/allowing/allow/

> + * more fine grained support to be implemented on per supplier basis.
>   *
>   * This function does a get_device() to make sure the device is not free=
d while
>   * on this list.
> @@ -1126,6 +1128,9 @@ static void __device_links_queue_sync_state(struct =
device *dev,
>  	if (dev->state_synced)
>  		return;
> =20
> +	if (dev->driver && dev->driver->queue_sync_state)
> +		dev->driver->queue_sync_state(dev);

This seems to be called without the device lock being held, which seems to =
allow
the queue_sync_state() callback to execute concurrently with remove(). This
opens the door for all kinds of UAF conditions in drivers.

This also made me aware that the above dev_has_sync_state() is probably bro=
ken,
as it also performs the following check without the device lock being held.

	dev->driver && dev->driver->sync_state

I think nothing prevents dev->driver to become NULL concurrently; in this c=
ase
READ_ONCE() should be sufficient though as it doesn't execute the callback.

I will send a patch for this.

> +
>  	list_for_each_entry(link, &dev->links.consumers, s_node) {
>  		if (!device_link_test(link, DL_FLAG_MANAGED))
>  			continue;
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.=
h
> index bbc67ec513ed..bc9ae1cbe03c 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -68,6 +68,12 @@ enum probe_type {
>   *		be called at late_initcall_sync level. If the device has
>   *		consumers that are never bound to a driver, this function
>   *		will never get called until they do.
> + * @queue_sync_state: Similar to the ->sync_state() callback, but called=
 to
> + *		allow syncing device state to software state in a more fine
> + *		grained way. It is called when there is an updated state that
> + *		may be worth to consider for any of the consumers linked to
> + *		this device. If implemented, the ->sync_state() callback is
> + *		required too.

What happens if this is not the case? Maybe worth to check and warn about t=
his
in driver_register().

>   * @remove:	Called when the device is removed from the system to
>   *		unbind a device from this driver.
>   * @shutdown:	Called at shut-down time to quiesce the device.
> @@ -110,6 +116,7 @@ struct device_driver {
> =20
>  	int (*probe) (struct device *dev);
>  	void (*sync_state)(struct device *dev);
> +	void (*queue_sync_state)(struct device *dev);
>  	int (*remove) (struct device *dev);
>  	void (*shutdown) (struct device *dev);
>  	int (*suspend) (struct device *dev, pm_message_t state);
> --=20
> 2.43.0

