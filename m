From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 2/3] ARM: bcm2835: add rpi power domain driver
Date: Fri, 4 Dec 2015 10:22:32 +0100
Message-ID: <20151204092227.GA1915@omega>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
 <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
 <7hr3j782qr.fsf@deeprootsystems.com>
 <20151201210037.GB2074@omega>
 <7hr3j5696q.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33898 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbbLDJWl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2015 04:22:41 -0500
Content-Disposition: inline
In-Reply-To: <7hr3j5696q.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: linux-rpi-kernel@lists.infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@arm.linux.org.uk, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, rjw@rjwysocki.net, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, kernel@pengutronix.de

Hi,

Meanwhile there exists a new RPi firmware with a new interface to setup
power domains. Eric Anholt already did some work to access new interface
and old one based on this patch.

The next days he want to sent this new driver mainline, I will stop the work
now.

I will add some review notes anyway, maybe Eric Anholt can pick them up.

On Tue, Dec 01, 2015 at 03:27:57PM -0800, Kevin Hilman wrote:
> Alexander Aring <alex.aring@gmail.com> writes:
> 
> > Hi,
> >
> > On Mon, Nov 30, 2015 at 03:51:56PM -0800, Kevin Hilman wrote:
> >> Alexander Aring <alex.aring@gmail.com> writes:
> >> 
> >> > This patch adds support for RPi several Power Domains and enable support
> >> > to enable the USB Power Domain when it's not enabled before.
> >> >
> >> > This patch based on Eric Anholt's patch to support Power Domains. He had
> >> > an issue about -EPROBE_DEFER inside the power domain subsystem, this
> >> > issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
> >> > if we fail to init or turn-on domain").
> >> 
> >> [...]
> >> 
> >> > +#define RPI_POWER_DOMAIN(_domain, _name)			\
> >> > +	[_domain] = {						\
> >> 
> >> Using _domain as the array index is going to create a sparsely filled
> >> array here, wasting memory.   I'm not sure what the other domain numbers
> >> are for other domains to know if this is a big waste or not, but it's
> >> still a bit wasteful.
> >> 
> >> In any case, AFAICT, it doesn't look like you need to have the array
> >> index match the domain number anyways since you're using container_of().
> >> 
> >> So I suggest just removing this array index part, and just creating them
> >> in arrary order.  Then your _probe function isn't going to try to setup
> >> 3 non-enabled domains before it finally hits the USB domain.
> >> 
> >
> > The idea is here to keeping the _same_ power domains indexes for
> > device-tree power domain API like the RPi firmware provides it.
> >
> > If somebody dumps the devicetree and see the power domain index, if
> > he/she does then a firmware API power domain index mapping it is wrong.
> > Because we need then a separate mapping:
> >
> > $ARRAY_DEFINED_INDEX <-> $RPI_FIRMWARE_POWER_DOMAIN_API_INDEX
> >
> > With the current solution to make a 1:1 mapping it there is no
> > confusing anymore, because:
> >
> > $ARRAY_DEFINED_INDEX == $RPI_FIRMWARE_POWER_DOMAIN_API_INDEX
> 
> I'm not proposing to change the DT numbers or the firmware numbers.  All
> I'm proposing is that those numbers don't need to be mapped to the array
> index.  IOW, in your structure definition macro:
> 
> +#define RPI_POWER_DOMAIN(_domain, _name)			\
> +	[_domain] = {						\
> +		.domain = _domain,				\
> [...]
> 
> just drop the " [_domain] = { " line.
> 

This requires additional changes. We need to know the "maximum"
registered index value of RPi power domain.

Because the dynamic allocating array of (linux) power domains, which we
determine by:

... num_domains = ARRAY_SIZE(rpi_power_domains);

The RPi power domain defines are also used by devicetree. Usually I
would change it to an enum with a MAX_ATTR entry, which is not possible
because devicetree compiler can't deal with enums.


Anyway we could determine the max registered RPi power domain index by
doing something like:

num_domains = 0;

for (i = 0; i < ARRAY_SIZE(rpi_power_domains); i++)
	max(num_domains, array[i].domain);

- Alex
