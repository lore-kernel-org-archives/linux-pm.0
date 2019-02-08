From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 3/3] power: reset: at91-reset: add support for sam9x60
 SoC
Date: Fri, 8 Feb 2019 16:24:35 +0100
Message-ID: <20190208152435.GC23062@piout.net>
References: <20190206181221.27914-1-nicolas.ferre@microchip.com>
 <20190206181221.27914-3-nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206181221.27914-3-nicolas.ferre@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/02/2019 19:12:21+0100, Nicolas Ferre wrote:
> Add support for additional reset causes and the proper compatibility
> string for sam9x60 SoC. The restart function is the same as the samx7.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> v2: split series and collect tag
> 
> Sebastian,
> I add your Acked-by tag here but as I would like that you take the 3 patches on
> your tree now, I let you modify it on your side. I'm expecting Alexandre or
> Ludovic to have a look as well.
> 

Sebastian, please take this series through your tree. Thanks!

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
