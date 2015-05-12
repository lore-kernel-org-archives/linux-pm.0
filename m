From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v7 1/5] PM / Domains: prepare for multiple states
Date: Tue, 12 May 2015 09:37:02 -0600
Message-ID: <20150512153702.GL16124@linaro.org>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
 <1430391335-7588-2-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35932 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932507AbbELPhE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 11:37:04 -0400
Received: by pdea3 with SMTP id a3so16880075pde.3
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 08:37:03 -0700 (PDT)
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

[...]

>diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>index 681ccb0..6b4802e 100644
>--- a/include/linux/pm_domain.h
>+++ b/include/linux/pm_domain.h
>@@ -46,6 +46,12 @@ struct gpd_cpuidle_data {
> 	struct cpuidle_state *idle_state;
> };
>
>+struct genpd_power_state {
>+	char *name;
>+	s64 power_off_latency_ns;
>+	s64 power_on_latency_ns;
>+};
>+

I know you carried this over from the existing code, but any reason why
this should be signed?

-- Lina
