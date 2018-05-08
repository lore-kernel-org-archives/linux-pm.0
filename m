From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] drivers: thermal: step_wise: add support for hysteresis
Date: Tue, 8 May 2018 04:04:53 +0200
Message-ID: <20180508020453.GH19313@mai>
References: <20180507175408.2154-1-ilina@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180507175408.2154-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Ram Chandrasekar <rkumbako@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 07, 2018 at 11:54:08AM -0600, Lina Iyer wrote:
> From: Ram Chandrasekar <rkumbako@codeaurora.org>
> 
> From: Ram Chandrasekar <rkumbako@codeaurora.org>
> 
> Step wise governor increases the mitigation level when the temperature
> goes above a threshold and will decrease the mitigation when the
> temperature falls below the threshold. If it were a case, where the
> temperature hovers around a threshold, the mitigation will be applied
> and removed at every iteration. This reaction to the temperature is
> inefficient for performance.
> 
> The use of hysteresis temperature could avoid this ping-pong of
> mitigation by relaxing the mitigation to happen only when the
> temperature goes below this lower hysteresis value.

I don't disagree with this but the ping-pong around a temperature is usually
avoided with a P-I-D computation which is implemented with the IPA governor.
Wouldn't be more interesting to add the power numbers like some other
platforms, so the IPA could be used?

You will probably have better results with the IPA than changing the step-wise
governor behavior (which may potentially impact other users).


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
