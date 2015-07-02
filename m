From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/2] thermal: exynos: Remove unused code related to
 platform_data on probe()
Date: Thu, 02 Jul 2015 16:30:46 +0900
Message-ID: <5594E8A6.5020400@samsung.com>
References: <1435819201-30729-1-git-send-email-cw00.choi@samsung.com>
 <1435819201-30729-3-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1435819201-30729-3-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, l.majewski@samsung.com, eduardo.valentin@ti.com, rui.zhang@intel.com
Cc: kgene@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 02.07.2015 15:40, Chanwoo Choi wrote:
> This patch removes the unused code related to struct exynos_tmu_platform_data
> because exynos_tmu_probe() don't handle the struct exynos_tmu_platform_data *pdata.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
