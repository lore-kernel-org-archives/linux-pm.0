From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH V2] PM / Domains: Sync runtime PM status with genpd after probe
Date: Fri, 20 Mar 2015 17:14:34 -0700
Message-ID: <7hvbhvi4ut.fsf@deeprootsystems.com>
References: <1426863312-31132-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33129 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbbCUAOh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 20:14:37 -0400
Received: by pabxg6 with SMTP id xg6so111075565pab.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2015 17:14:37 -0700 (PDT)
In-Reply-To: <1426863312-31132-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Fri, 20 Mar 2015 15:55:12 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> From: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Buses which currently supports attaching devices to their PM domains,
> will invoke the dev_pm_domain_attach() API from their ->probe()
> callbacks. During the attach procedure, genpd power up the PM domain.
>
> In those scenarios where the bus/driver don't need to access its device
> during probe, it may leave it in runtime PM suspended state since
> that's also the default state. In that way, no notifications through
> the runtime PM callbacks will reach the PM domain during probe.
>
> For genpd, the consequence from the above scenario means the PM domain
> will remain powered. Therefore, implement the struct dev_pm_domain's
> ->sync() callback, which is invoked from driver core after the
> bus/driver has probed the device. It allows genpd to power off the PM
> domain if it's unused.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> [Ulf: Updated patch according to updates in driver core]
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
> 	- I picked up Russell's earlier patch [1] and updated it to fit the
> 	changes [2] proposed to be done to the driver core.
>
> 	[1]: [PATCH 3/9] pm: domains: sync runtime PM status with PM domains
> 	after probe
>
> 	[2]: [PATCH v3] driver core / PM: Add PM domain callbacks for device
> 	setup/cleanup
> 	http://www.spinics.net/lists/arm-kernel/msg407394.html

Ah, I hadn't seen this when I reviewed Rafael's v3 and suggested
Russell's patch be reworked.  This is just what I had in mind.

Acked-by: Kevin Hilman <khilman@linaro.org>
