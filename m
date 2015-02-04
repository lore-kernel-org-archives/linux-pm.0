From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/8] PM / Domains: Re-structure code for adding/removing devices to genpd
Date: Wed, 04 Feb 2015 15:39:49 +0100
Message-ID: <5703029.cMXmjeytH4@vostro.rjw.lan>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53893 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932599AbbBDOQz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 09:16:55 -0500
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

On Tuesday, January 27, 2015 09:13:37 PM Ulf Hansson wrote:
> While adding error handling of genpd's ->attach_dev() callback, I realized that
> we also had a need to re-structure some of the code which deals with
> adding/removing devices to genpd. Especially the APIs, __pm_genpd_add_device()
> and pm_genpd_remove_device() deserved some attention.
> 
> Patch 1 -> 4, can be considered as more simple cleanups and should not impact
> the behavior for current clients using the APIs. 
> 
> Patch 5, eliminates a mutex for generic_pm_domain_data by re-order the
> initialization/cleanup of dev_pm_qos notifiers.
> 
> Patch 6, move some code around to fix a potenial memory leakage of a struct
> pm_subsys_data.
> 
> Patch 7, code restructuring which impacts locking behavior while adding/removing
> devices. Should improve code readability and decrease critical regions of
> holding locks.
> 
> Patch 8, Adds error handling of genpd's ->attach_dev() callback
> 
> 
> Ulf Hansson (8):
>   PM / Domains: Rename __pm_genpd_alloc|free_dev_data()
>   PM / Domains: Remove reference counting for the generic_pm_domain_data
>   PM / Domains: Don't allow an existing generic_pm_domain_data
>   PM / Domains: Don't check for an existing device when adding a new
>   PM / Domains: Eliminate the mutex for the generic_pm_domain_data
>   PM / Domains: Free pm_subsys_data in error path in
>     __pm_genpd_add_device()
>   PM / Domains: Re-order initialization of generic_pm_domain_data
>   PM / Domains: Handle errors from genpd's ->attach_dev() callback
> 
>  drivers/base/power/domain.c | 137 +++++++++++++++++++++-----------------------
>  include/linux/pm_domain.h   |   2 -
>  2 files changed, 65 insertions(+), 74 deletions(-)

Whole series queued up for 3.20, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
