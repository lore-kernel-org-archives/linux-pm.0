From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 2/3] ARM: bcm2835: add rpi power domain driver
Date: Tue, 01 Dec 2015 15:27:57 -0800
Message-ID: <7hr3j5696q.fsf@deeprootsystems.com>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
	<1447956490-22930-3-git-send-email-alex.aring@gmail.com>
	<7hr3j782qr.fsf@deeprootsystems.com> <20151201210037.GB2074@omega>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34807 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239AbbLAX2A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 18:28:00 -0500
Received: by padhx2 with SMTP id hx2so20010673pad.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2015 15:27:59 -0800 (PST)
In-Reply-To: <20151201210037.GB2074@omega> (Alexander Aring's message of "Tue,
	1 Dec 2015 22:00:42 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@arm.linux.org.uk, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, rjw@rjwysocki.net, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, kernel@pengutronix.de

Alexander Aring <alex.aring@gmail.com> writes:

> Hi,
>
> On Mon, Nov 30, 2015 at 03:51:56PM -0800, Kevin Hilman wrote:
>> Alexander Aring <alex.aring@gmail.com> writes:
>> 
>> > This patch adds support for RPi several Power Domains and enable support
>> > to enable the USB Power Domain when it's not enabled before.
>> >
>> > This patch based on Eric Anholt's patch to support Power Domains. He had
>> > an issue about -EPROBE_DEFER inside the power domain subsystem, this
>> > issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
>> > if we fail to init or turn-on domain").
>> 
>> [...]
>> 
>> > +#define RPI_POWER_DOMAIN(_domain, _name)			\
>> > +	[_domain] = {						\
>> 
>> Using _domain as the array index is going to create a sparsely filled
>> array here, wasting memory.   I'm not sure what the other domain numbers
>> are for other domains to know if this is a big waste or not, but it's
>> still a bit wasteful.
>> 
>> In any case, AFAICT, it doesn't look like you need to have the array
>> index match the domain number anyways since you're using container_of().
>> 
>> So I suggest just removing this array index part, and just creating them
>> in arrary order.  Then your _probe function isn't going to try to setup
>> 3 non-enabled domains before it finally hits the USB domain.
>> 
>
> The idea is here to keeping the _same_ power domains indexes for
> device-tree power domain API like the RPi firmware provides it.
>
> If somebody dumps the devicetree and see the power domain index, if
> he/she does then a firmware API power domain index mapping it is wrong.
> Because we need then a separate mapping:
>
> $ARRAY_DEFINED_INDEX <-> $RPI_FIRMWARE_POWER_DOMAIN_API_INDEX
>
> With the current solution to make a 1:1 mapping it there is no
> confusing anymore, because:
>
> $ARRAY_DEFINED_INDEX == $RPI_FIRMWARE_POWER_DOMAIN_API_INDEX

I'm not proposing to change the DT numbers or the firmware numbers.  All
I'm proposing is that those numbers don't need to be mapped to the array
index.  IOW, in your structure definition macro:

+#define RPI_POWER_DOMAIN(_domain, _name)			\
+	[_domain] = {						\
+		.domain = _domain,				\
[...]

just drop the " [_domain] = { " line.

> Also there exists power domains 1-10 (so far I know), 1-2 are currently
> not used (and dummy-calls inside the rpi firmware implementation). So
> later they should be provided anyway.

They could then be added in any order in the struture.

> There exists a little improvement to let the for (i = 0; i < num_domains
> ...) start at "i = 1", the entry with index "0" will be a waste of memory
> then and it's not provided by the firmware API as a power domain.

Even index 0 will not be wasted with the above approach.

Kevin

