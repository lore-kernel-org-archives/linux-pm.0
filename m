Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208656;
	b=Y93hpiqGrKfg5VpzJSIOUhDiAxg2yr4i/xq78WZ/LNZT0D9UfdpsS4iXzigcycKf8U6y
	 g8eLg46Tmq4eTcSjOCBYXd6nOn3eQdaBdW4CzePxB7OldhIykzDyGuQVbh8cwJDESozlO
	 4oOHT2gwfCrkEJvcrI6hI1ugmR1kQwK21gk1QwioqXZZ6dmAnQ+sxam09irqwT3Ccudxp
	 EdCjBlBsr5b6UYRKpSJI1EPKNfwAP+AK9sS/rzfF5DqDiU9ctujVNkn6fmcwwM0YLZsiq
	 1k41YtmYvfvaqXvB1OyMOyELueJ6Gxde3fI7MXH0eRvu9X4X37X/l36vF8qMDMRc3Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/ru90xVBZjCMBPo2fB3f1IAfOuYApIQHIQMbSW86U10=;
	b=ECxpMnwpAgRYBAviX2MlgEIEvTdWwKPu6E8tiSGXZyukm2bjIE/DiRUuk7T+ZJnhv8vb
	 C/Cf78ZTq9GKBEJRDxkvU3jMGkfwTzHRV5KgpXwgZDF5nbpi0ydLGu/D8D+JRRRzFl8lc
	 cGRvBa+ZUyTe998keeADEQuyZVFNAkIlOIO3ms1pfrNdzM/29nYT6HEBjI5R/x2uSAsfl
	 BMXpjEdtUgf71/atD0JcxYfb5t1d38MjBxkFjZjLrb7M2Ie2e4DEC6++R88G/a9BkqNEi
	 /QvkCxgyctlPtt6wQuvG5vk7nucISMqECTANT65CJCS2F1lw38WjOMlrYTpW00mhemQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kvVYYa+w;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C10606A6A8
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 21:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C10606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kvVYYa+w
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-385c497bf94so2365381eec.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 13:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795208650; x=1795813450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ru90xVBZjCMBPo2fB3f1IAfOuYApIQHIQMbSW86U10=;
        b=kvVYYa+wGiRqLorEksb3vNg0gwo00Pw/Fj3Sksx0nbA3HOarN+jSyJFKiLd2rByFn+
         FzD//flDqApuZsRKkd6wRjS7cKmG1kOxZ4BnkaWyMTydvdN9qbtfVUS99PWKavYx8KrB
         Gd8fuhh/xUXPfuFo/8Uj/qEoxUduZlyVblup4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208650; x=1795813450;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ru90xVBZjCMBPo2fB3f1IAfOuYApIQHIQMbSW86U10=;
        b=WAS0mFhqyzy6X0Vyg/ciP0j6wqfvHf5UUurzsV3SMnTNEU6jOy+pbrG30TP/FDYc/w
         BwEf6pP/4YApKuIxJEuxpeS43mXhekkuO9PQtcOcZMTshyzELOfSk2MkDyUlJXAU9qEp
         7v6im0pK/h/2bcKBjsQruipqFNP9xSfdmqsUVpAvPsdJYvyXY2Lznk2qg25LYsLo5eqH
         uo6hG1Ts/RLyVchkrRLC4QDpIpGK+/oxWPEigdX2hC8GVWH7cEZhYV6lazM09VG9+2sZ
         MBsQH+l+4r0a2HU0wF2YgpLGluf/YjpBytC0ybgi71qtlRDX0+Dv2Uuw19do1nmgMgeo
         BpWQ==
X-Gm-Message-State: APuU4Z/DE782MEWCJNecQkifXzpdWkIksmIwwHbldkzvuiYWkGR1YaaU
	ggOa1240nyDWyjEfN4WHC0MI1ID1XLbAfEfB/i2I43o0YydUV4wI7bWP7ZJpE/43Aw==
X-Gm-Gg: AZFdTZdL+h98+gqidEmOfXCu6nbEe621WgFER3bY3MB1dG0Gy311JZEyk+dDKViWag8
	Swa0YXvi+YTSx5f2JCuyVv0QbnUy94Yq1NyHTKzX+virG/z7v+b1jw3TXXQBanmGoNRg/zPOLnq
	YW/dxpz0Ko/w6ZbOrEqTlYuaEYYMevKCkiX33Rg8pgLTljhboAzLSsnXZUHQMi3ASarMe3S1ZqE
	P8IGaRS5Lc8bVrwDWObicycPFbrAv//+PQ4Mes+PM3B8CUVahLf1EcaUMV5krr9eUO52anyyG9x
	fcGYvq/ok9Iynfk+TqWxaLCKgyI0Hgbkn2ejM7KIydloQBEIy24wsWS1VTDBc5OxOOiH4V04I6G
	esBzPRTBSYEc1LStW23zwex0bH0bV1z3Tq9JGqGUV5K9Im+Q44GRv70hFDOw1Nfd2H9hLGrmfHB
	DegiDaFH7nvxtyxSqPKaW4XpHM9LEA44cFzPP8QwgF/IqCR/56EVlbPVhS5355tMz1MIgXwE4jQ
	TNcCXXjRcztpKhzdjed4UmCw52dSxz2lXboY2qmwqnOeKLeAz/UxnjNN3if9AYXQvofwudMJuns
	YJ9JQttKuDOFTrSjnXN7ccbY82Yb4T0/s165KBwzay9olkK1UgnmNWoLmXlRW6Jh9k5Q
X-Received: by 2002:a05:7300:f283:b0:386:9854:9123 with SMTP id 5a478bee46e88-3869854950emr974034eec.14.1795208649910;
        Fri, 20 Nov 2026 13:04:09 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ec05:65c0:ffe0:d597])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3856456e6c6sm9889709eec.2.2026.11.20.13.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 13:04:09 -0800 (PST)
Date: Fri, 20 Nov 2026 13:04:07 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: Re: [PATCH v1 3/4] PM: runtime: Let devices suspend after an
 attempted resume
Message-ID: <awC1xx1Wi2BYo5rb@google.com>
References: <1978814.tdWV9SEqCh@rafael.j.wysocki>
 <10954171.nUPlyArG6x@rafael.j.wysocki>
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
In-Reply-To: <10954171.nUPlyArG6x@rafael.j.wysocki>

On Thu, Nov 19, 2026 at 09:17:51PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> On a successful runtime resume of a device, rpm_idle() is called by
> rpm_resume(), but only if the runtime PM status of the device was not
> RPM_ACTIVE when rpm_resume() was called, which is inconsistent.  For
> instance, if the given device uses autosuspend, an autosuspend timer
> will most likely be started for it after it has been actually resumed
> by rpm_resume(), which will not happen if it is already active when it
> is passed to that function.  This may lead to observable differences in
> behavior going forward.
> 
> Address it by rearranging rpm_resume() to call rpm_idle() also if the
> device has been active to start with.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 5a0b4600c244..1a3b32e299d8 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -794,7 +794,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>   * suspending (deferred_resume) or wait for it to finish.  If the RPM_ASYNC
>   * flag is set then queue a resume request; otherwise run the
>   * ->runtime_resume() callback directly.  Queue an idle notification for the
> - * device if the resume succeeded.
> + * device if the resume succeeded or the device's runtime PM status was
> + * RPM_ACTIVE to start with.
>   *
>   * This function must be called under dev->power.lock with interrupts disabled.
>   */
> @@ -840,7 +841,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
>  		 */
>  		pm_runtime_mark_last_busy(dev);
>  		retval = 1;
> -		goto out;
> +		goto success;
>  	}
>  
>  	if (dev->power.runtime_status == RPM_RESUMING ||
> @@ -971,8 +972,11 @@ static int rpm_resume(struct device *dev, int rpmflags)
>  	}
>  	wake_up_all(&dev->power.wait_queue);
>  
> -	if (retval >= 0)
> -		rpm_idle(dev, RPM_ASYNC);
> +	if (retval < 0)
> +		goto out;
> +
> +success:
> +	rpm_idle(dev, RPM_ASYNC);

It's super common for rpm_resume() to be called with a non-zero
usage_count (e.g., all pm_runtime_get*(), pm_runtime_forbid()). Do we
really want them all to turn into rpm_idle() (and predictably fail)? For
one, it adds a lot more trace_event noise.

Maybe we could check RPM_GET_PUT before doing this? Or check
usage_count? I wouldn't want to go too far on re-implementing all the
rpm_idle() pre-conditions though...

Also: I'm not quite sure what's *really* expected here, but drivers like
drivers/net/ethernet/intel/e1000e/netdev.c (no autosuspend; they use
.runtime_idle() to re-implement autosuspend, more or less) might see a
change in behavior. For example, see its watchdog, which does:

	/* Cancel scheduled suspend requests. */
	pm_runtime_resume(netdev->dev.parent);

For cases where the device stayed RPM_ACTIVE but usage_count == 0 (very
common, I think), this does indeed cancel any pending suspend timers,
but then it immediately queues another idle request. (That idle request
will end up failing anyway, so no functional issue. It just means the
comments are a little confusing.)

Do we really want that? Or maybe these drivers are just outliers, and
should be rewritten anyway.

Brian

>  
>  out:
>  	if (parent && !dev->power.irq_safe) {
> -- 
> 2.51.0
> 
> 
> 
> 
