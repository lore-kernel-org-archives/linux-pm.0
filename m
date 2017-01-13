From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2] PM / devfreq: Don't delete sysfs group twice
Date: Fri, 13 Jan 2017 09:18:39 +0900
Message-ID: <58781CDF.5090308@samsung.com>
References: <CGME20170112145810epcas2p359a78f92ce8bd256a8f09c6e9c211cf1@epcas2p3.samsung.com>
 <1484233061-22516-1-git-send-email-chris.diamand@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58908 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbdAMAsm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2017 19:48:42 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OJO01CTQZJ4P450@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 13 Jan 2017 09:18:40 +0900 (KST)
In-reply-to: <1484233061-22516-1-git-send-email-chris.diamand@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: chris.diamand@arm.com, linux-pm@vger.kernel.org
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Nishanth Menon <nm@ti.com>, Cai Zhiyong <caizhiyong@huawei.com>, "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>

Hi Chris,

Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

On 2017년 01월 12일 23:57, chris.diamand@arm.com wrote:
> From: Chris Diamand <chris.diamand@arm.com>
> 
> The 'userspace' governor adds a sysfs entry, which is removed when
> the governor is changed, or the devfreq device is released. However,
> when the latter occurs via device_unregister(), device_del() is
> called first, which removes the sysfs entries recursively and deletes
> the kobject.
> 
> This means we get an Oops when the governor calls
> sysfs_remove_group() on the deleted kobject. Fix this by only doing
> the call when kobj *hasn't* been kobject_del()'d.
> 
> Note that we can't just remove the call to sysfs_remove_group()
> entirely - it's needed for when the governor is changed to one which
> doesn't need a sysfs entry.
> 
> Signed-off-by: Chris Diamand <chris.diamand@arm.com>
> ---
> Hi all - this is a resend of my updated devfreq removal fix.
> 
> This takes a different approach to v1, and fixes the issue in the governor
> instead. This means reference counting should still work as usual, so anything
> which doesn't call devfreq_remove_device() should still work.
> 
> Cheers!
> Chris
> 
>  drivers/devfreq/governor_userspace.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 35de6e8..9db4d6f 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -112,7 +112,13 @@ static int userspace_init(struct devfreq *devfreq)
>  
>  static void userspace_exit(struct devfreq *devfreq)
>  {
> -	sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
> +	/*
> +	 * Remove the sysfs entry, unless this is being called after
> +	 * device_del(), which should have done this already via kobject_del().
> +	 */
> +	if (devfreq->dev.kobj.sd)
> +		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
> +
>  	kfree(devfreq->data);
>  	devfreq->data = NULL;
>  }
> 


-- 
Best Regards,
Chanwoo Choi
S/W Center, Samsung Electronics
