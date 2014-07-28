From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/1] cpuidle: big_little: Fix build error
Date: Mon, 28 Jul 2014 08:18:46 +0200
Message-ID: <53D5EB46.7070606@linaro.org>
References: <1406523539-23823-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:59227 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbaG1GSs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jul 2014 02:18:48 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so3813014wib.9
        for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2014 23:18:47 -0700 (PDT)
In-Reply-To: <1406523539-23823-1-git-send-email-sachin.kamat@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@samsung.com>, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, afaerber@suse.de, spk.linux@gmail.com

On 07/28/2014 06:58 AM, Sachin Kamat wrote:
> big_little CPU idle driver references functions defined in MCPM drive=
r.
> Thus make it depend on MCPM to avoid the following errors:
>
> drivers/built-in.o: In function `bl_enter_powerdown':
> drivers/cpuidle/cpuidle-big_little.c:134: undefined reference to `mcp=
m_cpu_powered_up'
> drivers/built-in.o: In function `bl_powerdown_finisher':
> drivers/cpuidle/cpuidle-big_little.c:104: undefined reference to `mcp=
m_set_entry_vector'
> drivers/cpuidle/cpuidle-big_little.c:111: undefined reference to `mcp=
m_cpu_suspend'
> make: *** [vmlinux] Error 1
>
> Reported-by: Andreas F=C3=A4rber <afaerber@suse.de>
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> ---
>   drivers/cpuidle/Kconfig.arm | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 33fc0ff..38cff69 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -4,6 +4,7 @@
>   config ARM_BIG_LITTLE_CPUIDLE
>   	bool "Support for ARM big.LITTLE processors"
>   	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
> +	depends on MCPM
>   	select ARM_CPU_SUSPEND
>   	select CPU_IDLE_MULTIPLE_DRIVERS
>   	help

Hi Sachin,

thanks for the fix. Arnd sent the same fix a couple of weeks ago.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272142.=
html

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

