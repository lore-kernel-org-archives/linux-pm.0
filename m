From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v18 04/11] ARM: cpuidle: Add cpuidle support for QCOM
 cpus
Date: Fri, 27 Mar 2015 18:58:25 +0100
Message-ID: <55159A41.4010700@linaro.org>
References: <1427315136-44321-1-git-send-email-lina.iyer@linaro.org> <1427315136-44321-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1427315136-44321-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On 03/25/2015 09:25 PM, Lina Iyer wrote:
> Define ARM_QCOM_CPUIDLE config item to enable cpuidle support.
>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/Kconfig.arm | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 21340e0..325be7f 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -74,3 +74,10 @@ config ARM_MVEBU_V7_CPUIDLE
>   	depends on ARCH_MVEBU && !ARM64
>   	help
>   	  Select this to enable cpuidle on Armada 370, 38x and XP processo=
rs.
> +
> +config ARM_QCOM_CPUIDLE
> +	bool "CPU Idle Driver for QCOM processors"
> +	depends on ARCH_QCOM
> +	select ARM_CPUIDLE
> +	help
> +	  Select this to enable cpuidle on QCOM processors.
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
