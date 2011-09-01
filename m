From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] OMAP: omap_device: only override _noirq
	methods, not normal suspend/resume
Date: Thu, 1 Sep 2011 18:00:55 +0200
Message-ID: <201109011800.55516.arnd__34380.9594087817$1314930188$gmane$org@arndb.de>
References: <1314229437-31836-1-git-send-email-khilman@ti.com>
	<1314229437-31836-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314229437-31836-2-git-send-email-khilman@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 25 August 2011, Kevin Hilman wrote:
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -622,7 +622,8 @@ static struct dev_pm_domain omap_device_pm_domain = {
>                 SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
>                                    _od_runtime_idle)
>                 USE_PLATFORM_PM_SLEEP_OPS
> -               SET_SYSTEM_SLEEP_PM_OPS(_od_suspend_noirq, _od_resume_noirq)
> +               .suspend_noirq = _od_suspend_noirq,
> +               .resume_noirq = _od_resume_noirq,
>         }
>  };

This breaks if CONFIG_SUSPEND is not set and the _od_suspend_noirq/_od_resume_noirq
functions are not defined.

	Arnd
