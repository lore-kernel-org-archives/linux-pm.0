From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v7 1/5] PM / Domains: prepare for multiple states
Date: Thu, 30 Apr 2015 09:29:59 -0600
Message-ID: <20150430152959.GD424@linaro.org>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
 <1430391335-7588-2-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33949 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbD3PaC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 11:30:02 -0400
Received: by pacyx8 with SMTP id yx8so63043208pac.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2015 08:30:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1430391335-7588-2-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ahaslam@baylibre.com
Cc: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net, bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

On Thu, Apr 30 2015 at 04:57 -0600, ahaslam@baylibre.com wrote:
>From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
>prepare generic power domain init function parameters
>to accept a pointer to the states structure that describes
>the possible states that a power domain can enter.
>
>There is no functional change, as support for multiple
>domains will be added in subsequent patches.
>
>Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>

<...>

> extern void pm_genpd_init(struct generic_pm_domain *genpd,
>-			  struct dev_power_governor *gov, bool is_off);
>+			  struct dev_power_governor *gov,
>+			  const struct genpd_power_state *states,
>+			  unsigned int state_count, bool is_off);
>

Wouldnt it be better to setup another function pm_genpd_init_simple()
that calls into pm_genpd_init() with no arguments?

static inline void pm_genpd_init_simple(struct generic_pm_domain *genpd,
                               struct dev_power_governor *gov, bool is_off)
{
	return pm_genpd_init(genpd, gov, NULL, 0, is_off);
}

It would be explicit that way to indicate the new genpd feature that would let
domains support multiple states.

Thanks,
Lina
