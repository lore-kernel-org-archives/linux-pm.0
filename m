From: Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH] cpuidle - remove the power_specified field in the driver
Date: Wed, 12 Dec 2012 10:50:23 -0800
Message-ID: <CAODwPW81fXDNMTvG8juR6iAGFeDV9PXE-65Wp+dAE-mcKYU2nw@mail.gmail.com>
References: <1355325801-1317-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39410 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab2LLSuj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Dec 2012 13:50:39 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so448635wey.19
        for <linux-pm@vger.kernel.org>; Wed, 12 Dec 2012 10:50:37 -0800 (PST)
In-Reply-To: <1355325801-1317-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Trinabh Gupta <g.trinabh@gmail.com>, Lists Linaro-dev <linaro-dev@lists.linaro.org>, len.brown@intel.com, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sameer Nanda <snanda@chromium.org>

Thanks again for making this happen, Daniel. I like this version,
except for the small nitpick that I still think it would make sense to
also turn the loop in menu.c around. How about something like this:

       for (i = drv->state_count - 1; i >= CPUIDLE_DRIVER_STATE_START; i++) {
                struct cpuidle_state *s = &drv->states[i];
                if (!s->disable && s->exit_latency <= latency_req &&
                    s->target_residency <= data->predicted_us &&
                    s->exit_latency * multiplier <= data->predicted_us) {
                        data->last_state_idx = i;
                        data->exit_us = s->exit_latency;
                        break;
                }
        }
