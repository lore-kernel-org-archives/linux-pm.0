From: Chris Diamand <chris.diamand@arm.com>
Subject: Re: [PATCH] PM / devfreq: Don't delete sysfs group twice
Date: Wed, 14 Dec 2016 11:32:39 +0000
Message-ID: <20161214113239.GA10108@e107465-lin.cambridge.arm.com>
References: <CGME20161213171211epcas3p3ed8807883967daca28b7abe211446739@epcas3p3.samsung.com>
 <20161213170935.GA4661@e107465-lin.cambridge.arm.com>
 <5850A286.9080302@samsung.com>
 <5850B30A.20701@samsung.com>
 <420ba56f-70be-0735-ad99-d90dd04113c5@arm.com>
 <172e4f85358b4f4e9206c4a54b5db056@AM4PR0802MB2210.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932531AbcLNLcp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Dec 2016 06:32:45 -0500
Content-Disposition: inline
In-Reply-To: <172e4f85358b4f4e9206c4a54b5db056@AM4PR0802MB2210.eurprd08.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Nishanth Menon <nm@ti.com>, Cai Zhiyong <caizhiyong@huawei.com>, "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>

Hi all,

Thanks for your replies.

> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 8a456dd55a8d..3e9eb7fa9e72 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -488,10 +488,6 @@ static void _remove_devfreq(struct devfreq *devfreq)
>         list_del(&devfreq->node);
>         mutex_unlock(&devfreq_list_lock);
>  
> -       if (devfreq->governor)
> -               devfreq->governor->event_handler(devfreq,
> -                                                DEVFREQ_GOV_STOP, NULL);
> -
>         if (devfreq->profile->exit)
>                 devfreq->profile->exit(devfreq->dev.parent);

I was thinking of removing this too, but wasn't completely sure - is there
any situation where the devfreq feature's reference count would go to 0,
*without* going via devfreq_remove_device()?

If there is, we might need to keep it, although the userspace governor would
still be broken for those cases.

The one case I can think of is if there's an error in devfreq_add_device(),
where it calls device_unregister() directly. Except I think we're OK here,
because the governor won't have started yet.

Cheers,
Chris
