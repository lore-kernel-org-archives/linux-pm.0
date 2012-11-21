From: Tomi Valkeinen <tomba-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Date: Wed, 21 Nov 2012 13:06:03 +0200
Message-ID: <50ACB59B.4090404@iki.fi>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com> <1353149747-31871-2-git-send-email-acourbot@nvidia.com> <20121120215429.B621F3E1821@localhost> <13540495.epaCf4JVn9@percival>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <13540495.epaCf4JVn9@percival>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 2012-11-21 06:23, Alex Courbot wrote:
> Hi Grant,
> 
> On Wednesday 21 November 2012 05:54:29 Grant Likely wrote:
>>> With the advent of the device tree and of ARM kernels that are not
>>> board-tied, we cannot rely on these board-specific hooks anymore but
>>
>> This isn't strictly true. It is still perfectly fine to have board
>> specific code when necessary. However, there is strong encouragement to
>> enable that code in device drivers as much as possible and new board
>> files need to have very strong justification.
> 
> But doesn't introducing board-specific code into the kernel just defeats the 
> purpose of the DT? If we extend this logic, we are heading straight back to 
> board-definition files. To a lesser extent than before I agree, but the problem 
> is fundamentally the same.

I don't think so. I'll reiterate my opinion on this subject, as a
summary and for those who haven't read the discussions of the earlier
versions of the series. And perhaps I'll even manage to say something
new =).


First about the board specific code. I think we may need some board
specific code, even if this series was merged. Let's call them board
drivers. These board drivers would only exist for boards with some weird
setups that cannot be expressed or managed with DT and normal drivers.

I think these cases would be quite rare, as I can't even come up with a
very good example. I guess most likely these cases would involve some
small trivial chips for muxing or such, for which it doesn't really make
sense to have a real driver.

Say, perhaps a board with two LCDs connected to one video output, and
only one LCD can be enabled at a time, and you need to set some mux chip
to route the signals to the correct LCD. In this case I'd see we should
have hotplug support in the display framework, and the board driver
would act on user input (sysfs file, perhaps), plugging in/out the LCD
device depending on the user input.


As for expressing device internal details in the DT data, as done in
this series, I don't like it very much. I think the DT data or the board
file should just describe which device is the one in question, and how
it's connected to other components on the board. The driver for the
device should handle everything else.

As Alex pointed out, there may be lots of devices that work the same way
when enabled, but require slightly different power-on/off sequences. We
could have these sequences in the driver itself, either as plain code,
or in a table of some sort, possibly using the power sequence framework
presented in this series. The correct code or sequence would be ran
depending on the particular model of the device.

I think this approach is correct in the sense that this is what drivers
are supposed to do: handle all the device internal matters. But this
raises the problem of bloating the kernel with possibly lots of
different power sequences, of which only a few would be used by a board,
and all the rest would just be waste of memory.

Regarding this problem I have the following questions, to which I don't
have clear answers:

- How much of this device specific data is too much? If a driver
supports 10 different models, and the sequences for each model take 100
bytes, this 1000 bytes doesn't sound too much. But where's the limit?
And even if one driver only has 1kB of this data, what if we have lots
of similar drivers?

- How many bytes does a power sequence presented in this series take, if
the sequence contains, say, 5 steps, with gpio, delay, pwm, delay and
regulator?

- How likely is it that we'll get lots of different models? A hundred
different models for a backlight PWM with different power-on/off
sequences already sounds a really big number. If we're only going to
have each driver supporting, say, no more than 10 models, perhaps the
problem is not even an issue in practice.

- Are there ways to limit this bloat in the driver? One obvious way
would be to discard the unused sequences after driver probe, but that
only works for platform devices. Although, I guess these sequences would
mostly be used by platform drivers? If so, then the problem could be
solved by discarding the data after probe. Another would be to load the
sequences from a file as firmware, but that feels quite an awful
solution. Anybody have other ideas?

One clear positive side with in-driver approach is that it's totally
inside the kernel, and can be easily reworked in the future, or even
changed to a DT-based approach as presented in this series if that seems
like a better solution. The DT based approach, on the other hand, will
be more or less written to stone after it's merged.


So, I like the framework of expressing the sequences presented in this
series (except there's a problem with error cases, as I pointed out in
another post), as it can be used inside the drivers. But I'm not so
enthusiastic about presenting the sequences in DT.

My suggestion would be to go forward with an in-driver solution, and
look at the DT based solution later if we are seeing an increasing bloat
in the drivers.

 Tomi
