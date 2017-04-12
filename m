From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5 0/4] BQ24190 charger fixes
Date: Wed, 12 Apr 2017 08:50:18 +0200
Message-ID: <20494385-9c06-1e3b-4e3a-5a1328cd3632@redhat.com>
References: <20170411115957.14253-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753216AbdDLGuU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Apr 2017 02:50:20 -0400
In-Reply-To: <20170411115957.14253-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Hi,

On 11-04-17 13:59, Liam Breck wrote:
> Hi Sebastian,
>
> Here in one patchset are two patches I posted recently, and two more:
>
> Patch 1 is a replacement (as agreed) for
>   "power: supply: bq24190_charger: Don't spam the logs on charger plug / unplug"
> Patch 2 fixes up Hans' extcon patch. If you would like me to squash it with his
>   original patch, let me know.
> Patch 3 (repost) fixes some issues with PM runtime error handling.
> Patch 4 fixes a nit in register_reset().
>
> Changed in v5:
> * move condition in extcon OTG boost code
> * document extcon client invocation of charger driver
> * udelay -> usleep_range in register_reset()
>
> Changes in v4:
> * fix definition of bq24190_reg_poc_chg_config_*
> * revert to if (device_property_read... == 0)

The entire series looks good to me and is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
