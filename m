From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH RFC 0/3] PM / Domains: Generic PM domains for cpus
Date: Wed, 10 Jun 2015 10:24:51 -0700
Message-ID: <7hwpzbo4rg.fsf@deeprootsystems.com>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33719 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539AbbFJRYz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 13:24:55 -0400
Received: by pdjn11 with SMTP id n11so42136446pdj.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2015 10:24:54 -0700 (PDT)
In-Reply-To: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Thu, 4 Jun 2015 16:29:03 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, mathieu.poirier@linaro.org, galak@codeaurora.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

Lina Iyer <lina.iyer@linaro.org> writes:

> This is an attempt to provide a generic PM domain for cpus, so as to allow the
> cpu domain to be powered off, when all the cpus are in power down state during
> cpuidle. 

You don't use the word "cluster" here, but it might be helpful to
summarize this as using a genpd to model a cluster.  A cluster contains
CPUs, but also additional devices/logic like L2$, GIC, PMUs, floating
point units, CoreSight, etc. etc.

> The rationale behind the change is that newer SoCs can power down the
> cpus for very short sleep times to save on leakage power. The domain which
> usually has the cpus, a second level cache and some peripheral hardware is
> powered by a rail that can also be turned off when the cpus are not in
> use.

This last sentence doesn't read well.  I think you meant something like:

In the domain which has the CPUs, a second level cache and some
peripheral hardware might share the power rail with the CPUs so could
also be turned off when the cpus are not in use.

> Devices for each cpu, L2 and other related blocks could be attached to the
> domain and when there are no uses of these devices (device idle) the domain
> could also be powered off. Generic PM domains provides all the backend needed
> for such an organization.
>
> In the first 2 patches, I make genpd usable in atomic context as well. CPUIdle

s/as well//

> runs with irqs disabled and therefore use of mutexes in the current genpd
> implementation is a limitation. But, not all PM domains need to operate in irq
> safe context, those that need to can specify explicitly the irq safe
> requirement of the genpd at init. Devices and sub-domains that attach to an irq
> safe genpd also have to be irq safe.
>
> The third patch, adds a generic PM domain for the cpus. GenPD provider can be

drop the ',' 

A GenPD provider...

> specified in the DT and individual cpus that are part of the domain would be
> the domain consumers. A new API pm_cpu_domain_init() has been introduced that
> would initialize the genpd and attach cpus specified as consumers in the DT to
> the domain. 

Hmm, doesn't the of_genpd_* stuff already handle this?

What about non-CPU consumers in the same domain?  

> When the cpus enter their idle state cpu_pm notifications are sent
> out for that cpu. The last cpu to send cpu_pm notification would trigger the
> domain power_off callback and the first cpu to come up would trigger the genpd
> power_on callback.  Generally, the power_off callback is where the caches are
> flushed in preparation for a power down and the domain hardware configured to
> power down when the cpu finishes execution. In the power_on callback, the
> domain hardware is reset to a state to allow cpus to be active or entire idle
> states individually.
>
> A future addition to this feature, could be a new genpd governor for the
> specific case of the cpu domain.  The governor may look up the time available
> to sleep between the last cpu down and the first cpu up, in determining if it
> would be more efficient to just keep the domain powered on.
>
> This patch is based on Ulf's patch for simplifying domain power down states
> [1], which removes a bunch of complexity in genpd, simplifying atomic genpd.

Kevin
