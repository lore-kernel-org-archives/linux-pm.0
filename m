From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 08/27] PM / Domains: Support IRQ safe PM domains
Date: Thu, 14 Jan 2016 11:33:16 -0700
Message-ID: <20160114183316.GB1651@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-9-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFoKpgURMYoepWH0TNK1=bFp4uyQCHUSnPiXmLxC7BNyRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoKpgURMYoepWH0TNK1=bFp4uyQCHUSnPiXmLxC7BNyRA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 14 2016 at 07:42 -0700, Ulf Hansson wrote:
>On 17 November 2015 at 23:37, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Generic Power Domains currently support turning on/off only in process
>> context. This prevents the usage of PM domains for domains that could be
>> powered on/off in a context where IRQs are disabled. Many such domains
>> exist today and do not get powered off, when the IRQ safe devices in
>> that domain are powered off, because of this limitation.
>>
>> However, not all domains can operate in IRQ safe contexts. Genpd
>> therefore, has to support both cases where the domain may or may not
>> operate in IRQ safe contexts. Configuring genpd to use an appropriate
>> lock for that domain, would allow domains that have IRQ safe devices to
>> runtime suspend and resume, in atomic context.
>>
>> To achieve domain specific locking, set the domain's ->flag to
>> GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that genpd
>> should use a spinlock instead of a mutex for locking the domain. Locking
>> is abstracted through genpd_lock() and genpd_unlock() functions that use
>> the flag to determine the appropriate lock to be used for that domain.
>
>Please add a newline here.
>
Sure.
>> Domains that have lower latency to suspend and resume and can operate
>
>I believe I get the point, as we must not keep IRQs disabled for too
>long. Perhaps that can be a bit clarified?
>
>> with IRQs disabled may now be able to save power, when the component
>> devices and sub-domains are idle at runtime.
>>
>> The restriction this imposes on the domain hierarchy is that sub-domains
>> and all devices in the IRQ safe domain's hierarchy also have to be IRQ
>> safe, so that we dont try to lock a mutex, while holding a spinlock.
>
>Isn't it the opposite as you described here?
>
>So holding a mutex while taking a spinlock should be okay, but not the
>other way around.
>
That's exactly what I describe. We *dont* try to lock a mutex while
holding a spinlock.

>Regarding power on:
>*)
>If we get a request to power on the master, its spinlock will be
>taken, but its subdomain isn't touched.
>
True. Powering on a domain should not power on its subdomains. So we are
good here.

>**)
>If we get a request to power on the subdomain, it will first try to
>power its master. That means, first we take the mutex of the
>subdomain, then as the master is IRQ safe we will take its spinlock.
>We power on the master, releases its spinlock, continues to power on
>the subdomain and then releases its mutex.
>
The implied assumption in having a subdomain that is IRQ-safe while the
parent domain is non-IRQ-safe is that the parent is never powered on/off
in the context of the subdomain, it is assumed always ON.

>Regarding power off:
>*)
>Trying to power off the master will fail unless the atomic "sd_count"
>is tested for zero. In that execution path, its subdomain isn't
>touched.
>
True for IRQ-safe parents with IRQ-safe subdomains as well as non-IRQ
safe parents with IRQ-safe subdomains.

>**)
>Trying to power off a subdomain, thus executing in non-atomic context,
>starts by taking its mutex then continue doing the power off things.
>When completed, the sd_count for its master will be decreased and then
>we schedule a power off work for it, to allow it to be powered off at
>some point later. Even if we wouldn't schedule a work, and instead
>tried to power off the master within the same context it should be
>safe to take a spinlock.
>
This is true as well for IRQ-safe subdomains that are attached to
IRQ-safe parents. But if the parent is not IRQ-safe then the domains is
left powered ON.

>I haven't thought about the IRQ safe devices yet, but I guess similar
>applies to them.
>
The same rules apply to IRQ safe devices.

Here is an excerpt from pm_genpd_runtime_resume -

/* If power.irq_safe, the PM domain is never powered off. */
if (dev->power.irq_safe) {
        timed = false;
	goto out;
}

>> Non-IRQ safe domains may continue to have devices and sub-domains that
>> may or may not be IRQ safe.
>
>According the my comments above, no I don't think so. Non-IRQ safe
>domains can't have subdomains that is IRQ safe.
>
Here is a summary of the combinations as I understand. Correct me if I
am wrong, please.

*) Non-IRQ safe parent + IRQ-safe subdomain
   Attach subdomain:
   	- parent mutex held and subdomain spinlocked.
   Power-on:
	- subdomain assumes parent is always ON or powered on before the
	subdomain is powered ON.
   Power-off:
   	- parent is not powered off even if the subdomain was the last
	active domain.

**) IRQ-safe parent + IRQ-safe subdomain
    Attach subdomain:
    	- parent spinlock held and subdomain spinlocked.
    Power-on:
	- subdomain may power on the parent.
    Power-off:
    	- last active sub-domain will power off the parent in the same
	  context.

***) IRQ-safe parent + non-IRQ-safe subdomain
    Attach subdomain:
   	- parent spinlock held and subdomain **cannot** be mutex locked.
    Power-on:
	- subdomain may power on the parent.
    Power-off:
    	- last active subdomain will be able to power off the domain

Except for the last case, we can support the others in addition to 
the currently available, with the restriction that 

- IRQ-safe parents can only have IRQ-safe subdomains and devices

- Non-IRQ safe parents may have both IRQ-safe and non-IRQ-safe
  subdomains and devices and the assumption that
	-- IRQ-safe subdomains and devices will not bother to power
	on/off their non-IRQ-safe parent.

>Before I continue to review the code, let's align on the above first
>as I think it's important we get this right first. :-)
>
Absolutely.

Thank you for your review. Was expecting this detail a review of the
concept from you :)

Thanks,
Lina
