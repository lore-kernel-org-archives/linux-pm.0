From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/6] PM / OPP: Support adjusting OPP voltages at runtime
Date: Tue, 2 Jun 2015 10:20:26 +0530
Message-ID: <20150602045026.GC10443@linux>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
 <1433209679-31389-4-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433209679-31389-4-git-send-email-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 01-06-15, 18:47, Stephen Boyd wrote:
> +int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
> +		   unsigned long u_volt);

> +static inline int dev_pm_opp_adjust_voltage(struct device *dev,
> +		unsigned long freq, unsigned long u_volt)

The 'u' of 'unsigned' isn't aligned to the opening curly brace. Try
running with checkpatch --strict and you will see some warnings.

Otherwise,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
