From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PM / Domains: Silence compiler warning for an unused function
Date: Mon, 01 Feb 2016 15:57:05 +0100
Message-ID: <3036326.s6YOSZnl2s@wuerfel>
References: <1454334761-13678-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:62998 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715AbcBAO6X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2016 09:58:23 -0500
In-Reply-To: <1454334761-13678-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>

On Monday 01 February 2016 14:52:41 Ulf Hansson wrote:
> The only remaining caller of genpd_poweron() is conditionally compiled
> based on CONFIG_PM_GENERIC_DOMAINS_OF, so we get a warning when that is
> unset.
> 
> By moving the locking/unlocking of the genpd outside genpd_poweron(), thus
> to the caller, genpd_poweron() becomes redundant.
> 
> Within this context let's then rename the wrapper function,
> __genpd_poweron(), to genpd_poweron() as it will then be consistent with
> its friend genpd_poweroff().
> 
> This change silence the warning about the unused function.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ea823c7cbffa ("PM / Domains: Remove pm_genpd_poweron() API")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
