From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] cpufreq: s3c64xx: remove incorrect __init annotation
Date: Fri, 16 Dec 2016 18:54:09 +0200
Message-ID: <20161216165409.GA3610@kozik-lap>
References: <20161216090625.2235668-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35410 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161230AbcLPQyQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Dec 2016 11:54:16 -0500
Content-Disposition: inline
In-Reply-To: <20161216090625.2235668-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 16, 2016 at 10:06:15AM +0100, Arnd Bergmann wrote:
> s3c64xx_cpufreq_config_regulator is incorrectly annotated
> as __init, since the caller is also not init:
> 
> WARNING: vmlinux.o(.text+0x92fe1c): Section mismatch in reference from the function s3c64xx_cpufreq_driver_init() to the function .init.text:s3c64xx_cpufreq_config_regulator()
> 
> With modern gcc versions, the function gets inline, so we don't
> see the warning, this only happens with gcc-4.6 and older.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/s3c64xx-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

