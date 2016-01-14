From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 08/27] PM / Domains: Support IRQ safe PM domains
Date: Thu, 14 Jan 2016 15:42:23 +0100
Message-ID: <CAPDyKFoKpgURMYoepWH0TNK1=bFp4uyQCHUSnPiXmLxC7BNyRA@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
	<1447799871-56374-9-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33509 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbcANOmY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2016 09:42:24 -0500
Received: by mail-qk0-f174.google.com with SMTP id p186so222554092qke.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2016 06:42:24 -0800 (PST)
In-Reply-To: <1447799871-56374-9-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 17 November 2015 at 23:37, Lina Iyer <lina.iyer@linaro.org> wrote:
> Generic Power Domains currently support turning on/off only in process
> context. This prevents the usage of PM domains for domains that could be
> powered on/off in a context where IRQs are disabled. Many such domains
> exist today and do not get powered off, when the IRQ safe devices in
> that domain are powered off, because of this limitation.
>
> However, not all domains can operate in IRQ safe contexts. Genpd
> therefore, has to support both cases where the domain may or may not
> operate in IRQ safe contexts. Configuring genpd to use an appropriate
> lock for that domain, would allow domains that have IRQ safe devices to
> runtime suspend and resume, in atomic context.
>
> To achieve domain specific locking, set the domain's ->flag to
> GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that genpd
> should use a spinlock instead of a mutex for locking the domain. Locking
> is abstracted through genpd_lock() and genpd_unlock() functions that use
> the flag to determine the appropriate lock to be used for that domain.

Please add a newline here.

> Domains that have lower latency to suspend and resume and can operate

I believe I get the point, as we must not keep IRQs disabled for too
long. Perhaps that can be a bit clarified?

> with IRQs disabled may now be able to save power, when the component
> devices and sub-domains are idle at runtime.
>
> The restriction this imposes on the domain hierarchy is that sub-domains
> and all devices in the IRQ safe domain's hierarchy also have to be IRQ
> safe, so that we dont try to lock a mutex, while holding a spinlock.

Isn't it the opposite as you described here?

So holding a mutex while taking a spinlock should be okay, but not the
other way around.

Regarding power on:
*)
If we get a request to power on the master, its spinlock will be
taken, but its subdomain isn't touched.

**)
If we get a request to power on the subdomain, it will first try to
power its master. That means, first we take the mutex of the
subdomain, then as the master is IRQ safe we will take its spinlock.
We power on the master, releases its spinlock, continues to power on
the subdomain and then releases its mutex.

Regarding power off:
*)
Trying to power off the master will fail unless the atomic "sd_count"
is tested for zero. In that execution path, its subdomain isn't
touched.

**)
Trying to power off a subdomain, thus executing in non-atomic context,
starts by taking its mutex then continue doing the power off things.
When completed, the sd_count for its master will be decreased and then
we schedule a power off work for it, to allow it to be powered off at
some point later. Even if we wouldn't schedule a work, and instead
tried to power off the master within the same context it should be
safe to take a spinlock.

I haven't thought about the IRQ safe devices yet, but I guess similar
applies to them.

> Non-IRQ safe domains may continue to have devices and sub-domains that
> may or may not be IRQ safe.

According the my comments above, no I don't think so. Non-IRQ safe
domains can't have subdomains that is IRQ safe.

Before I continue to review the code, let's align on the above first
as I think it's important we get this right first. :-)

[...]

Kind regards
Uffe
