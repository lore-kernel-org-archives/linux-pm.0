From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] I2C: runtime: Fix checks which make legacy
	suspend to never get called
Date: Tue, 28 Sep 2010 23:45:26 +0200
Message-ID: <201009282345.26363.rjw__37427.6326424026$1285710403$gmane$org@sisk.pl>
References: <1285602360-21180-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285602360-21180-1-git-send-email-rnayak@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, September 27, 2010, Rajendra Nayak wrote:
> For devices which are not adapted to runtime PM a call to
> pm_runtime_suspended always returns true.
> 
> Hence the pm_runtime_suspended checks below prevent legacy
> suspend from getting called.
> 
> So do a pm_runtime_suspended check only for devices with a
> dev_pm_ops populated (which hence do not rely on the legacy
> suspend)

Makes sense.

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  drivers/i2c/i2c-core.c |   44 ++++++++++++++++++++++++--------------------
>  1 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 6649176..712086f 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -197,11 +197,12 @@ static int i2c_device_pm_suspend(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> -	if (pm_runtime_suspended(dev))
> -		return 0;
> -
> -	if (pm)
> -		return pm->suspend ? pm->suspend(dev) : 0;
> +	if (pm) {
> +		if (pm_runtime_suspended(dev))
> +			return 0;
> +		else
> +			return pm->suspend ? pm->suspend(dev) : 0;
> +	}
>  
>  	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
>  }
> @@ -229,11 +230,12 @@ static int i2c_device_pm_freeze(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> -	if (pm_runtime_suspended(dev))
> -		return 0;
> -
> -	if (pm)
> -		return pm->freeze ? pm->freeze(dev) : 0;
> +	if (pm) {
> +		if (pm_runtime_suspended(dev))
> +			return 0;
> +		else
> +			return pm->freeze ? pm->freeze(dev) : 0;
> +	}
>  
>  	return i2c_legacy_suspend(dev, PMSG_FREEZE);
>  }
> @@ -242,11 +244,12 @@ static int i2c_device_pm_thaw(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> -	if (pm_runtime_suspended(dev))
> -		return 0;
> -
> -	if (pm)
> -		return pm->thaw ? pm->thaw(dev) : 0;
> +	if (pm) {
> +		if (pm_runtime_suspended(dev))
> +			return 0;
> +		else
> +			return pm->thaw ? pm->thaw(dev) : 0;
> +	}
>  
>  	return i2c_legacy_resume(dev);
>  }
> @@ -255,11 +258,12 @@ static int i2c_device_pm_poweroff(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> -	if (pm_runtime_suspended(dev))
> -		return 0;
> -
> -	if (pm)
> -		return pm->poweroff ? pm->poweroff(dev) : 0;
> +	if (pm) {
> +		if (pm_runtime_suspended(dev))
> +			return 0;
> +		else
> +			return pm->poweroff ? pm->poweroff(dev) : 0;
> +	}
>  
>  	return i2c_legacy_suspend(dev, PMSG_HIBERNATE);
>  }
> 
