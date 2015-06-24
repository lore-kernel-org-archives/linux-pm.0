From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v2 7/9] ARM: multi_v7_defconfig: Enable support for PWM Regulators
Date: Wed, 24 Jun 2015 16:52:20 +0200
Message-ID: <CABxcv==J2hi0y+=s3nK_U=-jkjTW3L9jCC2JfebnWwRfpDGLAQ@mail.gmail.com>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
	<1435154348-28840-8-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435154348-28840-8-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ajit Pal Singh <ajitpal.singh@st.com>
List-Id: linux-pm@vger.kernel.org

Hello Lee,

On Wed, Jun 24, 2015 at 3:59 PM, Lee Jones <lee.jones@linaro.org> wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index f632af0..6666973 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -365,6 +365,7 @@ CONFIG_REGULATOR_MAX8907=y
>  CONFIG_REGULATOR_MAX8973=y
>  CONFIG_REGULATOR_MAX77686=y
>  CONFIG_REGULATOR_PALMAS=y
> +CONFIG_REGULATOR_PWM=y

The current policy is to build as much as possible as a module in
multi_v7_defconfig. Since this is a tristate Kconfig symbol, could you
please change it to =m ?

Best regards,
Javier
