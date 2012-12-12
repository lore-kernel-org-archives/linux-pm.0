From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle - remove the power_specified field in the driver
Date: Wed, 12 Dec 2012 23:42:19 +0100
Message-ID: <2077776.UzqC1zVIVr@vostro.rjw.lan>
References: <1355325801-1317-1-git-send-email-daniel.lezcano@linaro.org> <CAODwPW81fXDNMTvG8juR6iAGFeDV9PXE-65Wp+dAE-mcKYU2nw@mail.gmail.com> <50C8E275.9050308@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59088 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465Ab2LLWhQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Dec 2012 17:37:16 -0500
In-Reply-To: <50C8E275.9050308@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Julius Werner <jwerner@chromium.org>, Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Trinabh Gupta <g.trinabh@gmail.com>, Lists Linaro-dev <linaro-dev@lists.linaro.org>, len.brown@intel.com, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sameer Nanda <snanda@chromium.org>

On Wednesday, December 12, 2012 09:00:53 PM Daniel Lezcano wrote:
> On 12/12/2012 07:50 PM, Julius Werner wrote:
> > Thanks again for making this happen, Daniel. I like this version,
> > except for the small nitpick that I still think it would make sense to
> > also turn the loop in menu.c around. How about something like this:
> > 
> >        for (i = drv->state_count - 1; i >= CPUIDLE_DRIVER_STATE_START; i++) {
> >                 struct cpuidle_state *s = &drv->states[i];
> >                 if (!s->disable && s->exit_latency <= latency_req &&
> >                     s->target_residency <= data->predicted_us &&
> >                     s->exit_latency * multiplier <= data->predicted_us) {
> >                         data->last_state_idx = i;
> >                         data->exit_us = s->exit_latency;
> >                         break;
> >                 }
> >         }
> 
> Actually I was planning to do that in a separate patch.

Can you submit that second patch too, please, so that people don't have to
wonder?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
