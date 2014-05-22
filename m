From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: EXYNOS: Use wfi macro in platform_do_lowpower
Date: Thu, 22 May 2014 21:01:15 +0200
Message-ID: <537E497B.9020404@linaro.org>
References: <1400745455-27920-1-git-send-email-leela.krishna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1400745455-27920-1-git-send-email-leela.krishna@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Leela Krishna Amudala <leela.krishna@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: kgene.kim@samsung.com, amit.kucheria@linaro.org
List-Id: linux-pm@vger.kernel.org

On 05/22/2014 09:57 AM, Leela Krishna Amudala wrote:
> This patch is originally based on commit b3377d186572 ("ARM: 7064/1:
> vexpress: Use wfi macro in platform_do_lowpower.")
>
> Current Exynos CPU hotplug code includes a hardcoded WFI
> instruction, in ARM encoding.  When the kernel is compiled in Thumb-2
> mode, this is invalid and causes the machine to hang hard when a CPU
> is offlined.
>
> Use wfi macro instead of the hardcoded WFI instruction.
>
> Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
