From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC PATCH v15 04/11] ARM: cpuidle: Register cpuidle_ops for
 QCOM cpus
Date: Wed, 11 Mar 2015 11:16:15 -0700
Message-ID: <5500866F.6080704@codeaurora.org>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org> <1425914206-22295-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1425914206-22295-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On 03/09/15 08:16, Lina Iyer wrote:
> Register cpuidle ops for Krait Processor Sub-System.
> Supports v1 and v2 versions of KPSS.
>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  arch/arm/include/asm/cpuidle_ops.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/include/asm/cpuidle_ops.h b/arch/arm/include/asm/cpuidle_ops.h
> index be0a612..40cb262 100644
> --- a/arch/arm/include/asm/cpuidle_ops.h
> +++ b/arch/arm/include/asm/cpuidle_ops.h
> @@ -1,3 +1,8 @@
>  /*
>   * List of cpuidle operations
>   */
> +
> +#if IS_ENABLED(CONFIG_QCOM_PM)

Why not #ifdef CONFIG_QCOM_PM? I thought IS_ENABLED was for C code where
you want to put it in an if () statement.

> +CPUIDLE_OPS(qcom_kpss_v1)
> +CPUIDLE_OPS(qcom_kpss_v2)
> +#endif


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
