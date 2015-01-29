From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/8] PM / Domains: Re-structure code for adding/removing
 devices to genpd
Date: Thu, 29 Jan 2015 11:32:49 +0100
Message-ID: <CAMuHMdWOEYX8S_j80ay4KepESHSJVFFW5UD=cKo_cMQ=Ak0U8g@mail.gmail.com>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33687 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759575AbbA2Kcv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 05:32:51 -0500
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On Tue, Jan 27, 2015 at 9:13 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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

Looks OK, and tested on sh73a0/kzm9g-multiplatform with PM domains
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
