From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
Date: Tue, 6 Nov 2018 22:09:33 +0100
Message-ID: <20181106210933.GU24212@piout.net>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: sre@kernel.org, Nicolas.Ferre@microchip.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Claudiu,

On 05/11/2018 11:14:26+0000, Claudiu.Beznea@microchip.com wrote:
>  static int __init at91_poweroff_probe(struct platform_device *pdev)
> @@ -154,16 +160,22 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
>  	u32 ddr_type;
>  	int ret;
>  
> +	at91_shdwc = devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
> +	if (!at91_shdwc)
> +		return -ENOMEM;
> +

Is there any real benefit that will offset the time lost for that
allocation at boot time?

I understand you are then testing at91_shdwc to know whether the driver
already probed once. But, the driver will never probe twice as there is
only one shutdown controller on the SoC and anyway, If it was to probe
twice, it will still work as expected.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
