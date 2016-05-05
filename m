From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] PM / Domains: Allow genpd to power on during the system PM phase
Date: Thu, 05 May 2016 12:31:08 +0200
Message-ID: <m2shxwdcer.fsf@baylibre.com>
References: <1461673411-14245-1-git-send-email-ulf.hansson@linaro.org>
	<1461673411-14245-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38582 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392AbcEEKbL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 06:31:11 -0400
Received: by mail-wm0-f48.google.com with SMTP id g17so20175572wme.1
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2016 03:31:10 -0700 (PDT)
In-Reply-To: <1461673411-14245-2-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Tue, 26 Apr 2016 14:23:30 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> If the PM domain is powered off when the first device in the domain starts
> its system PM prepare phase, genpd prevents any further attempts to power
> on the PM domain during the system PM phase. This constraint affects not
> only the current device which is being prepared, but all devices within
> the same PM domain.
>
> This behaviour needs to be changed, as a subsystem/driver for a device in
> the same PM domain may still need to be able to serve requests in the
> system PM phase. Accordingly, it may need to runtime resume its device and
> thus also request the corresponding PM domain to be powered on.
>
> To deal with these scenarios, let's make the device operational in the
> system PM prepare phase by runtime resuming it, no matter if the PM domain
> was powered on or not. Additionally allow the PM domain to be powered on
> via runtime PM during the system PM phase.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

LGTM.  I would just request an update to the changelog saying a bit
about the suspend_power_off flag, which is used to track this condition,
which would also explain why it's removed in this patch.

Kevin
