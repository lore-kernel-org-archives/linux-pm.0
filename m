From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 7/8] PM / OPP: Allow platform specific custom
 opp_set_rate() callbacks
Date: Wed, 5 Oct 2016 06:59:29 +0530
Message-ID: <20161005012929.GF4664@vireshk-i7>
References: <cover.1475581665.git.viresh.kumar@linaro.org>
 <f774c37de292f89053f22e9a2ac0f51c73c8dd89.1475581665.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33737 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753040AbcJEB3d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Oct 2016 21:29:33 -0400
Received: by mail-pa0-f42.google.com with SMTP id cd13so74913378pac.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2016 18:29:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f774c37de292f89053f22e9a2ac0f51c73c8dd89.1475581665.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 04-10-16, 17:26, Viresh Kumar wrote:
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> +int dev_pm_opp_register_set_rate_helper(struct device *dev,
> +	int (*set_rate)(struct device *dev, struct dev_pm_set_rate_data *data))
> +{
> +	return -ENOTSUPP;
> +}

+ this to fix up a warning:

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index ef882ed24b0e..483f33e70895 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -180,7 +180,7 @@ static inline int dev_pm_opp_set_supported_hw(struct device *dev,
 
 static inline void dev_pm_opp_put_supported_hw(struct device *dev) {}
 
-int dev_pm_opp_register_set_rate_helper(struct device *dev,
+static inline int dev_pm_opp_register_set_rate_helper(struct device *dev,
        int (*set_rate)(struct device *dev, struct dev_pm_set_rate_data *data))
 {
        return -ENOTSUPP;

-- 
viresh
