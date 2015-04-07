From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 6/7] thermal: Use bool function return values of
 true/false not 1/0
Date: Tue, 7 Apr 2015 05:43:02 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263014CE7E8@SHSMSX101.ccr.corp.intel.com>
References: <cover.1427736972.git.joe@perches.com>
 <04644fca79a1987084bc46fca59c419fab0a4448.1427736972.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45392 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbbDGFpN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2015 01:45:13 -0400
In-Reply-To: <04644fca79a1987084bc46fca59c419fab0a4448.1427736972.git.joe@perches.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> Sent: Tuesday, March 31, 2015 1:43 AM
> To: linux-kernel@vger.kernel.org; Zhang, Rui; Eduardo Valentin
> Cc: linux-pm@vger.kernel.org
> Subject: [PATCH 6/7] thermal: Use bool function return values of true/false not
> 1/0
> Importance: High
> 
> Use the normal return values for bool functions
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.

Thanks,
rui
> ---
>  drivers/thermal/thermal_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 9e20e4d..749d41a 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -115,7 +115,7 @@ static inline int of_thermal_get_ntrips(struct
> thermal_zone_device *tz)  static inline bool of_thermal_is_trip_valid(struct
> thermal_zone_device *tz,
>  					    int trip)
>  {
> -	return 0;
> +	return false;
>  }
>  static inline const struct thermal_trip *  of_thermal_get_trip_points(struct
> thermal_zone_device *tz)
> --
> 2.1.2

