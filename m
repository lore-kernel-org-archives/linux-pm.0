From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 08/27] PM / Domains: Support IRQ safe PM domains
Date: Fri, 15 Jan 2016 09:55:38 +0100
Message-ID: <CAPDyKFpj0Gv=5hVwZWjmgmumHPriuYk+LLVBwjEeW9Jfj8p5Kw@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
	<1447799871-56374-9-git-send-email-lina.iyer@linaro.org>
	<CAPDyKFoKpgURMYoepWH0TNK1=bFp4uyQCHUSnPiXmLxC7BNyRA@mail.gmail.com>
	<20160114183316.GB1651@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34462 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbcAOIzj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2016 03:55:39 -0500
Received: by mail-yk0-f169.google.com with SMTP id a85so458181423ykb.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Jan 2016 00:55:39 -0800 (PST)
In-Reply-To: <20160114183316.GB1651@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

[...]

>>>
>>> The restriction this imposes on the domain hierarchy is that sub-domains
>>> and all devices in the IRQ safe domain's hierarchy also have to be IRQ
>>> safe, so that we dont try to lock a mutex, while holding a spinlock.
>>
>>
>> Isn't it the opposite as you described here?
>>
>> So holding a mutex while taking a spinlock should be okay, but not the
>> other way around.
>>
> That's exactly what I describe. We *dont* try to lock a mutex while
> holding a spinlock.

Apologize, I wasn't referring to the mutex/spinlock as that part you
state correctly.

I was reading the change log as: "*if* the parent domain is IRQ safe
everything below it (devices and subdomains) also needs to be IRQ
safe". Which I assume doesn't have to be the case.

Then below I was describing an example of an IRQ safe parent with a
non-IRQ safe subdomain, which I think should be an okay configuration.

>
>> Regarding power on:
>> *)
>> If we get a request to power on the master, its spinlock will be
>> taken, but its subdomain isn't touched.
>>
> True. Powering on a domain should not power on its subdomains. So we are
> good here.
>
>> **)
>> If we get a request to power on the subdomain, it will first try to
>> power its master. That means, first we take the mutex of the
>> subdomain, then as the master is IRQ safe we will take its spinlock.
>> We power on the master, releases its spinlock, continues to power on
>> the subdomain and then releases its mutex.
>>
> The implied assumption in having a subdomain that is IRQ-safe while the
> parent domain is non-IRQ-safe is that the parent is never powered on/off
> in the context of the subdomain, it is assumed always ON.

Yes, that follows how gendp deals with IRQ safe devices. Although, I
consider that as workaround and not a solution.

In the long run, I think IRQ safe devices should belong to IRQ safe domains.

Unless you have a specific need to apply the similar workaround for
parents and subdomains, I am suggesting that genpd shouldn't allow
such configurations.

[...]

>
>>> Non-IRQ safe domains may continue to have devices and sub-domains that
>>> may or may not be IRQ safe.
>>
>>
>> According the my comments above, no I don't think so. Non-IRQ safe
>> domains can't have subdomains that is IRQ safe.
>>
> Here is a summary of the combinations as I understand. Correct me if I
> am wrong, please.

Nice summary, it good that we discuss all possible scenarios!

>
> *) Non-IRQ safe parent + IRQ-safe subdomain

Let's name this case 1.

>   Attach subdomain:
>         - parent mutex held and subdomain spinlocked.
>   Power-on:
>         - subdomain assumes parent is always ON or powered on before the
>         subdomain is powered ON.

As stated above, what do you think of *not* dealing with this case as
I think it's not a solution but a workaround!

>   Power-off:
>         - parent is not powered off even if the subdomain was the last
>         active domain.
>
> **) IRQ-safe parent + IRQ-safe subdomain

Let's name this case 2.

>    Attach subdomain:
>         - parent spinlock held and subdomain spinlocked.
>    Power-on:
>         - subdomain may power on the parent.
>    Power-off:
>         - last active sub-domain will power off the parent in the same
>           context.

>From a genpd locking point of view, there should be no reason to power
off in same context. We should be able to deal with this via a
scheduled work for this case as well, right!?

Although, I realize that it's very useful to power off in the same
context to minimize latencies in the full blown CPU Cluster Power
Management solution.
Perhaps a separate genpd configuration flag could be added to enable
this method, as I imagine that not *all* IRQ safe domains wants to use
it.

What do you think?

>
> ***) IRQ-safe parent + non-IRQ-safe subdomain

Let's name this case 3.

>    Attach subdomain:
>         - parent spinlock held and subdomain **cannot** be mutex locked.

First, attaching shouldn't occur from atomic context.

Second, the important part is that we pick the locks in same order as
elsewhere in genpd, and of course we must not pick a mutex while
holding a spinlock.

In all cases when adding subdomains, we should start by fetching the
subdomains lock *then* the lock for the parent. The current genpd code
doesn't do that and additionally it uses nested locks.
I am going to send a patch the changes this behaviour, as I think it's
wrong and may cause deadlocks!

Following this approach means that case 1 can't be supported, as that
would mean holding a spinlock while fetching a mutex.

>    Power-on:
>         - subdomain may power on the parent.
>    Power-off:
>         - last active subdomain will be able to power off the domain
>
> Except for the last case, we can support the others in addition to the
> currently available, with the restriction that
> - IRQ-safe parents can only have IRQ-safe subdomains and devices
>
> - Non-IRQ safe parents may have both IRQ-safe and non-IRQ-safe
>  subdomains and devices and the assumption that
>         -- IRQ-safe subdomains and devices will not bother to power
>         on/off their non-IRQ-safe parent.
>

I think case 2 and case 3 should be okay to support, but I am really
questioning case 1.

Thoughts?

Kind regards
Uffe
