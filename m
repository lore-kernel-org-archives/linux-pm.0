From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal/drivers/hisi: Remove confusing error message
Date: Mon, 4 Dec 2017 17:52:37 -0800
Message-ID: <20171205015231.GC3536@localhost.localdomain>
References: <1499439833-32531-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33062 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbdLEBwl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Dec 2017 20:52:41 -0500
Content-Disposition: inline
In-Reply-To: <1499439833-32531-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Hello,

Catching up on old patches.
On Fri, Jul 07, 2017 at 05:03:52PM +0200, Daniel Lezcano wrote:
> The sensor id is unknown at init time and we use all id in the authorized
> MAX_SENSORS interval to register the sensor. On this SoC there is one
> thermal-zone with one sensor on it. No need to spit on the console everytime we
> failed to register thermal sensors, information which is deliberaly known as it
> is part of the discovery process.
> 
>  hisi_thermal f7030700.tsensor: failed to register sensor id 0: -19
>  hisi_thermal f7030700.tsensor: failed to register thermal sensor: -19
>  hisi_thermal f7030700.tsensor: failed to register sensor id 1: -19
>  hisi_thermal f7030700.tsensor: failed to register thermal sensor: -19
>  hisi_thermal f7030700.tsensor: failed to register sensor id 3: -19
>  hisi_thermal f7030700.tsensor: failed to register thermal sensor: -19
> 
> Remove the error messages

Is this still needed? I am assuming no.
.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/hisi_thermal.c | 12 ++++++------
