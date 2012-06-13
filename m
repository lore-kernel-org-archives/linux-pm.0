From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 2/2] PM: Devfreq: Add frequency get function
	in profile
Date: Wed, 13 Jun 2012 04:57:36 +0000 (GMT)
Message-ID: <1290271.915811339563455292.JavaMail.weblogic@epml04>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
MIME-version: 1.0
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Xiaoguang Chen <chenxg@marvell.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: =?euc-kr?Q?=B9=DA=B0=E6=B9=CE?= <kyungmin.park@samsung.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> when devfreq set one frequency, the final frequency may not
> the same as the requested frequency. Add get function in profile
> to let devfreq driver return the final frequency.
> 
> Signed-off-by: Xiaoguang Chen <chenxg@marvell.com>

That is why in update_freq() function that you've modified uses:

err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);

not

err = devfreq->profile->target(devfreq->dev.parent, freq, flags);

The target function will return the configured frequency right there.
Calling "__devfreq_get()" at the same location wouldn't help as long as
the "target()" callback is implemented correctly.



Cheers!
MyungJoo

> ---
>  drivers/devfreq/devfreq.c |   12 +++++++++++-
>  include/linux/devfreq.h   |    2 ++
>  2 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2144200..50a4fc0 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -72,6 +72,16 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>  	return ERR_PTR(-ENODEV);
>  }
>  
> +static unsigned long __devfreq_get(struct device *dev)
> +{
> +	struct devfreq *devfreq = to_devfreq(dev);
> +	unsigned long ret_freq = devfreq->previous_freq;
> +	if (!devfreq->profile->get)
> +		return ret_freq;
> +	ret_freq = devfreq->profile->get(devfreq->dev.parent);
> +	return ret_freq;
> +}
> +
>  /**
>   * update_devfreq() - Reevaluate the device and configure frequency.
>   * @devfreq:	the devfreq instance.
> @@ -116,7 +126,7 @@ int update_devfreq(struct devfreq *devfreq)
>  	if (err)
>  		return err;
>  
> -	devfreq->previous_freq = freq;
> +	devfreq->previous_freq = __devfreq_get(&devfreq->dev);
>  	return err;
>  }
>  
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index e5e4036..f789314 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -65,6 +65,7 @@ struct devfreq_frequency_table {
>   * @initial_freq	The operating frequency when devfreq_add_device() is
>   *			called.
>   * @polling_ms		The polling interval in ms. 0 disables polling.
> + * @get			Get the devices's actual frequency
>   * @target		The device should set its operating frequency at
>   *			freq or lowest-upper-than-freq value. If freq is
>   *			higher than any operable frequency, set maximum.
> @@ -84,6 +85,7 @@ struct devfreq_dev_profile {
>  	unsigned long initial_freq;
>  	unsigned int polling_ms;
>  
> +	unsigned long	(*get)(struct device *dev);
>  	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
>  	int (*get_dev_status)(struct device *dev,
>  			      struct devfreq_dev_status *stat);
> -- 
> 1.7.0.4
