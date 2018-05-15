From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 12/14] cpufreq: Add Kryo CPU scaling driver
Date: Tue, 15 May 2018 11:28:48 +0200
Message-ID: <2615751.ZtaStQGZr4@aspire.rjw.lan>
References: <1526375616-16904-1-git-send-email-ilialin@codeaurora.org> <1526375616-16904-13-git-send-email-ilialin@codeaurora.org> <20180515091912.zhc2uo7js7ukjvl7@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515091912.zhc2uo7js7ukjvl7@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, nm@ti.com, lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org, amit.kucheria@linaro.org, nicolas.dechesne@linaro.org, celster@codeaurora.org, tfinkel@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 15, 2018 11:19:12 AM CEST Viresh Kumar wrote:
> On 15-05-18, 12:13, Ilia Lin wrote:
> > In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
> > the CPU ferequencies subset and voltage value of each OPP varies
> > based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
> > defines the voltage and frequency value based on the msm-id in SMEM
> > and speedbin blown in the efuse combination.
> > The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> > to provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each OPP of
> > operating-points-v2 table when it is parsed by the OPP framework.
> > 
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > ---
> >  drivers/cpufreq/Kconfig.arm          |  11 +++
> >  drivers/cpufreq/Makefile             |   1 +
> >  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
> >  drivers/cpufreq/qcom-cpufreq-kryo.c  | 150 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 165 insertions(+)
> >  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

OK, but I'm assuming that this will go in via arm-soc.

Thanks,
Rafael
