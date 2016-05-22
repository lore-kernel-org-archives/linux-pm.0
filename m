From: "Peter Feuerer" <peter@piie.net>
Subject: Re: [PATCH] thermal: check validity get_trip_hyst function
 pointer in bang-bang governor
Date: Sun, 22 May 2016 09:40:01 +0000
Message-ID: <c1da2ef76896167929f6420bf1aff850@mail.piie.net>
References: <1462960147-9175-1-git-send-email-michele.digiorgio@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from piie.net ([80.82.223.85]:36324 "EHLO piie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbcEVJqH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 May 2016 05:46:07 -0400
In-Reply-To: <1462960147-9175-1-git-send-email-michele.digiorgio@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michele Di Giorgio <michele.digiorgio@arm.com>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hi,

14. Mai 2016 13:47 Uhr, "Michele Di Giorgio" <michele.digiorgio@arm.com> schrieb:
> Bang-bang thermal governor uses trip point hysteresis to make decisions.
> Hysteresis is a required property in the device tree for trip points, but it is
> an optional thermal zone device operation. Hence, we need to check whether the
> function pointer is valid or not.
> 
> If it is not available, we assume the hysteresis to be zero. Consequently, a
> highly varying temperature will make the governor continuosly switch a cooling
> device ON and OFF.
> 
> CC: Zhang Rui <rui.zhang@intel.com>
> CC: Eduardo Valentin <edubezval@gmail.com>
> CC: Peter Feuerer <peter@piie.net>
> Signed-off-by: Michele Di Giorgio <michele.digiorgio@arm.com>

Acked-by: Peter Feuerer <peter@piie.net>

Thanks.

-- 
kind regards,
--peter;


> ---
> Using trip_hyst == 0 makes the governor work sensibly but may cause oscillations
> of the control signals of a cooling device. An alternative to this could be to
> fail the registration of the thermal governor.
> 
> Another way would be to set the default value of the hysteresis to x% of the
> trip temperature, to make the governor less sensitive to highly varying inputs.
> 
> drivers/thermal/gov_bang_bang.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
> index 39d1519..bb118a1 100644
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -29,7 +29,13 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
> struct thermal_instance *instance;
> 
> tz->ops->get_trip_temp(tz, trip, &trip_temp);
> - tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
> +
> + if (!tz->ops->get_trip_hyst) {
> + pr_warn_once("Undefined get_trip_hyst for thermal zone %s - "
> + "running with default hysteresis zero\n", tz->type);
> + trip_hyst = 0;
> + } else
> + tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
> 
> dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
> trip, trip_temp, tz->temperature,
> -- 
> 1.9.1
