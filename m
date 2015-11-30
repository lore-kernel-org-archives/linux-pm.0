From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 2/3] ARM: bcm2835: add rpi power domain driver
Date: Mon, 30 Nov 2015 15:51:56 -0800
Message-ID: <7hr3j782qr.fsf@deeprootsystems.com>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
	<1447956490-22930-3-git-send-email-alex.aring@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35787 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915AbbK3Xv7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 18:51:59 -0500
Received: by pacej9 with SMTP id ej9so200270470pac.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2015 15:51:58 -0800 (PST)
In-Reply-To: <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
	(Alexander Aring's message of "Thu, 19 Nov 2015 19:08:09 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@arm.linux.org.uk, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, rjw@rjwysocki.net, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, kernel@pengutronix.de

Alexander Aring <alex.aring@gmail.com> writes:

> This patch adds support for RPi several Power Domains and enable support
> to enable the USB Power Domain when it's not enabled before.
>
> This patch based on Eric Anholt's patch to support Power Domains. He had
> an issue about -EPROBE_DEFER inside the power domain subsystem, this
> issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
> if we fail to init or turn-on domain").

[...]

> +#define RPI_POWER_DOMAIN(_domain, _name)			\
> +	[_domain] = {						\

Using _domain as the array index is going to create a sparsely filled
array here, wasting memory.   I'm not sure what the other domain numbers
are for other domains to know if this is a big waste or not, but it's
still a bit wasteful.

In any case, AFAICT, it doesn't look like you need to have the array
index match the domain number anyways since you're using container_of().

So I suggest just removing this array index part, and just creating them
in arrary order.  Then your _probe function isn't going to try to setup
3 non-enabled domains before it finally hits the USB domain.

Kevin
