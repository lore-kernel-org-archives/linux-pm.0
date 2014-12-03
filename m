From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] media / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Wed, 03 Dec 2014 12:24:26 +0100
Message-ID: <547EF2EA.70309@samsung.com>
References: <4139875.fkJ48z9AaU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4139875.fkJ48z9AaU@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-media@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, Kamil Debski <k.debski@samsung.com>, Philipp Zabel <p.zabel@pengutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 03/12/14 03:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
> 
> The alternative of CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME may be
> replaced with CONFIG_PM too.
> 
> Make these changes everywhere under drivers/media/.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

> ---
> 
> Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
> PM_SLEEP is selected) which is only in linux-next at the moment (via the
> linux-pm tree).
> 
> Please let me know if it is OK to take this one into linux-pm.

I'm fine with this being merged through linux-pm as far as the exynos/s5p
drivers are concerned.

> ---
>  drivers/media/platform/coda/coda-common.c       |    4 ++--
>  drivers/media/platform/exynos4-is/fimc-core.c   |    6 +++---
>  drivers/media/platform/exynos4-is/fimc-is-i2c.c |    2 +-
>  drivers/media/platform/exynos4-is/fimc-lite.c   |    2 +-
>  drivers/media/platform/exynos4-is/mipi-csis.c   |    2 +-
>  drivers/media/platform/s5p-jpeg/jpeg-core.c     |    4 ++--
>  drivers/media/platform/s5p-mfc/s5p_mfc.c        |    2 +-
>  drivers/media/platform/s5p-mfc/s5p_mfc_pm.c     |   10 ++++------
>  8 files changed, 15 insertions(+), 17 deletions(-)

--
Regards,
Sylwester
