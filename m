From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Missing patches for thermal for 5.2
Date: Tue, 07 May 2019 08:24:22 +0800
Message-ID: <1557188662.5080.1.camel@intel.com>
References: <b3fbf910-d073-1dd9-649c-eea370ae71f7@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b3fbf910-d073-1dd9-649c-eea370ae71f7@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 一, 2019-05-06 at 15:17 +0200, Daniel Lezcano wrote:
> Hi Eduardo, Zhang,
> 
> AFAICS, the following patches are missing for 5.2:
> 
> 
> [PATCH -next] mlxsw: Remove obsolete dependency on THERMAL=m
> 
This one is already in my tree.
https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git/commit
/?h=next&id=980d43f24d59491aa1c5552171454ac25fb86ea2

And I think the below patches should go through Eduardo' tree.

thanks,
rui

> [PATCH v3 1/3] thermal: rockchip: fix up the tsadc pinctrl setting
> error
> 
> [PATCH v3 2/3] dt-bindings: rockchip-thermal: Support the PX30 SoC
> compatible
> 
> [PATCH v3 3/3] thermal: rockchip: Support the PX30 SoC in thermal
> driver
> 
> [PATCH] thermal: cpu_cooling: Actually trace CPU load in
> thermal_power_cpu_get_power
> 
> [PATCH] thermal/drivers/cpu_cooling: Remove pointless test in
> power2state()
> 
> [PATCH - resend] thermal/drivers/cpu_cooling: Fixup the header and
> copyright
> 
> [PATCH - resend 2/3] thermal/drivers/cpu_cooling: Add Software
> Package
> Data Exchange (SPDX)
> 
> [PATCH - resend 3/3] thermal/drivers/cpu_cooling: Remove pointless
> field
> 
> 
> 
> This one is pending:
> 
> [PATCH] thermal/drivers/of: Add a get_temp_id callback function
> 
> The series [PATCH v3 00/13] QorIQ TMU multi-sensor and HWMON support
> depends on it.
> 
> Hope that helps.
> 
>   -- Daniel
> 
> 
> 
