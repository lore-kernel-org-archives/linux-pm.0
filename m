From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 09/13] thermal/drivers/hisi: Remove costly sensor
 inspection
Date: Fri, 8 Sep 2017 11:50:56 +0200
Message-ID: <c9b7556d-f090-f7cb-9e2a-e826c8bb7057@linaro.org>
References: <1504554972-2624-1-git-send-email-daniel.lezcano@linaro.org>
 <1504554972-2624-9-git-send-email-daniel.lezcano@linaro.org>
 <20170908032227.GE2755@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908032227.GE2755@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/09/2017 05:22, Eduardo Valentin wrote:
> On Mon, Sep 04, 2017 at 09:56:08PM +0200, Daniel Lezcano wrote:
>> The sensor is all setup, bind, resetted, acked, etc... every single second.
>>
>> That was the way to workaround a problem with the interrupt bouncing again and
>> again.
>>
>> With the following changes, we fix all in one:
>>
>>  - Do the setup, one time, at probe time
>>
>>  - Add the IRQF_ONESHOT, ack the interrupt in the threaded handler
>>
>>  - Remove the interrupt handler
>>
>>  - Set the correct value for the LAG register
>>
>>  - Remove all the irq_enabled stuff in the code as the interruption
>>    handling is fixed
>>
>>  - Remove the 3ms delay
>>
>>  - Reorder the initialization routine to be in the right order
>>
>> It ends up to a nicer code and more efficient, the 3-5ms delay is removed from
>> the get_temp() path.
> 
> It would be good if you could include in your commit message why before
> the 3-5ms was needed and now you dont need it. These delays are typical
> on ADC conversion time in order to get the proper temperature read. One
> side effect of removing the delay could be that you would be caching
> previously converted value stored in the register interface, which,
> depending on your policy and polling setup, could be bad. Say you have a
> polling setup for 1s, you would wait 2s to see read temperature, which,
> depending on how the zone behaves could be enough to miss a spike.

May be I was unclear. The 3-5ms delay is to *setup* the sensor. There
was a misunderstanding of how the sensor was working when the driver was
initially implemented and the interrupt behavior was erratic. In order
to workaround this, the sensor was reseted and setup every single get
temp, consequently the delay is to let the sensor initializes itself
before reading the temperature, an insane hack actually. I didn't feel
comfortable to put that in the changelog.

All the series fixes this and it results in having the setup done at
boot time. The sensor has way enough time to initialize itself before
the first reading.

Reading the temperature is just to read the register which is not a
relaxed one, thus with a rmb().

Do you want me to update the changelog or does the explanation make the
changelog more clear?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
