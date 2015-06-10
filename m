From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for cpu domain
Date: Wed, 10 Jun 2015 14:37:57 -0700
Message-ID: <7hmw07meh6.fsf@deeprootsystems.com>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
	<1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36482 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbbFJViB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 17:38:01 -0400
Received: by pabqy3 with SMTP id qy3so41701476pab.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2015 14:38:00 -0700 (PDT)
In-Reply-To: <1433456946-53296-4-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Thu, 4 Jun 2015 16:29:06 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, mathieu.poirier@linaro.org, galak@codeaurora.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Generally cpus are grouped under a power domain in a SoC. When all cpus
> in the domain are in their power off state, the cpu domain can also be
> powered off. 

How does this relate to a cluster, and why aren't you using that terminolgy?

> Genpd provides the framework for defining cpus as devices
> that are part of a cpu domain.
>
> Introduce support for defining and adding a generic power domain for the
> cpus based on the DT specification of power domain providers and
> consumers.  SoC's that have the cpu domain defined in their DT, can
> setup a genpd with a name and the power_on/power_off callbacks. Calling
> pm_cpu_domain_init() will register the genpd and attach the cpus for
> this domain with the genpd.
>
> CPU_PM notifications for are used to pm_runtime_get_sync() and
> pm_runtime_put_sync() for each cpu.  When all cpus are powered off, the
> last cpu going down would call the genpd->power_off(). Correspondingly,
> the first cpu up would call the genpd->power_on() callback before
> resuming from idle.

Other patches also mention this genpd being useful to gate power to
non-CPU peripherals on the same power rail.  How are those devices to be
added?

Without seeing the DTs and the init code that might call
pm_cpu_domain_init(), it's hard for me to see how this is intended to be
used.  Could you also include a patch that shows how this is initialized
and the DT additions?  Ideally, it should also show how a non-CPU device
would be included.

Kevin

