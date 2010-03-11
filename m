From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: pm_wakeup - switch to using bool
Date: Fri, 12 Mar 2010 00:41:09 +0100
Message-ID: <201003120041.09126.rjw@sisk.pl>
References: <20100311073806.GA14323@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100311073806.GA14323@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 11 March 2010, you wrote:
> Also change couple of stubs implemented as macros in !OCNFIG_PM case in
> statinc inline functions to provide proper typechecking of arguments
> regardless of config.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
> Rafael, any reason why this would be a bad idea?

Not that I know of.

> Seems to compile for me with both CONFIG_PM and !CONFIG_PM...

I'm going to queue it up for .35.

Thanks,
Rafael


>  include/linux/pm_wakeup.h |   38 ++++++++++++++++++++++++--------------
>  1 files changed, 24 insertions(+), 14 deletions(-)
> 
> 
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 0aae777..22d64c1 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -25,32 +25,34 @@
>  # error "please don't include this file directly"
>  #endif
>  
> +#include <linux/types.h>
> +
>  #ifdef CONFIG_PM
>  
>  /* changes to device_may_wakeup take effect on the next pm state change.
>   * by default, devices should wakeup if they can.
>   */
> -static inline void device_init_wakeup(struct device *dev, int val)
> +static inline void device_init_wakeup(struct device *dev, bool val)
>  {
> -	dev->power.can_wakeup = dev->power.should_wakeup = !!val;
> +	dev->power.can_wakeup = dev->power.should_wakeup = val;
>  }
>  
> -static inline void device_set_wakeup_capable(struct device *dev, int val)
> +static inline void device_set_wakeup_capable(struct device *dev, bool capable)
>  {
> -	dev->power.can_wakeup = !!val;
> +	dev->power.can_wakeup = capable;
>  }
>  
> -static inline int device_can_wakeup(struct device *dev)
> +static inline bool device_can_wakeup(struct device *dev)
>  {
>  	return dev->power.can_wakeup;
>  }
>  
> -static inline void device_set_wakeup_enable(struct device *dev, int val)
> +static inline void device_set_wakeup_enable(struct device *dev, bool enable)
>  {
> -	dev->power.should_wakeup = !!val;
> +	dev->power.should_wakeup = enable;
>  }
>  
> -static inline int device_may_wakeup(struct device *dev)
> +static inline bool device_may_wakeup(struct device *dev)
>  {
>  	return dev->power.can_wakeup && dev->power.should_wakeup;
>  }
> @@ -58,20 +60,28 @@ static inline int device_may_wakeup(struct device *dev)
>  #else /* !CONFIG_PM */
>  
>  /* For some reason the next two routines work even without CONFIG_PM */
> -static inline void device_init_wakeup(struct device *dev, int val)
> +static inline void device_init_wakeup(struct device *dev, bool val)
>  {
> -	dev->power.can_wakeup = !!val;
> +	dev->power.can_wakeup = val;
>  }
>  
> -static inline void device_set_wakeup_capable(struct device *dev, int val) { }
> +static inline void device_set_wakeup_capable(struct device *dev, bool capable)
> +{
> +}
>  
> -static inline int device_can_wakeup(struct device *dev)
> +static inline bool device_can_wakeup(struct device *dev)
>  {
>  	return dev->power.can_wakeup;
>  }
>  
> -#define device_set_wakeup_enable(dev, val)	do {} while (0)
> -#define device_may_wakeup(dev)			0
> +static inline void device_set_wakeup_enable(struct device *dev, bool enable)
> +{
> +}
> +
> +static inline bool device_may_wakeup(struct device *dev)
> +{
> +	return false;
> +}
>  
>  #endif /* !CONFIG_PM */
>  
> 
