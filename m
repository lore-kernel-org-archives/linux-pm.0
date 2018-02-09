From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 8/8] thermal/drivers/cpu_cooling: Add the combo cpu
 cooling device
Date: Fri, 9 Feb 2018 15:14:19 +0530
Message-ID: <20180209094419.GN28462@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-9-git-send-email-daniel.lezcano@linaro.org>
 <20180202104259.GA28462@vireshk-i7>
 <8dadd854-25ac-68aa-aa9f-33ba76a137a4@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8dadd854-25ac-68aa-aa9f-33ba76a137a4@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, daniel.thompson@linaro.org
List-Id: linux-pm@vger.kernel.org

On 02-02-18, 15:30, Daniel Lezcano wrote:
> Agree the cpufreq driver can be unloaded and this part needs some
> adjustments.

Also note that the cpufreq cooling device has two separate set of
callbacks, one for the power-specific callbacks. You haven't taken
care of them in the combo thing.

-- 
viresh
