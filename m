From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / Domains: Allow runtime PM callbacks to be re-used during system PM
Date: Sat, 12 Dec 2015 03:28:51 +0100
Message-ID: <1792043.fZT1oetn7B@vostro.rjw.lan>
References: <1448896898-27711-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46571 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754197AbbLLB6t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 20:58:49 -0500
In-Reply-To: <1448896898-27711-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, Harunaga <nx-truong@jinso.co.jp>

On Monday, November 30, 2015 04:21:38 PM Ulf Hansson wrote:
> A runtime PM centric subsystem/driver may typically use the runtime PM
> helpers, pm_runtime_force_suspend|resume() in the system PM path. This
> means the genpd's runtime PM callbacks might be invoked even when runtime
> PM has been disabled for the device.
> 
> To properly cope with these and similar scenarios when these helper
> functions are used, change genpd to skip validating and measuring the
> device PM QOS latency.
> 
> This is needed because otherwise genpd may prevent the device to be put
> into low power state. If this occurs during system PM, it causes the
> sequence to be aborted as a device's system PM callback returns -EBUSY.
> 
> Fixes: ba2bbfbf6307 ("PM / Domains: Remove intermediate states from the
> power off sequence")
> Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
> Reported-by: Harunaga <nx-truong@jinso.co.jp>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied, thanks!

Rafael

