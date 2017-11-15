From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: imx6q/thermal: imx: move CPU cooling device
 from thermal to cpufreq
Date: Wed, 15 Nov 2017 14:55:49 +0530
Message-ID: <20171115092549.GK3257@vireshk-i7>
References: <20171115092332.9320-1-bst@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:56048 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757302AbdKOJZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 04:25:52 -0500
Received: by mail-pg0-f65.google.com with SMTP id 207so14787874pgc.12
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2017 01:25:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171115092332.9320-1-bst@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bastian Stender <bst@pengutronix.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de

Please make sure you add version history and correct version number in
$Subject next time. You must have added V2 in subject here.

On 15-11-17, 10:23, Bastian Stender wrote:
> The cooling device should be part of the i.MX cpufreq driver. So move
> it there.
> 
> Use of_cpufreq_power_cooling_register to link the cooling device to the
> device tree node provided.
> 
> This makes it possible to bind the cpufreq cooling device to a custom
> thermal zone via a cooling-maps entry like:
> 
> 	cooling-maps {
> 		map0 {
> 			trip = <&board_alert>;
> 			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 		};
> 	};
> 
> Assuming a cpu node exists with label "cpu0" and #cooling-cells
> property.
> 
> Signed-off-by: Bastian Stender <bst@pengutronix.de>
> ---

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
