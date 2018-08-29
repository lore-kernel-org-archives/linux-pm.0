From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Add new name attribute for sysfs
Date: Wed, 29 Aug 2018 14:50:46 +0200
Message-ID: <3263263.FggQa7iA9D@amdc3058>
References: <CGME20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122@epcas1p2.samsung.com>
        <1535528046-18835-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <1535528046-18835-1-git-send-email-cw00.choi@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi Chanwoo,

On Wednesday, August 29, 2018 04:34:06 PM Chanwoo Choi wrote:
> commit 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for
> sysfs") changed the node name to devfreq(x). After this commit, it is not
> possible to get the device name through /sys/class/devfreq/devfreq(X)/*.
> 
> Add new name attribute in order to get device name.

Could you please describe the issue encountered in more detail
(what the old device name is needed for)?
 
> Cc: stable@vger.kernel.org
> Fixes: 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for sysfs")
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 11 +++++++++++
>  include/linux/devfreq.h   |  3 +++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4c49bb1330b5..2145563d5ee5 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -620,6 +620,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	}
>  	devfreq->max_freq = devfreq->scaling_max_freq;
> 
> +	devfreq->name = dev_name(devfreq->dev.parent);

It seems that 'dev' can be used instead of 'devfreq->dev.parent'.

> +	if (IS_ERR_OR_NULL(devfreq->name))

Error values are not encoded into pointer returned by dev_name()
(drivers/base/ code is only checking for pointer being NULL).

> +		return -EINVAL;

This leaks 'devfreq' object and doesn't encode return value into
pointer returned by devfreq_add_device(), it should be replaced by:

	err = -EINVAL;
	goto err_dev;

>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
>  	err = device_register(&devfreq->dev);

Best regards,
