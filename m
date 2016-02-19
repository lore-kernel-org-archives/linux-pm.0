From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/3] thermal: exynos: Use devm_regulator_get_optional() for
 vtmu
Date: Fri, 19 Feb 2016 09:33:03 +0900
Message-ID: <56C662BF.5080903@samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
 <1455819551-4666-3-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1455819551-4666-3-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 19.02.2016 03:19, Javier Martinez Canillas wrote:
> The Exynos TMU DT binding says that the vtmu-supply is optional but the
> driver uses devm_regulator_get() that creates a dummy regulator if it's
> not defined in the DT. For example the following message is in the log:
> 
> 10060000.tmu supply vtmu not found, using dummy regulator
> 
> Use the optional version of regulator_get() that doesn't create a dummy
> regulator and instead returns a -ENODEV errno code. Since it's expected
> that a regulator may not be defined and the driver will inform about it:
> 
> exynos-tmu 10060000.tmu: Regulator node (vtmu) not found
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/thermal/samsung/exynos_tmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
