Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125416;
	b=cOzyZydGG5Lox39sl0BsgpyT7P6u3jdWOwn1CZZG1H79ItRjGUUUyXA+QL7si8YRyMer
	 KnCssUbPo9Gu9jBSZZYZEqn4xpUuOONGdLCV02jMdLM0fURUBjdZujemp/o9v8g1VIUVX
	 txtfs1bjVdlQQ4IDoxxqGk4AIW2EppSN5LHhoTFOcs2fFGpAZaML+hUmv0B5bs7cE3Rmf
	 kqx6C/MOBP1hbWxLG5Tu/V+QAJI5vyCvoERvozsuncfFpS+tQZXmIEQZbIq/skuiNZuYn
	 Ik+1wY9NXJNrT833Cd4weVeQ/eMtDP7h9Y6fB7mdMiInD9WlE2t5GKps119m6/rXtVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oiRjZFoXRzRw0gpEvBGfOWMwsbRXgKI6jIlRNPp4PPI=;
	b=HxAblQEYwXFno4Pe/9Ecpmk+tRYFAPgLX058ZVFYHxRtjOOUHSXnlbimLbtdkWNUC+0h
	 n9MipQRM+Ed5jlKegcIbhmoq5bQDWN5pitqUewLSGBh6FFnVlu8GNr5yF6HEt2X0Wblbt
	 Qw+bsU7ogH2VFtcQ1bRqQHmyKu0fMwO9ktVoJirscluSKPNPaVqWqxto57KeloPNti6fs
	 GG7uRzNfsyvVcIF/VlOf6JSGJRBu3wRAmclaeRM30Y/rrdS2RNpgIgTQtiTaGU54ouwxI
	 LiAJ3P15xqGBmcXAv+dWlL79xvmoTHRCqpjF4kVMTYNHd1O9seTB97NPUlLBrrxq9Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=L1R7hwnk;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48875606A32C
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 21:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48875606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=L1R7hwnk
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a2af4c8d00so483794c88.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795125414; x=1795730214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oiRjZFoXRzRw0gpEvBGfOWMwsbRXgKI6jIlRNPp4PPI=;
        b=L1R7hwnkf7vfoVXDR74uG48MMHL+ho5RguSCAfgj6A3GXFz1Xby4x7wBR2KYwJL347
         DW6PbEI+fnajayqwuvG/fmvUHgiMasrKsBUe0q3qojACsmEK15lPCV/1SDEcLp+gOboB
         d0aqjmmWhh7XXkhLpw5PWftXOxFS9RpVGhhIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795125414; x=1795730214;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oiRjZFoXRzRw0gpEvBGfOWMwsbRXgKI6jIlRNPp4PPI=;
        b=fJ6bmQVuGVQmPn4EkZiIMRT23IOj38jSDhr+t1uE0tp69bRjQdsXI9gfpX3QB6w1zD
         BbA6Kw9LU3Y1MJVTQAbcrUBLqqfGwIp/1eDd0TooO/z0DmQ0CzmDJytsQ8QipMz5ha1E
         Ml3A0QoCUUz49atS2dDhmrWuetprY4aEZ2SiQS3BiHlvwlf2yBuaf5wkIK24aMaxSto2
         GdaAVISIDY1vbJmNRs+hhDvaI4/Z5vJYHLFc0AajNHEV1DBce19sCEveHjng3B3/oRcg
         09hn1ag1k/70pjNZwsRAWlr3WIpFMQZvBqgAU8bclDxE0Hw6Pl6MX3nXrg2KvwHJgm+N
         LOJA==
X-Forwarded-Encrypted: i=1; AL+hErHJyRQve90KaQ+UL3VYuTlLRBbT7aHI9cCkG6i2R3dSWp807uruaNXecUwv99s2EmK3/EZZjwkwyA==@vger.kernel.org
X-Gm-Message-State: APuU4Z836CuwGMjz9lXPEYLyx31YY4iUJAIfiOvh+CKVgufUE5I9CymR
	Nrb4c3HEUQb9iCHlzACrfPGammrRd2SuD3cvpZCEo/dbTvpqauujAAjX+kq1tVrD7+Chrapi/Yx
	5Bbo=
X-Gm-Gg: AYBFou0v1NizS6lwOxXsGtNasoqce0DIsV+6eVzO/xHwyVhut0QIjwDmlN0WozsOTRK
	lJu16aiBVCmXCs4/xXMt3dO+KZLUdWZHC2uX2A+uR9LKeyVf3N4Rek0LP5GBZYVClhUCGq6dO0o
	EZulZW/QkPF0Etl9kq+jc25iBzK1OoiX62xtKRe/VDQNzWODJ+I0Qh8Iyj4RtZEf3fvnFsjNqKc
	4YBlFNTaIciKPNoEriu5xFOyJB0KAzW/1ZeeRalf2kTve93oKP95553VGcRAy2E3fx/Ta/VkgDq
	mxsA+7/uznDk8GT4wcbWR5goVxQmp+B07UfrTMwh87dc14FZSO2k9G61pUpYIuq/han6KZl7icd
	NhTPYdAP5EHZDEU0tOoSz8M+viWritgvnSPb3+ro+a9v0zD3LD6VOJK3zwwZbQeWBlvKTwkVzT1
	5FDaMQN4aJgzetgF6U3C9D4L+gXLIiUmeyiKsCKGLYiGTBB4xAA+d67zHbjYA7GZiRIuqLuvpJt
	u0cJgw7NENql/q9iSfzht1+1vesjMQ82hUpqCrawlqhGKmeN8boGQveU22shhifMq5s145tX3Tc
	O+3SGvtjKSQrqcrboc+GRTAXTfPhpHA+WQJUrQgNmSnUM/TcTx+UNsTH+nHvF95KPYcc
X-Received: by 2002:a05:701b:4555:20b0:1a2:2da2:b278 with SMTP id a92af1059eb24-1b556894b6emr982950c88.14.1795125414255;
        Thu, 19 Nov 2026 13:56:54 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:bdc0:a95f:45fc:7172])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b5568592adsm1652441c88.15.2026.11.19.13.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 13:56:53 -0800 (PST)
Date: Thu, 19 Nov 2026 13:56:52 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: TAD: Improve runtime PM handling during driver
 removal
Message-ID: <av9wpJqw6D1m_izi@google.com>
References: <6052490.DvuYhMxLoT@rafael.j.wysocki>
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
In-Reply-To: <6052490.DvuYhMxLoT@rafael.j.wysocki>

On Thu, Nov 19, 2026 at 08:58:26PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In acpi_tad_remove(), instead of attempting a runtime suspend of the
> device which may be blocked by user space via "power/control", change
> the device's runtime PM status to "suspended" after disabling runtime
> PM for it to potentially unblock the runtime suspend of its parent and
> suppliers (if any).
> 
> Since pm_runtime_suspend() is not called in acpi_tad_remove() any more,
> the latter need not drop the runtime PM reference to the device held by
> it, so make it use guard()() instead of scoped_guard() for acquiring
> that reference and reduce the indentation level.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpi_tad.c |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -850,19 +850,21 @@ static void acpi_tad_remove(void *data)
>  
>  	device_init_wakeup(dev, false);
>  
> -	scoped_guard(pm_runtime_noresume, dev) {
> -		if (dd->capabilities & ACPI_TAD_AC_WAKE) {
> -			acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
> -			acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
> -		}
> -		if (dd->capabilities & ACPI_TAD_DC_WAKE) {
> -			acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
> -			acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
> -		}
> +	guard(pm_runtime_noresume)(dev);
> +
> +	if (dd->capabilities & ACPI_TAD_AC_WAKE) {
> +		acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
> +		acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
> +	}
> +	if (dd->capabilities & ACPI_TAD_DC_WAKE) {
> +		acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
> +		acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
>  	}
>  
> -	pm_runtime_suspend(dev);
>  	pm_runtime_disable(dev);
> +	/* Allow the parent and suppliers (if any) to suspend. */
> +	pm_runtime_set_suspended(dev);
> +	/* No need to power down, the PM domain detach will take care of it. */

Personally, I think it's a little odd to require coding patterns like
this (and comments, because it's admittedly subtle!) that assume
.runtime_suspend() is a no-op. But it works for simple drivers like
this, where the real work is done by others.

Anyway, that's just a general observation, and more of a framework
thing. This patch looks fine:

Reviewed-by: Brian Norris <briannorris@chromium.org>

BTW, should we drop pm_runtime_suspend() from probe() too? It's
susceptible to the same sort of problem, although it's a benign one
there. It's also a bit redundant, since there will be a post-probe()
idle request anyway.

Brian

>  }
>  
>  static int acpi_tad_probe(struct platform_device *pdev)
> 
> 
> 
