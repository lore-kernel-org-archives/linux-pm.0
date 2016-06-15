From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 3/5] PM / Domains: Allow runtime PM during system PM phases
Date: Wed, 15 Jun 2016 14:38:15 -0700
Message-ID: <m2shwenneg.fsf@baylibre.com>
References: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
	<1464600795-26307-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36441 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbcFOViR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 17:38:17 -0400
Received: by mail-pa0-f48.google.com with SMTP id b5so11026662pas.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 14:38:17 -0700 (PDT)
In-Reply-To: <1464600795-26307-4-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 30 May 2016 11:33:13 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> In cases when the PM domain isn't powered off when genpd's ->prepare()
> callback is invoked, genpd runtime resumes and disables runtime PM for the
> device. This behaviour was needed when genpd managed intermediate states
> during the power off sequence, as to maintain proper low power states of
> devices during system PM suspend/resume.
>
> The commit ba2bbfbf6307 ("PM / Domains: Remove intermediate states from
> the power off sequence"), enables genpd to improve its behaviour in this
> regards.
>
> The PM core disables runtime PM at __device_suspend_late() before it calls
> a system PM "late" callback for a device. When resuming a device, after a
> corresponding "early" callback has been invoked, the PM core re-enables
> runtime PM.
>
> By changing genpd to allow runtime PM according to the same system PM
> phases as the PM core, devices can be runtime resumed by its corresponding

grammar nit: s/its/their/

> subsystem/driver when really needed.
>
> In this way, genpd no longer need to runtime resume the device from its
> ->prepare() callback. In most cases that avoids unnecessary and energy-
> wasting operations of runtime resuming devices that have nothing to do,
> only to runtime suspend them shortly after.
>
> Although, because of changing this behaviour in genpd and due to that
> genpd powers on the PM domain unconditionally in the system PM resume
> "noirq" phase, it could potentially cause a PM domain to stay powered on
> even if it's unused after the system has resumed. To avoid this, let's
> schedule a power off work when genpd's system PM ->complete() callback has
> been invoked for the last device in the PM domain.

IIUC, this should be the end of the changelog for this patch.  The rest
was moved to a new patch, no?

> Another issue that arises due to this change in genpd, concerns those
> platforms/PM domains that makes use of genpd's device ->stop|start()
> callbacks. In these scenarios, the corresponding subsystem/driver needs to
> invoke pm_runtime_force_suspend() from a system PM suspend callback to
> allow genpd's ->runtime_suspend() to be invoked for an active device, else
> genpd won't "stop" a device that has been "started".
>
> The subsystem/driver also needs to invoke pm_runtime_force_resume()
> in a system PM resume callback, to restore the runtime PM state for the
> device and to re-enable runtime PM.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Other than the changelog nits above, LGTM.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
