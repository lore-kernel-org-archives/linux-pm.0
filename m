Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208377;
	b=xmxTIDiFZnLIdHzhmqQAY0hn3p1WUoPOP2uvAtqLFREFlT2aMWFU3em0PJFPsIQSSV4+
	 1w0LantSV4Nsr6QBJV3Nl9IlBSJLrBEtU8fxu1RTkYJXqQqHIX9qX5xmhX7qwrmwrk8XT
	 97y4FAao8fudFA0Asa/aIgWVA6BJt+VVgFiGYhX4/PXdJLQ/PMd9gx80W7dnPVIO0otLy
	 CSPOSqUMcpg5XIbO2ugFOf+2B+zTb4jD5+GwNS2pnplJkfB+lnFld7GG8bR72myr0Zykg
	 lDoCxO8oTRMfFewMNvIxNXDkFIHK4n6Fjb88vmkxhPJey/kvD1weYj8UpqIH284Mn4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xqx2feA+7Jx9teaQWOZ3qzuVX2GPDumqnHf9czn6DrU=;
	b=2Z36Mf1ax9x7eYRgVNAdUROfxxp4knTXY2SSV1jVI0JzJuEQT7ik3AS07Cxz+H47KxRp
	 3rY3XUrrX/i0WqFPMrerstymNpEhxFCKa6HPc3hhq6jN8USIz593N6SXChX1AUgcTZ7am
	 pi61potAE5/jJYmV3JMiPINu3b4U5C9411ytspFdjnj48VuZRYsOYKfzz7LxnW2WfEi7x
	 ORQsAOB39/IVqTczF5nR6Fd4H8dfwsrSh6xa8WcyREUmVHpyTnQGcARETIxr8JiVxRPyB
	 zcFBqz0ieQIa6sm5fng6LzS+Ia11gzK+d4lgJTEwz7IjVN0mrjRMN034oO1Z7IMwAJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=I7ZfJKXR;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3318606A6AE
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 20:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3318606A6AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=I7ZfJKXR
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38644aedba1so1245101eec.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 12:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795208376; x=1795813176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xqx2feA+7Jx9teaQWOZ3qzuVX2GPDumqnHf9czn6DrU=;
        b=I7ZfJKXRmNVlJ9f45wfQuPqbHGcxys5Sad7qlE5QFwz27TBK8rKAwZbR/3Y/u0cKMM
         8oRM/7tu/DHuGWqaRCNuOZxncMv+ihveLkiliuWztSqosDkqa2A2qIxuODbYXebtexis
         DjrGqMaGNnxT6F9WBmh6hDLNauqSP1Xowf2LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208376; x=1795813176;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xqx2feA+7Jx9teaQWOZ3qzuVX2GPDumqnHf9czn6DrU=;
        b=wuMx3QAqgKPnMpYMaB3eXSdtFUyrhMAg6e9Mr1Ms+t7xll3ziw0gUQ3YMk2Z5w6/rG
         9VDjw7VRYFckKq6RGepHmVAPJD7D1YO8Ub30M8UU9iq85HF8vd8vr/rNGCYqsdXGk8Xx
         vvFaJAU+Ax64xo/DXImL7QCdFTyh2zOkuQ8isHfiD37KMdaz/I3QtT7+YT7jW9XAsJmg
         lNmdq/nwp/wyfzwoNADSox2+rorv+i4iLEzlLGPYNBw+jewM9VnlzFZBz1B5zz4oeuon
         FEge9yGN0nVme7+fHO2gjIU71+Zbh/tgvNAnDWFhqOD488uBua86o50N48WarxjOlt++
         HlPQ==
X-Gm-Message-State: APuU4Z/MfAlpDXIi4uNKDYOwYL1NAYs816vfbsCk3OUZ6zYV8WCIU+jA
	cFFrlgebY6/fG1SMyA4PUWQtLiQJrx5mxAww+Fj/d9sFyN7iWp+OW6pIficFcxTUFA==
X-Gm-Gg: AYBFou1OwVV1iMldiFISJ3aTed034R9kwCFWseavVi40r0exDrhnd2OAGsu8LsVRf3b
	J+YN7MUaDlEWnr36o5aXmDOaDmWFmAfEH/WP0I0vNN0TnDBOxl7OXtvOu7Yk6mpxQAXrc7aSIzV
	zWD08T+VCSpIQW7d2DwcD6CrnWgjSS6WBKwU3MW4aZRCPDMSBUBpJOkAOn3PpaDh7Zxas75wXBn
	iTvItzkS+8bJDifKmJr/GMLY3IXyJryTc4ffHoG51x5WTlzwhi95Okj7gzQ40GzxsNij/jP/YTC
	jT9ZIW2K3SZioXa+kxN0AGLu5cUUxy5CbSHPNQauu8iM/H8pT9zfNBY/UY7r+3IUVuac0x+IV3g
	btI6nz6xo5KgdqRPzcCkFV4Q0eZNLrXlFEOvJMOu1fWSfgyEyyTeVyJDZgRzlXw8TgOsxy4WbG8
	ZoKoOVzIyxKZqVtq5V6FZoBA/Edn6cZDlbOpLlkCw8O8KbzWdiF/psOccLGSxR8TuqkFZU5oy3J
	hRxwiBSgDhfFHWPdg6Y02BMFZglUpuLpNYiYON8PNXef8Og+X6gXcZGi3cGtga9H1U4LF35ewfO
	gXALt8uL/cYBub23uznmHMLb6uh8epPBP3h/iXdfLJapG/sIWEnSVQYsDuAnFMyC0rSD
X-Received: by 2002:a05:693c:829b:10b0:376:feb:2df3 with SMTP id 5a478bee46e88-3856f85236cmr4832996eec.20.1795208375921;
        Fri, 20 Nov 2026 12:59:35 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ec05:65c0:ffe0:d597])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-385677c349csm11386565eec.22.2026.11.20.12.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 12:59:35 -0800 (PST)
Date: Fri, 20 Nov 2026 12:59:33 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: Re: [PATCH v1 1/4] PM: runtime: Update last_busy in all rpm_idle()
 paths
Message-ID: <awC0tcqgq2KvCyxO@google.com>
References: <1978814.tdWV9SEqCh@rafael.j.wysocki>
 <3076901.e9J7NaK4W3@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3076901.e9J7NaK4W3@rafael.j.wysocki>

On Thu, Nov 19, 2026 at 09:16:30PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The changelog of commit 26236a3e8803 ("PM: runtime: Update last_busy
> before calling rpm_suspend() in rpm_idle()") stated that rpm_idle() only
> needed to update last_busy when it was about to call rpm_suspend(), but
> that is incorrect.  There are still cases in which a device may be
> autosuspended earlier than expected.
> 
> The first one is when pm_runtime_put() is called while a leftover
> autosuspend timer is running.  Then, dropping the device's runtime PM
> usage counter to 0 allows rpm_suspend() triggered by the timer to
> suspend the device immediately before __pm_runtime_idle() is able to
> grab the spinlock.  Prevent it from occurring by adding a last_busy
> update before the rpm_drop_usage_count() call in __pm_runtime_idle().

Do consumer->supplier and child->parent refcount drops have the same
problem? e.g., in pm_runtime_release_supplier() and rpm_suspend() /
parent->power.child_count decrement?

> Another one is when rpm_idle() returns without calling rpm_suspend(),
> for example because the callback has returned a transient error, while
> an autosuspend timer is running.  The timer may then suspend the device
> without respecting the autosuspend delay.  Moreover, the timer may fire
> while the callback is running and it will not see the new last_busy
> value in that case.  To address these cases, move the existing
> pm_runtime_mark_last_busy() call in rpm_idle() before the first return
> value check.

I suppose we don't care about: "what if .runtime_idle() is slow?" --
that makes a small delta in the expiration time.

> In both places mentioned above add comments explaining the rationale for
> updating last_busy.
> 
> Fixes: 26236a3e8803 ("PM: runtime: Update last_busy before calling rpm_suspend() in rpm_idle()")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Commit 26236a3e8803 is present in linux-next.

Semi-unrelated cleanup: pm_runtime_put_sync() some stale kerneldoc now,
saying "this does not update the last access time".

> ---
>  drivers/base/power/runtime.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 0b15c718c1bb..02e7b4953c38 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -518,6 +518,14 @@ static int rpm_idle(struct device *dev, int rpmflags)
>  	else if (dev->power.idle_notification)
>  		retval = -EINPROGRESS;
>  
> +	/*
> +	 * Update last_busy to defer autosuspend by the full autosuspend delay.
> +	 * Since an autosuspend timer may be running and the new last_busy value
> +	 * needs to be seen by it, update last_busy before returning an error or
> +	 * dropping the spinlock and allowing the timer function to grab it.
> +	 */
> +	pm_runtime_mark_last_busy(dev);
> +
>  	if (retval)
>  		goto out;
>  
> @@ -563,7 +571,6 @@ static int rpm_idle(struct device *dev, int rpmflags)
>  	if (retval)
>  		return retval;
>  
> -	pm_runtime_mark_last_busy(dev);
>  	return rpm_suspend(dev, rpmflags | RPM_AUTO);
>  }
>  
> @@ -1132,6 +1139,13 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
>  	int retval;
>  
>  	if (rpmflags & RPM_GET_PUT) {
> +		/*
> +		 * Once the usage counter drops to 0, a leftover autosuspend
> +		 * timer may fire before the spinlock below is acquired.  Update
> +		 * last_busy first so it does not find the expiration time in
> +		 * the past and suspend the device immediately.
> +		 */
> +		pm_runtime_mark_last_busy(dev);
>  		retval = rpm_drop_usage_count(dev);

This is somewhat of a pre-existing issue (e.g., in
pm_runtime_put_autosuspend()), but weakly ordered architectures don't
really enforce the dependencies you want.

rpm_drop_usage_count() uses an atomic decrement, which has a full
barrier. But this is supposed to influence the rpm_suspend() behavior of
rpm_check_suspend_allowed() (atomic_read) + READ_ONCE(last_busy), which
includes only a conditional dependency and no barrier.

https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html

  "Control dependencies can order prior loads against later dependent
  stores, however, they do not order prior loads against later dependent
  loads. (Use memory_order_consume or memory_order_acquire if you
  require this behavior.)"

So, rpm_check_suspend_allowed() should probably use
atomic_read_acquire(&dev->power.usage_count).

(This is probably an extremely narrow, practically impossible issue.)

Brian

>  		if (retval < 0) {
>  			return retval;
> -- 
> 2.51.0
> 
> 
> 
> 
