From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH v14 0/2] Kryo CPU scaling driver
Date: Tue, 29 May 2018 14:11:02 +0300
Message-ID: <CAHLCerNAGNWdYbRTmStJcrAw7jj5nmowqvaNCtHA6LEnRpParw@mail.gmail.com>
References: <1527250067-1256-1-git-send-email-ilialin@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527250067-1256-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilialin@codeaurora.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 25, 2018 at 3:07 PM, Ilia Lin <ilialin@codeaurora.org> wrote:
> [v14]
>  * Addressed comment from Sudeep about DT compatible
>  * Added MAINTAINERS entry
>
> [v13]
>  * Addressed comment from Sudeep about DT compatible check on init
>
> [v12]
>  * Addressed comments from Sudeep and Viresh about the single init
>
> [v11]
>  * Addressed comment from Russel about device_node reference
>  * Addressed comment from Sudeep about the late_initcall
>  * Transformed init into probe to take care of deferals
>
> [v10]
>  * Split the series into domains
>  * Addressed comments from Viresh and Sudeep about logical CPU numbering.
>
> The qcom-cpufreq-kryo driver is aimed to support different SOC versions.
> The driver reads eFuse information and chooses the required OPP subset
> by passing the OPP supported-hw parameter.
>
> The series depends on the series from Viresh:
> https://patchwork.kernel.org/patch/10418139/
>
> The previous spin was here:
> https://patchwork.kernel.org/patch/10424949/
>
> Ilia Lin (2):
>   cpufreq: Add Kryo CPU scaling driver
>   dt-bindings: cpufreq: Document operating-points-v2-kryo-cpu
>
>  .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  drivers/cpufreq/Kconfig.arm                        |  10 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
>  drivers/cpufreq/qcom-cpufreq-kryo.c                | 206 +++++++
>  6 files changed, 907 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
>
FWIW,

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
