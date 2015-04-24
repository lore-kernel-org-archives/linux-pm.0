From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] PM / clock_ops: provide default runtime ops and
 cleanup users
Date: Fri, 24 Apr 2015 09:57:17 +0200
Message-ID: <CAPDyKFpAm+DK4SUK_Oc7Fb+jEEQvO3355qWp52nmkJs2YX5T4A@mail.gmail.com>
References: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33973 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214AbbDXH5S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 03:57:18 -0400
Received: by qkgx75 with SMTP id x75so25421875qkg.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 00:57:17 -0700 (PDT)
In-Reply-To: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 23 April 2015 at 10:33, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Most users of PM clocks do the exact same thing in runtime callbacks.
> Provide default callbacks and cleanup the existing users (keystone/davinci
> /omap1/sh)
>
> Rajendra Nayak (5):
>   PM / clock_ops: Provide default runtime ops to users
>   arm: keystone: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>   arm: omap1: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>   arm: davinci: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>   drivers: sh: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>
>  arch/arm/mach-davinci/pm_domain.c  | 32 +-------------------------
>  arch/arm/mach-keystone/pm_domain.c | 33 +-------------------------
>  arch/arm/mach-omap1/pm_bus.c       | 37 ++----------------------------
>  drivers/base/power/clock_ops.c     | 38 ++++++++++++++++++++++++++++++
>  drivers/sh/pm_runtime.c            | 47 ++------------------------------------
>  include/linux/pm_clock.h           | 10 ++++++++
>  6 files changed, 54 insertions(+), 143 deletions(-)

I guess you don't need more acks/reviewed by for this patchset. Still,
and also for my own reference.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
