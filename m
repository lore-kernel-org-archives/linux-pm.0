From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PowerCap: Fix mode for energy counter
Date: Thu, 05 Dec 2013 02:27:26 +0100
Message-ID: <1932191.gZoa77HKas@vostro.rjw.lan>
References: <1386184379-26220-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64854 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756367Ab3LEBO2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2013 20:14:28 -0500
In-Reply-To: <1386184379-26220-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Wednesday, December 04, 2013 11:12:59 AM Srinivas Pandruvada wrote:
> As per the documentation of powercap sysfs, energy_uj field is read only,
> if it can't be reset. Currently it always allows write but will fail,
> if there is no reset callback.
> Changing mode field, to read only if there is no reset callback.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reported-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

Queued up for the next PM pull request.

Thanks,
Rafael


> ---
>  drivers/powercap/powercap_sys.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> index 8d0fe43..84419af 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -377,9 +377,14 @@ static void create_power_zone_common_attributes(
>  	if (power_zone->ops->get_max_energy_range_uj)
>  		power_zone->zone_dev_attrs[count++] =
>  					&dev_attr_max_energy_range_uj.attr;
> -	if (power_zone->ops->get_energy_uj)
> +	if (power_zone->ops->get_energy_uj) {
> +		if (power_zone->ops->reset_energy_uj)
> +			dev_attr_energy_uj.attr.mode = S_IWUSR | S_IRUGO;
> +		else
> +			dev_attr_energy_uj.attr.mode = S_IRUGO;
>  		power_zone->zone_dev_attrs[count++] =
>  					&dev_attr_energy_uj.attr;
> +	}
>  	if (power_zone->ops->get_power_uw)
>  		power_zone->zone_dev_attrs[count++] =
>  					&dev_attr_power_uw.attr;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
