From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 2/2] PM / OPP: check for existing OPP list when initialising
 from device tree
Date: Wed, 31 Jul 2013 11:39:45 -0500
Message-ID: <51F93DD1.6030901@ti.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47509 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756811Ab3GaQjw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 31 Jul 2013 12:39:52 -0400
In-Reply-To: <1375207217-4433-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 07/30/2013 01:00 PM, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>
> CPUs are registered as devices and their OPPs can be initialised from
> the device tree. Whenever CPUs can be hotplugged out, the corresponding
> cpu devices are not removed. As a result all their OPPs remain intact
> even when they are offlined.
>
> But when they are hotplugged back-in, the cpufreq along with other cpu
> related subsystem gets re-initialised. Since its almost same as secondary
> cpu being brought up, no special consideration is taken in the hotplug
> path. This may result in cpufreq trying to initialise the OPPs again though
> the cpu device already contains the OPPs.
>
> This patch checks if there exist an OPP list associated with the device,
> before attempting to initialise it.
>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>   drivers/base/power/opp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 9ac3c93..8a9d138 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -708,9 +708,15 @@ int of_init_opp_table(struct device *dev)
>   {
>   	const struct property *prop;
>   	struct device_node *opp_node;
> +	struct device_opp *dev_opp;
>   	const __be32 *val;
>   	int nr;
>
> +	/* Check for existing list for 'dev' */
> +	dev_opp = find_device_opp(dev);
> +	if (!IS_ERR(dev_opp))
> +		return -EEXIST; /* Device OPP already initialized */
> +
>   	opp_node = of_parse_phandle(dev->of_node,
>   					"operating-points-phandle", 0);
>   	if (!opp_node) /* if no OPP phandle, search for OPPs in current node */
>

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
