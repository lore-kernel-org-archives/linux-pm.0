From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 14/30] thermal/exynos: remove unnecessary header inclusions
Date: Wed, 10 Apr 2013 21:19:01 -0400
Message-ID: <51660F85.4000105@ti.com>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de> <1365638712-1028578-15-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1365638712-1028578-15-git-send-email-arnd@arndb.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

Rui, Arnd,

As agreed in [1], I will be helping on the thermal maintenance.

On 10-04-2013 20:04, Arnd Bergmann wrote:
> In multiplatform configurations, we cannot include headers
> provided by only the exynos platform. Fortunately a number
> of drivers that include those headers do not actually need
> them, so we can just remove the inclusions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-pm@vger.kernel.org
> Cc: Zhang Rui <rui.zhang@intel.com>

This patch looks good to me.

You can add my:
Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>


[1] - http://marc.info/?l=linux-pm&m=136560509922173&w=2
