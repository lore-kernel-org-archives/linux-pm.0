From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after a cooling
 device registered
Date: Mon, 28 Sep 2015 15:29:09 +0100
Message-ID: <20150928142902.GA9175@e104805>
References: <1443332924-14028-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:30287 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933318AbbI1O3N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2015 10:29:13 -0400
Content-Disposition: inline
In-Reply-To: <1443332924-14028-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Sun, Sep 27, 2015 at 06:48:44AM +0100, Chen Yu wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> When a new cooling device is registered, we need to update the
> thermal zone to set the new registered cooling device to a proper
> state.
> 
> This fixes a problem that the system is cool, while the fan devices
> are left running on full speed after boot, if fan device is registered
> after thermal zone device.
> 
> CC: <stable@vger.kernel.org> #3.18+
> Reference:https://bugzilla.kernel.org/show_bug.cgi?id=92431
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: szegad <szegadlo@poczta.onet.pl>
> Tested-by: prash <prash.n.rao@gmail.com>
> Tested-by: amish <ammdispose-arch@yahoo.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/thermal/thermal_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index c3bdb48..09c78a4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1450,6 +1450,7 @@ __thermal_cooling_device_register(struct device_node *np,
>  				  const struct thermal_cooling_device_ops *ops)
>  {
>  	struct thermal_cooling_device *cdev;
> +	struct thermal_instance *pos, *next;
>  	int result;
>  
>  	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> @@ -1494,6 +1495,15 @@ __thermal_cooling_device_register(struct device_node *np,
>  	/* Update binding information for 'this' new cdev */
>  	bind_cdev(cdev);
>  

I think you need to hold cdev->lock here, to make sure that no thermal
zone is added or removed from cdev->thermal_instances while you are looping.

> +	list_for_each_entry_safe(pos, next, &cdev->thermal_instances, cdev_node) {

Why list_for_each_entry_safe() ?  You are not going to remove any
entry, so you can just use list_for_each_entry()

> +			if (next->cdev_node.next == &cdev->thermal_instances) {
> +				thermal_zone_device_update(next->tz);
> +				break;
> +			}
> +			if (pos->tz != next->tz)
> +				thermal_zone_device_update(pos->tz);
> +	}

Why is this so complicated?  Can't you just do:

	list_for_each_entry(pos, &cdev->thermal_instances, cdev_node)
        	thermal_zone_device_update(pos->tz);

Cheers,
Javi
