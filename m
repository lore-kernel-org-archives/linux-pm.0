From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: Fix compiler warning
Date: Mon, 25 Mar 2013 16:12:20 +0800
Message-ID: <1364199140.2465.43.camel@rzhang1-mobl4>
References: <1363815487-7191-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62860 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756714Ab3CYIMX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 04:12:23 -0400
In-Reply-To: <1363815487-7191-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org

On Wed, 2013-03-20 at 18:38 -0300, Ezequiel Garcia wrote:
> The following warning is obtained when CONFIG_NET is not defined:
> 
> In file included from drivers/thermal/mvebu_thermal.c:27:0:
> include/linux/thermal.h:254:12: warning: 'thermal_generate_netlink_event'
> defined but not used [-Wunused-function]
> 
> This patch fixes the warning by properly inlining
> thermal_generate_netlink_event().
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

applied to thermal -next.

thanks,
rui
> ---
>  include/linux/thermal.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f0bd7f9..fd7b8f3 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -251,7 +251,7 @@ void thermal_unregister_governor(struct thermal_governor *);
>  extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>  						enum events event);
>  #else
> -static int thermal_generate_netlink_event(struct thermal_zone_device *tz,
> +static inline int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>  						enum events event)
>  {
>  	return 0;


