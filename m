From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH RESEND 1/4] thermal: Use thermal zone device id in
 netlink messages
Date: Wed, 16 Jan 2013 10:43:31 +0800
Message-ID: <1358304211.2252.23.camel@rzhang1-mobl4>
References: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
	 <1357140582-8151-2-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64259 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756013Ab3APCni (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Jan 2013 21:43:38 -0500
In-Reply-To: <1357140582-8151-2-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: durgadoss.r@intel.com, linux-pm@lists.linux-foundation.org, linux-pm@vger.kernel.org

On Wed, 2013-01-02 at 17:29 +0200, Eduardo Valentin wrote:
> This patch changes the function thermal_generate_netlink_event
> to receive a thermal zone device instead of a originator id.
> 
> This way, the messages will always be bound to a thermal zone.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

applied to thermal -next.

thanks,
rui
> ---
>  Documentation/thermal/sysfs-api.txt |    5 +++--
>  drivers/thermal/thermal_sys.c       |    8 ++++++--
>  include/linux/thermal.h             |    6 ++++--
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index 88c0233..526d4b9 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -329,8 +329,9 @@ The framework includes a simple notification mechanism, in the form of a
>  netlink event. Netlink socket initialization is done during the _init_
>  of the framework. Drivers which intend to use the notification mechanism
>  just need to call thermal_generate_netlink_event() with two arguments viz
> -(originator, event). Typically the originator will be an integer assigned
> -to a thermal_zone_device when it registers itself with the framework. The
> +(originator, event). The originator is a pointer to struct thermal_zone_device
> +from where the event has been originated. An integer which represents the
> +thermal zone device will be used in the message to identify the zone. The
>  event will be one of:{THERMAL_AUX0, THERMAL_AUX1, THERMAL_CRITICAL,
>  THERMAL_DEV_FAULT}. Notification can be sent when the current temperature
>  crosses any of the configured thresholds.
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 8c8ce80..d85f51f 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -1711,7 +1711,8 @@ static struct genl_multicast_group thermal_event_mcgrp = {
>  	.name = THERMAL_GENL_MCAST_GROUP_NAME,
>  };
>  
> -int thermal_generate_netlink_event(u32 orig, enum events event)
> +int thermal_generate_netlink_event(struct thermal_zone_device *tz,
> +					enum events event)
>  {
>  	struct sk_buff *skb;
>  	struct nlattr *attr;
> @@ -1721,6 +1722,9 @@ int thermal_generate_netlink_event(u32 orig, enum events event)
>  	int result;
>  	static unsigned int thermal_event_seqnum;
>  
> +	if (!tz)
> +		return -EINVAL;
> +
>  	/* allocate memory */
>  	size = nla_total_size(sizeof(struct thermal_genl_event)) +
>  	       nla_total_size(0);
> @@ -1755,7 +1759,7 @@ int thermal_generate_netlink_event(u32 orig, enum events event)
>  
>  	memset(thermal_event, 0, sizeof(struct thermal_genl_event));
>  
> -	thermal_event->orig = orig;
> +	thermal_event->orig = tz->id;
>  	thermal_event->event = event;
>  
>  	/* send multicast genetlink message */
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index fe82022..e85ac70 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -244,9 +244,11 @@ int thermal_register_governor(struct thermal_governor *);
>  void thermal_unregister_governor(struct thermal_governor *);
>  
>  #ifdef CONFIG_NET
> -extern int thermal_generate_netlink_event(u32 orig, enum events event);
> +extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
> +						enum events event);
>  #else
> -static inline int thermal_generate_netlink_event(u32 orig, enum events event)
> +static int thermal_generate_netlink_event(struct thermal_zone_device *tz,
> +						enum events event)
>  {
>  	return 0;
>  }


