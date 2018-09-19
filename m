From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] cpufreq: qcom-kryo: Fix section mismatch warning
Date: Wed, 19 Sep 2018 10:41:06 -0700
Message-ID: <CAKwvOdnrQYJQnOuh3jDGjw9gKJn64TUMeOXoet2G7v+CyRY-ZA@mail.gmail.com>
References: <20180919060504.29281-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919060504.29281-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: ilia.lin@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 18, 2018 at 11:05 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> the function qcom_cpufreq_kryo_probe() to the function
> .init.text:qcom_cpufreq_kryo_get_msm_id()
> The function qcom_cpufreq_kryo_probe() references
> the function __init qcom_cpufreq_kryo_get_msm_id().
> This is often because qcom_cpufreq_kryo_probe lacks a __init
> annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
>
> Remove the '__init' from qcom_cpufreq_kryo_get_msm_id so that there is
> no more mismatch warning.
>
> Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index a1830fa25fc5..4ea0afc8964c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -44,7 +44,7 @@ enum _msm8996_version {
>
>  struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
>
> -static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
> +static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)

Similar to https://lkml.org/lkml/2018/9/19/816, I think the probe
function should be marked __init instead.

>  {
>         size_t len;
>         u32 *msm_id;
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
