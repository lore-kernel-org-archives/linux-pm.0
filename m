From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: pmac64: speed up frequency switch
Date: Wed, 24 Jul 2013 11:02:22 +0530
Message-ID: <CAKohponpyksxDUhawK4U76D9RWEriK0etmMuZWY08GNpUha-Hg@mail.gmail.com>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:65252 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743Ab3GXFcW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2013 01:32:22 -0400
Received: by mail-oa0-f49.google.com with SMTP id n12so8593677oag.8
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2013 22:32:22 -0700 (PDT)
In-Reply-To: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nick Piggin <npiggin@suse.de>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 24 July 2013 01:54, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Some functions on switch path use msleep() which is inaccurate, and
> depends on HZ. With HZ=100 msleep(1) takes actually over ten times longer.
> Using usleep_range() we get more accurate sleeps.
>
> I measured the "pfunc_slewing_done" polling to take 300us at max (on
> 2.3GHz dual-processor Xserve G5), so using 500us sleep there should
> be fine.
>
> With the patch, g5_switch_freq() duration drops from ~50ms to ~10ms on
> Xserve with HZ=100.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looks fine to me as well..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
