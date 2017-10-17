From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 02/25] thermal/drivers/hisi: Remove the multiple sensors
 support
Date: Tue, 17 Oct 2017 11:25:50 -0700
Message-ID: <20171017182547.GA1773@localhost.localdomain>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
 <1507658570-32675-2-git-send-email-daniel.lezcano@linaro.org>
 <20171017035409.GA23821@localhost.localdomain>
 <62584345-11d7-1b23-2711-2b663972161b@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:49622 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754505AbdJQSZz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2017 14:25:55 -0400
Content-Disposition: inline
In-Reply-To: <62584345-11d7-1b23-2711-2b663972161b@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org, Leo Yan <leo.yan@linaro.org>

Hello,

On Tue, Oct 17, 2017 at 02:28:27PM +0200, Daniel Lezcano wrote:
> On 17/10/2017 05:54, Eduardo Valentin wrote:
> > On Tue, Oct 10, 2017 at 08:02:27PM +0200, Daniel Lezcano wrote:
> >> By essence, the tsensor does not really support multiple sensor at the same
> >> time. It allows to set a sensor and use it to get the temperature, another
> >> sensor could be switched but with a delay of 3-5ms. It is difficult to read
> >> simultaneously several sensors without a big delay.
> >>
> > 
> > Is 3-5 ms enough to loose an event? Is this really a problem?
> 
> There are several aspects:
> 
>  - the multiple sensors is not needed here

Well, that is debatable, I cannot really agree or disagree with the
above statement without understanding the use cases and most important,
the location of each sensor. What is the location of each sensor?

> 
>  - the temperature controller is not designed to read several sensors at
> the same time, we switch the sensor and that clears some internal
> buffers and re-init the controller

Which is still very helpful in case you have multiple hotspots that you
want to track and they are exposed on different workloads. Sacrificing
the availability of sensors is something needs a better justification
other than "current code uses only one".


> 
>  - some boards can take 40°C in 1 sec, the temperature increase is
> insanely fast and reading several sensors add an extra 15ms.
> 


Ok... What is the difference in update rate with and without the switch
of sensors? With the above worst case, you have about 4/6 mC/ms. Can
your tsensor support that resolution for a single sensor? What is the
maximum resolution a tsensor can support? What is the penalty added with
switch?

Based on this data, and the above 3-5ms, that  means you would miss about
~ 3 - 4 mC while switching ( assuming tsensor can really achieve the
above rate of change: 5ms * 4/6 mC /ms). Are you sure that is
enough justification to drop three extra sensors?

> So from my point of view, trying to read multiple sensors with *this*
> tsensor is pointless.
> 
> >> Today, just one sensor is used, it is not necessary to deal with multiple
> > 
> > How come? Today the driver exposes all sensors to userspace. Removing
> > them, means you are changing the amount of sensors userspace really
> > sees.
> > 
> > Are you sure about this?
> > 
> > Can you please elaborate how we are only using one of the four sensors?
> 
> Only one has been defined in the DT since the beginning and no one is
> using multiple sensors.
> 
> >> sensors in the code. Remove them and if it is needed in the future add them
> >> on top of a code which will be clean up in the meantime.
> > 
> > It is just not clear to me why having 1 sensor support is better than
> > having 4, as per the hw supported tsensor.
> 
> The tsensor supports 4 sensors but not at the same time. You choose one
> and use it, AFAICS from the documentation and behavior.
> 
> If multiple sensors is needed later, I will be happy to re-introduce it
> on top of a sanitized driver.

Once again, having one at time is better than only one, depending on
sensor location and usage of the chip. Say you have two sensors, one at
CPU domain another at a coprocessor, say a DSP. The representation of
the CPU sensor is typically not representative of the DSP, and
vice-versa, even though one may still collect a few of the heat of what
the other detects first. Sometimes takes several hundreds of ms  
(sometimes seconds) to see heat wave from one to the other. Having both,
but the reads one at a time, may give you the chance to see a heat
increase on one side (say DSP) within 5 ms time frame (assuming your
reported worst case above), faster than physically waiting the heat
to really reach the other sensor (say CPU) after several hundreds of
ms (sometimes seconds).


> 
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > I would prefer to get confirmation from folks from hisilicon here.
> > 
> > BTW, you should be copying previous author of the code.
> 
> Hmm, I thought Leo was in copy (added). Kevin is from hisilicon and in
> charge of the thermal aspect of the hikey.
> 
> 
> 
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
