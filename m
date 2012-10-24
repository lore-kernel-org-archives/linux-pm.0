From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2 6/6] Thermal: Add ST-Ericsson DB8500 thermal
 properties and platform data.
Date: Wed, 24 Oct 2012 07:32:04 -0700
Message-ID: <1351089124.18179.12.camel@joe-AO722>
References: <1350387889-15324-1-git-send-email-hongbo.zhang@linaro.com>
	 <1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
	 <1351079900-32236-7-git-send-email-hongbo.zhang@linaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351079900-32236-7-git-send-email-hongbo.zhang@linaro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "hongbo.zhang" <hongbo.zhang@linaro.org>
Cc: linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, "hongbo.zhang" <hongbo.zhang@linaro.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2012-10-24 at 19:58 +0800, hongbo.zhang wrote:
> This patch adds device tree properties for ST-Ericsson DB8500 thermal driver,
> also adds the platform data to support the old fashion.

Just a trivial note:

> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c

> @@ -229,6 +230,67 @@ static struct ab8500_platform_data ab8500_platdata = {
>  };
>  
>  /*
> + * Thermal Sensor
> + */
> +
> +static struct resource db8500_thsens_resources[] = {

should there be a const in any of these?

> +static struct db8500_thsens_platform_data db8500_thsens_data = {
[]
> +static struct platform_device u8500_thsens_device = {
[]
> +static struct platform_device u8500_cpufreq_cooling_device = {
