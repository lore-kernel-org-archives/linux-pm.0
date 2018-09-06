From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 0/6] shutdown procedure verification for SAMA5D2
Date: Thu, 6 Sep 2018 11:54:29 +0200
Message-ID: <7098e5f1-aa97-1b82-abbc-2c069d6be9cb@microchip.com>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>, alexandre.belloni@bootlin.com, linux@armlinux.org.uk, sre@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 30/08/2018 at 13:50, Claudiu Beznea wrote:
> Hi,
> 
> Patch 1 from this series implement a fix for shutdown procedure
> for SAMA5D2.
> 
> The rest of the patch are improvements as follows:
> patch 2 - use only one function for poweroff
> patches 3-6 - cosmetic improvements

For the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> The patches are based on latest sys-reset/for-next [1].
> 
> Thank you,
> Claudiu Beznea
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
> 
> Claudiu Beznea (6):
>    power: reset: at91-poweroff: switch to slow clock before shutdown
>    power: reset: at91-poweroff: use only one poweroff function
>    power: reset: at91-poweroff: make mpddrc_base part of struct shdwc
>    power: reset: at91-poweroff: make sclk part of struct shdwc
>    power: reset: at91-poweroff: rename at91_shdwc_base member of struct
>      shdwc
>    power: reset: at91-poweroff: do not procede if at91_shdwc is allocated
> 
>   arch/arm/mach-at91/pm_suspend.S          |   8 +++
>   drivers/power/reset/at91-sama5d2_shdwc.c | 119 +++++++++++++++++++++----------
>   2 files changed, 88 insertions(+), 39 deletions(-)
> 


-- 
Nicolas Ferre
