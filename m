From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH 01/15] thermal: consistently use int for temperatures
Date: Wed, 20 May 2015 10:12:44 +0300
Message-ID: <555C33EC.7050906@kapsi.fi>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de> <1431507163-19933-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431507163-19933-2-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 05/13/15 11:52, Sascha Hauer wrote:
> The thermal code uses int, long and unsigned long for temperatures
> in different places. Using an unsigned type limits the thermal framework
> to positive temperatures without need. 'long' is 64bit on several
> architectures which is not needed. Consistently use a plain 'int'
> for temperatures.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> ...

It looks like some longs remain in db8500_thermal.c, int340x_thermal/*,
intel_soc_dts_thermal.c, kirkwood_thermal.c, rockchip_thermal.c and 
samsung/exynos_tmu.c. (found by 'grep -R long drivers/thermal/*)

Cheers,
Mikko.
