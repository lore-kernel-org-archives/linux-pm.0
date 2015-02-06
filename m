From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] drivers/base: Remove unnecessary OOM message
Date: Fri, 6 Feb 2015 21:58:52 +0100
Message-ID: <20150206205852.GA14126@amd>
References: <20150206153912.GA8486@sloth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150206153912.GA8486@sloth>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Lambert <lambert.quentin@gmail.com>
Cc: Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 2015-02-06 16:39:12, Quentin Lambert wrote:
> This patch fix checkpatch warnings concerning the possible
> duplication of an "out of memory" message.

So, instead of nice and readable "not enough memory for clock..." we
get OOM, stackdump, and backtrace...? Not sure it is improvement.

							Pavel

> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -81,10 +81,8 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
>  		return -EINVAL;
>  
>  	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
> -	if (!ce) {
> -		dev_err(dev, "Not enough memory for clock entry.\n");
> +	if (!ce)
>  		return -ENOMEM;
> -	}
>  
>  	if (con_id) {
>  		ce->con_id = kstrdup(con_id, GFP_KERNEL);
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 15bf299..677fb28 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -474,10 +474,8 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
>  
>  	/* allocate new OPP node */
>  	new_opp = kzalloc(sizeof(*new_opp), GFP_KERNEL);
> -	if (!new_opp) {
> -		dev_warn(dev, "%s: Unable to create new OPP node\n", __func__);
> +	if (!new_opp)
>  		return -ENOMEM;
> -	}
>  
>  	/* Hold our list modification lock here */
>  	mutex_lock(&dev_opp_list_lock);
> @@ -695,10 +693,8 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
>  
>  	/* keep the node allocated */
>  	new_opp = kmalloc(sizeof(*new_opp), GFP_KERNEL);
> -	if (!new_opp) {
> -		dev_warn(dev, "%s: Unable to create OPP\n", __func__);
> +	if (!new_opp)
>  		return -ENOMEM;
> -	}
>  
>  	mutex_lock(&dev_opp_list_lock);
>  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
