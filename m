From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 09/10] cpufreq: cpu0: rename driver and internals to
 'cpufreq_generic'
Date: Mon, 08 Sep 2014 17:01:33 -0700
Message-ID: <540E435D.1070706@codeaurora.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org> <540E3933.8000904@codeaurora.org> <1721663.ItCsG3Tt8O@vostro.rjw.lan> <3644672.iCZ87qpZY4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <3644672.iCZ87qpZY4@vostro.rjw.lan>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com
List-Id: linux-pm@vger.kernel.org

On 09/08/14 16:52, Rafael J. Wysocki wrote:
> So more bikeshedding. :-)
>
> Isn't "generic" somewhat too broad?  Surely it doesn't cover x86.  And does
> it actually cover anything without clocks/regulators?
>

I thought when you bikeshed you have to come up with a different color ;-)

Perhaps "cpufreq_cpus"?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
