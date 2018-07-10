From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v6 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
Date: Tue, 10 Jul 2018 15:34:39 -0700
Message-ID: <CAE=gft4YR27-ZyR5GXVxbiRbGycw=ydHu182LfwaLD=M+a8CNw@mail.gmail.com>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-7-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180709155104.25528-7-georgi.djakov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: georgi.djakov@linaro.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org, linux-pm@vger.kernel.org, seansw@qti.qualcomm.com, gregkh@linuxfoundation.org, Michael Turquette <mturquette@baylibre.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, Bjorn Andersson <bjorn.andersson@linaro.org>, robh+dt@kernel.org, Saravana Kannan <skannan@codeaurora.org>, Alexandre Bailon <abailon@baylibre.com>, khilman@baylibre.com, linux-arm-msm@vger.kernel.org, tfiga@chromium.org, daidavid1@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 9, 2018 at 8:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Add driver for the Qualcomm interconnect buses found in msm8916 based
> platforms.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/Kconfig        |   5 +
>  drivers/interconnect/Makefile       |   1 +
>  drivers/interconnect/qcom/Kconfig   |  10 +
>  drivers/interconnect/qcom/Makefile  |   2 +
>  drivers/interconnect/qcom/msm8916.c | 499 ++++++++++++++++++++++++++++
>  5 files changed, 517 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index a261c7d41deb..07a8276fa35a 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -8,3 +8,8 @@ menuconfig INTERCONNECT
>
>           If unsure, say no.
>
> +if INTERCONNECT
> +
> +source "drivers/interconnect/qcom/Kconfig"
> +
> +endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 97fca2e09d24..7944cbca0527 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_INTERCONNECT)             += core.o
> +obj-$(CONFIG_INTERCONNECT_QCOM)                += qcom/
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index b0c2ff928d88..a87afdef1bf7 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -2,6 +2,8 @@ config INTERCONNECT_QCOM
>         bool "Qualcomm Network-on-Chip interconnect drivers"
>         depends on INTERCONNECT
>         depends on ARCH_QCOM || COMPILE_TEST
> +       help
> +         Support for Qualcomm's Network-on-Chip interconnect hardware.
>
>  config INTERCONNECT_QCOM_SMD_RPM
>         tristate "Qualcomm SMD RPM interconnect driver"
> @@ -9,3 +11,11 @@ config INTERCONNECT_QCOM_SMD_RPM
>         help
>           This is a driver for communicating interconnect related configuration
>           details with a remote processor (RPM) on Qualcomm platforms.
> +
> +config INTERCONNECT_QCOM_MSM8916
> +       tristate "Qualcomm MSM8916 interconnect driver"
> +       depends on INTERCONNECT_QCOM
> +       select INTERCONNECT_QCOM_SMD_RPM

I'm not a kconfig expert, maybe someone else could chime in. I have
this impression that folks don't like select. Is there a way to do
this with depends instead? If I'm way off here, ignore me.
