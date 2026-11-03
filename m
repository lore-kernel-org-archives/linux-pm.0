Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747847;
	b=alswaotQ0XHlGdBCzFVp4A8frdJdDYxQsXNgrCgEnXCGbgY1BJQaPRexY2LgnZ5qanri
	 4hdMzd5WSboCCcZzWeiL7ttLrKyebX6eIdLs6Jn/62suQSdVRF/+uOg+jAmEmiNsbwYyA
	 1KU/Zd3pGSdjPZScUCM7t+1oCGu6cio6YkGWjIftf4xd+ELbPUmBTK2nWty9JutuZ8gA0
	 MrJKeU3hQtY2wUOiyXhGsU2f1f/8UGOW5nJPXByAPuU2/YbSKxhYXAgM3ZxKXHKW961RB
	 p6pgoOwDmEyqeSjHbg7wymxjFJpPCrlRFM3lq7akZZa/ceiZWrD4oLpF/zifo5QqFBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747847;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WiTMTsRPGskxo4SFpC31J1n5lh//wJRfzBl0hp4GkJM=;
	b=k1vthmD8++rgmwXCB2WWgiU1ACTPquUrGjokp4uznq617UREOA2t76NwEui9d5e13GMz
	 Aawv32RRoDmcr/ueEk4rOO3lnMQqxGtYnzhaFrKeS8e+lCE0KGT3Nwa3YURgiE7JxBTIW
	 TtCsCXYVImc2Q+KoRC66fQfrkwLPahvrbUDt6KJrPrDO4y9iZS66KGjoUOgQ9TBNcDQaM
	 B1rskq1or7Roakshirb3ZgS0HGgv9z9xUk3JcuEkBhPfoAc0KjkbseXhtLOejh5B2G2Wc
	 WhzYm1weRJeA+EXYw/5zkiJqkSj5qp3GW1zvoF9jbp9YZVc8Bt+YUfAbc+2MJl1RwBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2Eq7OwE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2F606A328;
	Tue,  3 Nov 2026 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2Eq7OwE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B381F00A15;
	Tue,  3 Nov 2026 23:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793747846;
	bh=WiTMTsRPGskxo4SFpC31J1n5lh//wJRfzBl0hp4GkJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X2Eq7OwEaXWp5ATyXbU00N5a+DT6/xNgj6VtVt8FslVC6URsz2+eF36CqfuOn4zMz
	 0xbgpmgXAAA0uwvCw+F5BjUsSO1sA68Iw3Ub2RM2vIey8lUztdl90L6akvE5qSp10o
	 Owt+XkvPmm0+NtWCP+TFBaipkpQ8fOn38lRhlQgVhtvpBsv4aRmpEHWqi/azC0q/IZ
	 z5lzCR3AUZXPzAMjf2BpZ9InDntWWXhKWWufMSoGLUJ0iFS8lToHe0cRjNbyIx/PGE
	 CHlagNY9JfiTa7e0SP2/j93J2alg7Z5nOJ9u3iI2x7dmxgH/gydifCBVMQ2PFuuBFJ
	 ge8qCITZ2ERtg==
Date: Tue, 3 Nov 2026 23:17:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Fabrice Gasnier
 <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 3/5] PM: runtime: Propagate last_busy from dependent
 to dependency
Message-ID: <20261103231719.486a18de@jic23-hlaptop>
In-Reply-To: <20261103141442.v2.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
References: <20261103221717.3840215-1-briannorris@chromium.org>
	<20261103141442.v2.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 14:14:41 -0800
Brian Norris <briannorris@chromium.org> wrote:

> When a child device suspends, it does not update the last_busy timestamp
> for its parent. If that parent configured autosuspend and didn't
> otherwise maintain its last_busy timestamp, it may now be immediately
> eligible to suspend. This is probably not expected -- the parent should
> wait for its autosuspend delay before suspending.

So reading this again - I wonder if this text is describing the
expected behaviour.

If the child is also using autosupend then, in extreme case, that time
might be longer than the autosuspend time of the parent.
If so it seems odd the parent still waits. So most expected to me
would be if the parent were to suspend it's autosuspend time after
the parent or child was last used for something that indicate a
desire not to suspend (that shouldn't include actions the child
did whilst suspending).

Maybe there isn't a sensible way to deal with this and what you have here
is the best we can do.  Note that this is just commenting on this
statement in the commit description.  From what follows I think
this is just a commit description thing rather than functional.


> 
> The effect of this behavior is that a parent device may suspend sooner
> than its autosuspend delay, simply because its usage was accounted by
> its children, and not by direct references to the parent device.

Sooner is indeed bad.

> 
> This was noticed in several cases, and some have implemented
> workarounds, such as in commit c537d3457542 ("iio: adc: stm32-adc: fix
> runtime autosuspend delay when slow polling"). At the same time, Ulf
> suggested these problems "should be solved in the runtime PM core" [1].
> 
> Instead of working around the problem in drivers, we propagate last_busy
> timestamps from a dependent device to its dependencies any time it may
> allow a dependency to suspend -- i.e., when releasing a refcount for its
> parent or suppliers. We take care to only propagate the timestamp if it
> is larger than the existing busy timestamp.

So this sounds fine but I don't think aligns with that first paragraph.

> 
> Note that this works best if the dependent device is using autosuspend
> (and therefore updates its last_busy timestamps appropriately), but even
> for a non-autosuspend child, this is still somewhat useful --
> non-autosuspend devices still automatically update their last_busy every
> time they resume.

Can we set the last busy on the suspend of child devices that aren't
suspending as a result of autosuspend timeout but for other reasons?
(may be some fiddly corners!)

> 
> Link: https://lore.kernel.org/all/CAPDyKFp=KTf8=zGBSzPYqhjnZpY8xwvjCeM1e-WTKT1QLSxaDA@mail.gmail.com/ [1]
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Cc: Ulf Hansson <ulfh@kernel.org>
> 
> Changes in v2:
>  * Update comments to explain when/why rpm_propagate_last_busy()
>    performs the update
> 
>  drivers/base/power/runtime.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 2a117d6a776f..dd306cbabcd3 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -318,6 +318,22 @@ static int rpm_get_suppliers(struct device *dev)
>  	return 0;
>  }
>  
> +/*
> + * Propagate last_busy timestamp from one device to another, typically when a
> + * device (@dev) releases a reference count on a dependency (@target) and might
> + * allow it to (auto)suspend. This can, for example, prevent overactive suspend
> + * when a dependency's usage is primarily driven by one of its dependents.
> + */
> +static void rpm_propagate_last_busy(struct device *dev, struct device *target)
> +{
> +	s64 busy = atomic64_read(&dev->power.last_busy);
> +	s64 target_busy = atomic64_read(&target->power.last_busy);
> +
> +	while (target_busy < busy)
> +		if (atomic64_try_cmpxchg(&target->power.last_busy, &target_busy, busy))
> +			return;
> +}
> +
>  /**
>   * pm_runtime_release_supplier - Drop references to device link's supplier.
>   * @link: Target device link.
> @@ -348,6 +364,7 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
>  		if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
>  			continue;
>  
> +		rpm_propagate_last_busy(dev, link->supplier);
>  		pm_runtime_release_supplier(link);
>  		if (try_to_suspend)
>  			pm_request_idle(link->supplier);
> @@ -710,6 +727,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>  
>  	if (dev->parent) {
>  		parent = dev->parent;
> +		if (!parent->power.ignore_children)
> +			rpm_propagate_last_busy(dev, parent);
>  		atomic_add_unless(&parent->power.child_count, -1, 0);
>  	}
>  	wake_up_all(&dev->power.wait_queue);
> @@ -1368,8 +1387,10 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
>  		goto out_set;
>  
>  	if (status == RPM_SUSPENDED) {
> -		atomic_add_unless(&parent->power.child_count, -1, 0);
>  		notify_parent = !parent->power.ignore_children;
> +		if (notify_parent)
> +			rpm_propagate_last_busy(dev, parent);
> +		atomic_add_unless(&parent->power.child_count, -1, 0);
>  	} else {
>  		spin_lock_nested(&parent->power.lock, SINGLE_DEPTH_NESTING);
>  

