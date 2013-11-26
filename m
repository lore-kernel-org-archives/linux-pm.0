From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c-mux-pca954x: Disable mux after 200ms timeout
Date: Tue, 26 Nov 2013 14:39:25 +0100
Message-ID: <CAPDyKFoHJWLvCNd1b=-NOzeN8npFkYNPCU0YgREovMZZC0K6bw@mail.gmail.com>
References: <1385447520-3306-1-git-send-email-mike.looijmans@topic.nl>
	<20131126090639.GA2568@katana>
	<52946BA6.3080308@topic.nl>
	<20131126122818.GA7427@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131126122818.GA7427@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 26 November 2013 13:28, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
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
>
>> The I2C signals are used to control sensitive codecs. When looking
>> at the sampled data, the I2C traffic is visible in the captured
>> analog signal. To prevent this from happening, the mux can be
>
> I wonder: Is this really a feature of sensitive codecs or an issue of
> the board design?
>
>> disabled whenever not communicating with the codec. This could be
>> accomplished with the "deselect_on_exit" boolean, but because audio
>> driver sends the codec parameters in dozens of small transactions,
>> this will result in a lot more needless I2C traffic, constantly
>> switching the mux for each codec setting.
>
> Has this been looked at? ASoC supports grouping of tranfers IIRC. Maybe
> your I2C driver is only missing I2C_M_NOSTART?.
>
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

It very much sounds like runtime PM should help you here. Then you get
the reference counting and the so called runtime_autosuspend feature
for free. :-)

>
> BTW is it feasible to shut down the whole I2C bus at controller level
> after transfers? No needless transfers and maybe even more power
> savings.

For sure this should be possible. Some controller drivers have started
to adapt some runtime PM code for this is already, nomadik and omap
for example. I think typically clocks, pins and if there are a power
domain regulator for the controller, those should be handled through
runtime PM to save power at "request inactivity".

Kind regards
Ulf Hansson

>
> Anyway, thanks for letting me know about your requirements (they should
> have been in the original commit message, though ;))
>
