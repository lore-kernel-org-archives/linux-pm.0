From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 1/2] PM: devfreq: add freq table and
	available_freqs
Date: Wed, 13 Jun 2012 04:53:47 +0000 (GMT)
Message-ID: <16928680.915361339563225913.JavaMail.weblogic@epml04>
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
Cc: =?euc-kr?Q?=B9=DA=B0=E6=B9=CE?= <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> Devfreq framework don't have a frequency table, add it
> for easy use.
> 
> Signed-off-by: Xiaoguang Chen <chenxg@marvell.com>

If you need a predefined data structure to support frequency table,
you can simply use OPP, which has helper functions implemented in
devfreq subsystem. Is there any reason not to use OPP and to implement
another data structure to store a frequency table attached to a device?


Cheers!
MyungJoo.

> ---
>  drivers/devfreq/devfreq.c |   26 ++++++++++++++++++++++++++
>  include/linux/devfreq.h   |   12 ++++++++++++
>  2 files changed, 38 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 70c31d4..2144200 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -460,6 +460,17 @@ int devfreq_remove_device(struct devfreq *devfreq)
>  	return 0;
>  }
>  
> +/*
> + * devfreq_set_freq_table()- Set frequency table for devfreq
> + * @devfreq	The devfreq instance
> + * @table	The frequency table that device supports
> + */
> +void devfreq_set_freq_table(struct devfreq *devfreq,
> +			    struct devfreq_frequency_table *table)
> +{
> +	devfreq->freq_table = table;
> +}
> +
>  static ssize_t show_governor(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
> @@ -472,6 +483,20 @@ static ssize_t show_freq(struct device *dev,
>  	return sprintf(buf, "%lu\n", to_devfreq(dev)->previous_freq);
>  }
>  
> +static ssize_t show_avail_freq(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	int len = 0, i;
> +	struct devfreq *devfreq = to_devfreq(dev);
> +	if (devfreq->freq_table)
> +		for (i = 0; devfreq->freq_table[i].frequency != DEVFREQ_TABLE_END; i++)
> +			len += sprintf(buf + len, "%lu\n",
> +				       devfreq->freq_table[i].frequency);
> +	if (len == 0)
> +		len += sprintf(buf + len, "No frequency table is provided\n");
> +	return len;
> +}
> +
>  static ssize_t show_polling_interval(struct device *dev,
>  				     struct device_attribute *attr, char *buf)
>  {
> @@ -595,6 +620,7 @@ static struct device_attribute devfreq_attrs[] = {
>  	       store_polling_interval),
>  	__ATTR(min_freq, S_IRUGO | S_IWUSR, show_min_freq, store_min_freq),
>  	__ATTR(max_freq, S_IRUGO | S_IWUSR, show_max_freq, store_max_freq),
> +	__ATTR(available_freqs, S_IRUGO, show_avail_freq, NULL),
>  	{ },
>  };
>  
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 281c72a..e5e4036 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -52,6 +52,14 @@ struct devfreq_dev_status {
>   */
>  #define DEVFREQ_FLAG_LEAST_UPPER_BOUND		0x1
>  
> +#define DEVFREQ_ENTRY_INVALID (~0)
> +#define DEVFREQ_TABLE_END     (~1)
> +
> +struct devfreq_frequency_table {
> +	unsigned int index;
> +	unsigned long frequency;
> +};
> +
>  /**
>   * struct devfreq_dev_profile - Devfreq's user device profile
>   * @initial_freq	The operating frequency when devfreq_add_device() is
> @@ -130,6 +138,7 @@ struct devfreq_governor {
>   *			"devfreq_monitor" executions to reevaluate
>   *			frequency/voltage of the device. Set by
>   *			profile's polling_ms interval.
> + * @freq_table	The frequency table that device supports
>   * @data	Private data of the governor. The devfreq framework does not
>   *		touch this.
>   * @being_removed	a flag to mark that this object is being removed in
> @@ -157,6 +166,7 @@ struct devfreq {
>  	unsigned long polling_jiffies;
>  	unsigned long previous_freq;
>  	unsigned int next_polling;
> +	struct devfreq_frequency_table *freq_table;
>  
>  	void *data; /* private data for governors */
>  
> @@ -180,6 +190,8 @@ extern int devfreq_register_opp_notifier(struct device *dev,
>  					 struct devfreq *devfreq);
>  extern int devfreq_unregister_opp_notifier(struct device *dev,
>  					   struct devfreq *devfreq);
> +extern void devfreq_set_freq_table(struct devfreq *devfreq,
> +				   struct devfreq_frequency_table *table);
>  
>  #ifdef CONFIG_DEVFREQ_GOV_POWERSAVE
>  extern const struct devfreq_governor devfreq_powersave;
> -- 
> 1.7.0.4
> 
