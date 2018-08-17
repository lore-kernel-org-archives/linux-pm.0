From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v12 14/14] cpufreq: qcom: Add support for krait based socs
Date: Fri, 17 Aug 2018 09:09:27 -0600
Message-ID: <20180817150927.GA20248@rob-hp-laptop>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
 <1534248753-2440-15-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534248753-2440-15-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, linux-pm@vger.kernel.org, sboyd@codeaurora.org, linux@armlinux.org.uk, thierry.escande@linaro.org, linux-kernel@vger.kernel.org, david.brown@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, linux-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org, sricharan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Tue, 14 Aug 2018 17:42:33 +0530, Sricharan R wrote:
> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
> that has KRAIT processors the voltage/current value of each OPP
> varies based on the silicon variant in use.
> 
> The required OPP related data is determined based on
> the efuse value. This is similar to the existing code for
> kryo cores. So adding support for krait cores here.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  .../devicetree/bindings/opp/qcom-nvmem-cpufreq.txt |   3 +-
>  drivers/cpufreq/Kconfig.arm                        |   2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c               | 151 +++++++++++++++++++--
>  4 files changed, 149 insertions(+), 12 deletions(-)
> 

DT bindings (including binding headers) should be a separate patch. See
Documentation/devicetree/bindings/submitting-patches.txt.
