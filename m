From: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Subject: Re: [PATCH] i2c-mux-pca954x: Disable mux after 200ms timeout
Date: Tue, 26 Nov 2013 15:06:20 +0100
Message-ID: <5294AADC.5070707@topic.nl>
References: <1385447520-3306-1-git-send-email-mike.looijmans@topic.nl> <20131126090639.GA2568@katana> <52946BA6.3080308@topic.nl> <20131126122818.GA7427@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131126122818.GA7427@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 11/26/2013 01:28 PM, Wolfram Sang wrote:
>
> CCing linux-pm, maybe they know more...
>
>> The extra I2C traffic consumes extra power. If the bus is terminated
>> using 2k resistors, approximately 1mA of current (assuming ~2V
>> signals) is flowing when the bus is pulled low. On low power
>> designs, this extra power consumption is noticable. There is no way
>> to turn the mux "off" from either user or kernel space. The signals
>> going through the mux to a place where no I2C device is actually
>> listening are only wasting power.
>
> I only have an overview of current linux pm mechanisms. I wonder if
> those can't be used somehow. Like if devices on the multiplexed bus are
> idle (well, only regarding transfers), then we can switch off the muxer.

I had looked a bit in that direction, but I think there's currently no way for 
a driver to say "I won't be needing the bus for a while". Something like that 
would be critical for such a pm system to work.

>> The I2C signals are used to control sensitive codecs. When looking
>> at the sampled data, the I2C traffic is visible in the captured
>> analog signal. To prevent this from happening, the mux can be
>
> I wonder: Is this really a feature of sensitive codecs or an issue of
> the board design?

A bit of both I guess. I guess it's the reason that "deselect_on_exit" existed 
in the first place. A lot of guessing that is.

Unlike the I2S bus that transfers the data at multimegahertzes, the I2C bus 
operates in the kHz range which is where audio codecs tend to operate too. 
That might explain why we've seen this issue on more than one design.

>> disabled whenever not communicating with the codec. This could be
>> accomplished with the "deselect_on_exit" boolean, but because audio
>> driver sends the codec parameters in dozens of small transactions,
>> this will result in a lot more needless I2C traffic, constantly
>> switching the mux for each codec setting.
>
> Has this been looked at? ASoC supports grouping of tranfers IIRC. Maybe
> your I2C driver is only missing I2C_M_NOSTART?.

I ported this from a 2.6.37 kernel, so I wouldn't be surprised if that option 
doesn't exist. There has been a lot of changes in the use of regmaps in ASoC 
in the past years.

>> Would it be acceptable if I made the timeout optional, by making the
>> "deselect_on_exit" boolean into a three-state value (off, on,
>> timeout)? Or, alternatively, implement "deselect_on_exit" using the
>> timeout scheme (probably with a very short timeout)?
>
> I have a number of concerns designwise. First, if we do something like
> shutting-down-a-bus-if-there-are-no-transfers-expected, it definately
> should be in the core, not the driver. As said before, I have the
> assumption it should even be connected to the runtime pm core via some
> callback. And if we have that for I2C, we surely want that for other
> buses as well, at least SPI. Also, the timeout thing sounds too
> heuristic to me. Later, people might want to change the timeout value
> depending on workloads or so, and then a governor, etc... No, thanks.

In any case, it doesn't sound like something I can sell - it's understandable 
for my employer that I spent an extra hour or so to clean up and submit the 
code to upstream, but this appears to go into a different class of rework.

So where do you want to go with this? Should I rework the patch to make the 
timeout optional, or should I simply forget about integrating at all?

> BTW is it feasible to shut down the whole I2C bus at controller level
> after transfers? No needless transfers and maybe even more power
> savings.

In fact, on the customer's board, the pca mux is powered by a supply so the 
whole mux can be powered-down too, for which I also needed to patch the pca 
driver to reset its state when the powersupply reported that it was going 
down. I think that particular patch isn't of much use to the community though, 
or is it?

Most hardware can control power and clocks to the I2C controller, which would 
indeed account for some power savings. But again, that would require drivers 
to provide estimations as to when they will need the bus. And it would require 
much more information on the bus controller too, though I suspect that to be 
the easier part.

 > Anyway, thanks for letting me know about your requirements (they should
 > have been in the original commit message, though ;))

I'm new to Linux kernel development, so please forgive me...

Kind regards,
Mike.
