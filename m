From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 12/12] PM / devfreq: Add opp_notifier_cb() function
 pointer to support OPP notifier
Date: Thu, 24 Aug 2017 12:58:55 +0900
Message-ID: <599E4EFF.6070808@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014300epcas1p3bf35f95d83b2a2ed36126f918638b8fc@epcas1p3.samsung.com>
        <1503538979-22693-13-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58100 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdHXD6z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 23:58:55 -0400
In-reply-to: <1503538979-22693-13-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Dear all,

On 2017년 08월 24일 10:42, Chanwoo Choi wrote:
> The devfreq uses the OPP interface as a mandatory method
> and so the devfreq has to support the OPP notifier in order to
> catch the OPP events. So, this patch adds the new opp_notifier_cb()
> function pointer in the struct devfreq_dev_profile. The user can
> add the their own callback function to receive the OPP events.
> 
> Also, the devfreq provides the default OPP notifeir callback
> in order to remake the frequency table when OPP events happen.
> - default_opp_notifier_cb()
> 
> After merged the commit 0ec09ac2cebe ("PM / devfreq: Set the
> freq_table of devfreq device"), if the freq_table is NULL,
> the devfreq_add_device() makes the freq_table by using OPP interface.
> In this case, the devfreq should handle the freq_table
> when OPP events happen such as OPP_EVENT_REMOVE, OPP_EVENT_ADD.
> 
> When the dev_pm_opp_add/remove() are called, the devfreq core
> has to remake the frequency table with the changed OPP information
> in the default_opp_notifier_cb().
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/devfreq.h   | 12 ++++++++++++
>  2 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7efa867e4aea..d313bed95871 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -163,6 +163,39 @@ static int set_freq_table(struct devfreq *devfreq)
>  	return 0;
>  }
>  
> +static int default_opp_notifier_cb(struct notifier_block *nb,
> +				unsigned long opp_event, void *opp)
> +{
> +	struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
> +	struct devfreq_dev_profile *profile = devfreq->profile;
> +	struct device *dev = devfreq->dev.parent;
> +	int ret = 0;
> +
> +	mutex_lock(&devfreq->lock);
> +
> +	switch (opp_event) {
> +	case OPP_EVENT_ADD:
> +	case OPP_EVENT_REMOVE:
> +		/* Free the frequency table */
> +		profile->max_state = 0;
> +		kfree(dev, profile->freq_table);

It is my mistake when changing from devm_kfree to kfree.
I'll fix on next patchset.


[ditto]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
