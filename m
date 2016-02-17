From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC v2 03/12] PM / cpu_domains: Setup PM domains for
 CPUs/clusters
Date: Wed, 17 Feb 2016 16:38:30 -0700
Message-ID: <20160217233830.GA1313@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35395 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423790AbcBQXid (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 18:38:33 -0500
Received: by mail-pf0-f170.google.com with SMTP id c10so20368286pfc.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 15:38:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455310238-8963-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Daniel Lezcano <daniel.lezcano@linaro.org>

On Fri, Feb 12 2016 at 13:51 -0700, Lina Iyer wrote:

>+static int cpu_pd_power_on(struct generic_pm_domain *genpd)
>+{
>+	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
>+
>+	return pd->ops.power_on();

Needs a check for NULL ops.power_on() here.
>+}
>+
>+static int cpu_pd_power_off(struct generic_pm_domain *genpd)
>+{
>+	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
>+
>+	return pd->ops.power_off(genpd->state_idx,
>+			genpd->states[genpd->state_idx].param);
Needs a check for NULL ops.power_off().

Thanks,
Lina
