From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 0/9] cpufreq: Add flag to auto-register as cooling
 device
Date: Mon, 28 Jan 2019 12:17:01 +0530
Message-ID: <20190128064701.r25ffs5ixzkcd5r6@vireshk-i7>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, Zhang Rui <rui.zhang@intel.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28-01-19, 12:11, Amit Kucheria wrote:
> Add a flag for cpufreq drivers to tell cpufreq core to auto-register
> themselves as a thermal cooling device.
> 
> There series converts over all the drivers except arm_big_little.c.
> Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> others.
> 
> Things needing fixing (but not a blocker for the series):
>  - Look at how to detect that we're not in IKS mode in arm_big_little's
>    .ready callback.
> 
> Chnages since v3:
>  - Got rid of wrapper function to register/unregister cooling devices.
>    Directly call the function in cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
