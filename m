From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 3/6] PM / OPP: Support adjusting OPP voltages at runtime
Date: Tue, 2 Jun 2015 12:54:21 -0700
Message-ID: <20150602195421.GA11764@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
 <1433209679-31389-4-git-send-email-sboyd@codeaurora.org>
 <20150602045026.GC10443@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150602045026.GC10443@linux>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 06/02, Viresh Kumar wrote:
> On 01-06-15, 18:47, Stephen Boyd wrote:
> > +int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
> > +		   unsigned long u_volt);
> 
> > +static inline int dev_pm_opp_adjust_voltage(struct device *dev,
> > +		unsigned long freq, unsigned long u_volt)
> 
> The 'u' of 'unsigned' isn't aligned to the opening curly brace. Try
> running with checkpatch --strict and you will see some warnings.
> 
> Otherwise,
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Will do. Thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
