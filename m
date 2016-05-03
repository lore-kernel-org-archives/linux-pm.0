From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 4/4] thermal: update documentation for new device ops
Date: Mon, 2 May 2016 20:27:11 -0700
Message-ID: <20160503032710.GB18752@localhost.localdomain>
References: <1459298497-29481-1-git-send-email-srikars@nvidia.com>
 <1459298497-29481-5-git-send-email-srikars@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36109 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252AbcECD1P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 23:27:15 -0400
Content-Disposition: inline
In-Reply-To: <1459298497-29481-5-git-send-email-srikars@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srikar Srimath Tirumala <srikars@nvidia.com>
Cc: rui.zhang@intel.com, srinivas.pandruvada@intel.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, mlongnecker@nvidia.com

On Tue, Mar 29, 2016 at 05:41:37PM -0700, Srikar Srimath Tirumala wrote:
> Add documentation for two new thermal_zone_device_ops.
> 
> Change-Id: Id1c5cc2ae4051a398dfe81c7ff0b27c1eab02579
> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
> ---
>  Documentation/thermal/sysfs-api.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index ed419d6..13344167 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -59,6 +59,11 @@ temperature) and throttle appropriate devices.
>  			will be fired.
>  	.set_emul_temp: set the emulation temperature which helps in debugging
>  			different threshold temperature points.
> +	.get_trip_state: get the current state (TRIPPED or NOT_TRIPPED) of a
> +		certain trip point.
> +	.set_trip_state: set the state of a certain trip point.
> +	.enb_temp_notify: check if temperature notifications are enabled for a
> +		certain trip point.

I would prefer we merge this to the patch which is adding them.

>      tzp: thermal zone platform parameters.
>      passive_delay: number of milliseconds to wait between polls when
>  	performing passive cooling.
> -- 
> 2.1.4
> 
