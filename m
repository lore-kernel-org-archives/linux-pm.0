From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/drivers/hisi: Switch to interrupt mode
Date: Wed, 27 Sep 2017 17:56:37 +0200
Message-ID: <20170927155637.GC2196@mai>
References: <1506470049-12597-1-git-send-email-daniel.lezcano@linaro.org>
 <1bfd974e-3dc1-e99b-d0dd-50102cee762d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1bfd974e-3dc1-e99b-d0dd-50102cee762d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: edubezval@gmail.com, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 27, 2017 at 01:56:20PM +0530, Keerthy wrote:
> 
> 
> On Wednesday 27 September 2017 05:24 AM, Daniel Lezcano wrote:
> > At this moment, we have both the interrupt setup and the polling enabled. The
> > interrupt does nothing more than forcing an update while the temperature is
> > polled every second.
> > 
> > We can do much better than that, threshold is set to 65C in the DT and the
> > passive ooling device enters in the dance when 75C is reached. We need to
> 
> /s/ooling/cooling
> 
> > sample the temperature at 65C in order to let the IPA gather enough values for
> > the PID computation. If the SoC is running at a temperature below 65C, we will
> > be constantly polling for nothing.
> > 
> > This patch disables the sensor when the temperature is below the temperature
> 
> temperature below 65C you mean?

Yeah ... :/
 
> > and enables it when passing the threshold. It resuls the sensor thermal sensor
> 
> /s/resuls/results
> 
> > driver will have no activity most of the time.
> 
> By chance you miss the interrupt you will never have cooling on again?

Mmh, I'm not sure it is possible to miss an interrupt with this driver but if
it is the case, there are different scenario.

 - The temperature is increasing and reaches the reset value: then the board
   reboots
 - The temperature increases above 65C and then decreases, and increases
   again, the interrupt will fire and the driver will work as expected

 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
