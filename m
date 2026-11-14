Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617970;
	b=4dZQOVd+dp8U554ARiY8xrqgU53MW+tVOAmCLSaHnESxRQejmBRTAM90u77sJFRDWebo
	 G2kVQyNkB4yDqPOUtTvigM7GHyOLHA8MGaeej6wFhb3cFtsQcIJIVXPeYmdvMIfQ8Wy8I
	 EBxqorXGOgfmlN06sZn5aYxdFBcmlquenvAHw4ujUlkxPaqTKhZ7aTKUu2UrFlc+S3YeX
	 w0WeuqxI9H+08NS6bUDQ6FscA4FZ8LkwIjs9iAH8AEeSZtGdIecn22pvy9WyzdWpoOeGz
	 4hL84voXE4BP+LiwiUmMW+pCpSIoxqfIr4mlUA6nS/IziW38Pm/ZtA6UEbiIIhXrKgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QMsZLVog74iOpWaQpOPOS8T9N6kbs3KpXXjJz5qYWLA=;
	b=etzG2fwmnIFbQoK8KVP3rS/ykmBBeC9NpoQ/4vjR+fWiNsBIOFLOMRGDl7ypBsTw6olC
	 leoJZMu6iGujSTxTdT8iXhQcU0YmaYzIS/RsnVyTNt88C8MRnmE/UZWMN/kgqdZTiUhGf
	 h9h7fbcg4P+/TmQj+ixo0PRTtfs/mMGPK47wOIAnjxz0/+5/JZeg+yEr5B+ElxzoMJ1f+
	 7AdrYdgZSfS7zvExHOg3jLTKwCXXtyzwq1iKaBxR0t88YFmtYEqOws6TecEtTTYrK79kY
	 HEkUM5pWHjPz4aTqurA0bxNFq8sCbfVsifBEuVNSO0cw1aPiW7KS0jWBDjov1w0Limg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=W8nsx5AV;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F291606A336
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 00:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F291606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=W8nsx5AV
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so2198711c88.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 16:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794617968; x=1795222768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QMsZLVog74iOpWaQpOPOS8T9N6kbs3KpXXjJz5qYWLA=;
        b=W8nsx5AVQBffPoy+k16BhVjMEDDodl8fDpI8OkPIzbFye9cL6ccgCyI3Nx41dY28Hi
         kK6cQbOcB/AGp8zSyFVENsFpbDkOWK/tC89mGKH+SNXgXoPuvmZPphX58rhOXgdU++H1
         pGQRbCPlPjp/bh3su4U7G57oiVVBzrvGBd0T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794617968; x=1795222768;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QMsZLVog74iOpWaQpOPOS8T9N6kbs3KpXXjJz5qYWLA=;
        b=CyDGawN39OfchSKt51p4E/l9caBg4CWZ9YSXvkAiaihcTQNHIH6uWBWUkH7X2jl3zv
         IObZKbVc5w56M4ObvvcCyXLmGLAa9+ys9C4AjkXdGkcHPNlGfPAj2XMgr7wbzcJBym7P
         f2a06O3vXAGpr0rQBJV9JBeg5M/h6EchurBK2nHn18aSEd6wNLy+LQyQZQiet9mLWuOB
         KEMd2ryH2PYL8QqTACoE8DGp7kXag2tJbDaWWzqTP0q8VE/eVEhLUcKAVMJP+bCcHe4/
         /Q5CIgp9rKo39YQvteNreVsABW/N8iSapEUG/ajCq3kLwVfMUylpPqu9QGrzV42S6XKH
         6g+Q==
X-Gm-Message-State: APuU4Z+D5hIvr4gSi0jwZ4rY1XhQXI5bPQUD/waRzXvsnq5xVdO8CMR1
	B0l9GQ6rX4uDXVbOVV65d7KeTF/XeSIkaM6TH5fDT7Db6gOcOeITk5PSEtFJDCvntA==
X-Gm-Gg: AYBFou0cFX4zpvshg9cQOLSaHgMo2mi5EZH0lhEtUbWy1Dndin7gJCSRdS2SdCeJYDn
	TTNe9yra5mjt9BRaMFeBK4RpR826JCRzI6FDoSwPutDgguJNzsII3DFWmZsXmHmf1P3X1PaNL9o
	nAMKNR1l3Zo/p5PItegFbgBOhVTOg517cMAZlGSN4lGWlPF3A4Jh7B9Z7gaZKqb/lYvUvEKdvlu
	Ey9+2x/1X8yOXNJqcgjYZzsSfXcRZRgVqgUI7Xo6q4IFJojw11GZQ1vKNzyWjqf7yJdcdGEeTVw
	hMXwOaLOpRu2S4t1rojnMNHBNGg42eKMFwrZZLv5J0f6Y5hHn/B7P+xZmSMLrbIDA7RVRSmb4ZP
	EzSZ9SL30dE0UwD8IqEzh5Vy+NIkKDbXprNP2kqftn4s3km3TgQT2z1JXXGrFOk9Fz072FAWJMp
	Cuj5cJja2nCbzzyEl8/LI8GRwMPbU/6GtUOyTvBtFx5lkQdqiek/nVSPaieCncAgvcSGt7Fjrbx
	/NosjwPRJUoxm9dc9YLwYPJWwSX7kSJb/lAHSrELRe5ZNilo1pLi4yDaQ3rpfb0njEJa68jioM8
	RRiz8RHsCcFpF1Okx0TCdau7+bbEEHdL4/6zcqwcaEWWugThnygQWOQETyWWVfjuOyzo
X-Received: by 2002:a05:7022:7f0f:b0:1b3:b3de:9231 with SMTP id a92af1059eb24-1b50309823dmr3952411c88.14.1794617968357;
        Fri, 13 Nov 2026 16:59:28 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:c0e6:2ee8:7d51:ad79])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b505b5bf76sm7931235c88.10.2026.11.13.16.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 16:59:26 -0800 (PST)
Date: Fri, 13 Nov 2026 16:59:25 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: Re: [PATCH v1] PM: runtime: Update last_busy before calling
 rpm_suspend() in rpm_idle()
Message-ID: <aveybY5Z9OWQYkRS@google.com>
References: <4789427.LvFx2qVVIh@rafael.j.wysocki>
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
In-Reply-To: <4789427.LvFx2qVVIh@rafael.j.wysocki>

On Fri, Nov 13, 2026 at 02:27:23PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> When rpm_idle() is about to call rpm_suspend(), there are no reasons
> preventing the device from being suspended, but if the device uses an
> autosuspend delay, it needs to be taken into account.
> 
> For this purpose, rpm_idle() adds RPM_AUTO to the flags passed to
> rpm_suspend(), but doing that alone is insufficient because the point
> in time from which the autosuspend delay is counted may be too early.
> 
> For example, if the device has children (or consumers) and the last
> of them goes into runtime suspend, the parent may now become eligible
> for suspending, but it may not be worthwhile for it to suspend until
> a certain time later.
> 
> Quoting Alan Stern [1]:
> 
>  Let's say the last remaining active child goes into runtime suspend at
>  time T.  Let's also say that the parent expects none of the children
>  will need to resume until time T + D.  Is D sufficiently large to make
>  it worthwhile for the parent to suspend and then resume?  If not, the
>  parent should remain active.  If yes, the parent should autosuspend --
>  and the length of time the parent should wait before autosuspending is
>  on the order of the value of D (let's call it D*) that corresponds to
>  this crossover point.  Thus the parent's autosuspend delay should be
>  set to D*, or something close to it, in order to achieve both
>  objectives.
> 
> Moreover, if the parent's autosuspend delay is set to D*, it should be
> counted from time T at which the last child has suspended, but that does
> not happen because the parent's last_busy timestamp is not updated at
> time T.  That leads to undesirable parent suspends occurring between
> child suspend and resume [2].
> 
> To address this issue, make rpm_idle() update the last_busy timestamp
> of the device when it is about to call rpm_suspend() which most often
> is right after the device's last child (or consumer) has gone into
> runtime suspend.

Is it worthwhile to note (or at least hint at) how many other things
change along with this? e.g., how pm_runtime_allow() (and therefore
auto > control/power), all non-autosuspend pm_runtime_put() variants,
etc, also extend the autosuspend timer? I think we agreed these are
acceptable effects, and likely even desireable, but I'd say these are
fairly major changes.

In any case, the change looks good to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>

I meant to make time to test this out a bit more, but ran out; maybe
next week.

Thanks,
Brian

> Updating the last_busy timestamp when rpm_idle() returns an error
> without calling rpm_suspend() is not useful because the device is then
> going to remain active for an unknown amount of time and its autosuspend
> delay needs to take effect later.
> 
> Link: https://lore.kernel.org/linux-pm/fc43eb13-816b-4cd0-9711-848fdab605ef@rowland.harvard.edu/ [1]
> Link: https://lore.kernel.org/linux-pm/CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com/ [2]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -560,7 +560,11 @@ static int rpm_idle(struct device *dev,
>  
>   out:
>  	trace_rpm_return_int(dev, _THIS_IP_, retval);
> -	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
> +	if (retval)
> +		return retval;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	return rpm_suspend(dev, rpmflags | RPM_AUTO);
>  }
>  
>  /**
> 
> 
> 
