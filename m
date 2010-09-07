From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: lenient generic runtime pm callbacks
Date: Tue, 07 Sep 2010 15:56:39 -0700
Message-ID: <87vd6hf9i0.fsf@deeprootsystems.com>
References: <1283811642-18837-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1283811642-18837-1-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Tue, 7 Sep 2010 01:20:42 +0300")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-pm@lists.linux-foundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org

Ohad Ben-Cohen <ohad@wizery.com> writes:

> Allow drivers, that belong to subsystems which use the generic
> runtime pm callbacks, not to define runtime pm suspend/resume handlers,
> by implicitly assuming success in such cases.
>
> This is needed to eliminate nop handlers that would otherwise be
> necessary by drivers which enable runtime pm, but don't need
> to do anything when their devices are runtime-suspended/resumed.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

for runtime PM of on-chip devices on OMAP, this will cleanup several nop
handlers we have had to put in place.

FWIW, the 'no_callbacks' approach won't work for runtime PM of on-chip
devices for us since most of the devices will have callbacks, only some
will not need them.

Kevin

> ---
>  drivers/base/power/generic_ops.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
> index 4b29d49..81f2c84 100644
> --- a/drivers/base/power/generic_ops.c
> +++ b/drivers/base/power/generic_ops.c
> @@ -46,7 +46,7 @@ int pm_generic_runtime_suspend(struct device *dev)
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  	int ret;
>  
> -	ret = pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : -EINVAL;
> +	ret = pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : 0;
>  
>  	return ret;
>  }
> @@ -65,7 +65,7 @@ int pm_generic_runtime_resume(struct device *dev)
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  	int ret;
>  
> -	ret = pm && pm->runtime_resume ? pm->runtime_resume(dev) : -EINVAL;
> +	ret = pm && pm->runtime_resume ? pm->runtime_resume(dev) : 0;
>  
>  	return ret;
>  }
