From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Sun, 28 May 2017 21:16:19 +0200
Message-ID: <20170528191619.GA20159@xo-6d-61-c0.localdomain>
References: <20170430182727.24412-1-contact@paulk.fr>
 <20170430182727.24412-5-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36136 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdE1TQ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 May 2017 15:16:27 -0400
Content-Disposition: inline
In-Reply-To: <20170430182727.24412-5-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>

Hi!

> The status reported directly by the battery controller is not always
> reliable and should be corrected based on the current draw information.
> 
> This implements such a correction with a dedicated function, called
> when retrieving the supply status.
> 

> @@ -1182,6 +1196,8 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
>  		else
>  			status = POWER_SUPPLY_STATUS_DISCHARGING;
>  	} else {
> +		curr = (int)((s16)curr) * 1000;

Umm.

> @@ -1190,6 +1206,18 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
>  			status = POWER_SUPPLY_STATUS_CHARGING;
>  	}
>  
> +
> +	if (curr == 0 && status != POWER_SUPPLY_STATUS_NOT_CHARGING)
> +		status = POWER_SUPPLY_STATUS_FULL;
> +
> +	if (status == POWER_SUPPLY_STATUS_FULL) {
> +		/* Drawing or providing current when full */
> +		if (curr > 0)
> +			status = POWER_SUPPLY_STATUS_CHARGING;
> +		else if (curr < 0)
> +			status = POWER_SUPPLY_STATUS_DISCHARGING;
> +	}

Are you sure this works? On N900, we normally see small currents to/from "full" battery.

Should the test be for absolute_value(curr) < something rather than for == 0?

What hw did you test it on?
										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
