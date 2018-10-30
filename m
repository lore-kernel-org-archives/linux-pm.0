From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] thermal: armada: constify thermal_zone_of_device_ops
 structure
Date: Tue, 30 Oct 2018 17:20:43 +0100
Message-ID: <a7cdde4f-6d50-b01c-7dd3-5360b8d0e8cf@linaro.org>
References: <1540912500-21941-1-git-send-email-Julia.Lawall@lip6.fr>
 <1540912500-21941-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540912500-21941-2-git-send-email-Julia.Lawall@lip6.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 30/10/2018 16:14, Julia Lawall wrote:
> The thermal_zone_of_device_ops structure can be const as it is only
> passed as the last argument of devm_thermal_zone_of_sensor_register
> and the corresponding parameter is declared as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/thermal/armada_thermal.c |    2 +-

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
