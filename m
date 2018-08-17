From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v12 13/14] cpufreq: qcom: Re-organise kryo cpufreq to use
 it for other nvmem based qcom socs
Date: Fri, 17 Aug 2018 09:09:02 -0600
Message-ID: <20180817150902.GA19164@rob-hp-laptop>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
 <1534248753-2440-14-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534248753-2440-14-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, linux-pm@vger.kernel.org, sboyd@codeaurora.org, linux@armlinux.org.uk, thierry.escande@linaro.org, linux-kernel@vger.kernel.org, david.brown@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, linux-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org, sricharan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Tue, 14 Aug 2018 17:42:32 +0530, Sricharan R wrote:
> The kryo cpufreq driver reads the nvmem cell and uses that data to
> populate the opps. There are other qcom cpufreq socs like krait which
> does similar thing. Except for the interpretation of the read data,
> rest of the driver is same for both the cases. So pull the common things
> out for reuse.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  .../{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt}   |   6 +-
>  drivers/cpufreq/Kconfig.arm                        |   4 +-
>  drivers/cpufreq/Makefile                           |   2 +-
>  .../{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c}  | 124 ++++++++++++---------
>  4 files changed, 80 insertions(+), 56 deletions(-)
>  rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (99%)
>  rename drivers/cpufreq/{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} (65%)
> 

DT bindings (including binding headers) should be a separate patch. See
Documentation/devicetree/bindings/submitting-patches.txt.
