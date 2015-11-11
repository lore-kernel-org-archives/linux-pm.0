From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFCv2 1/2] power: domain: add pm_genpd_uninit
Date: Wed, 11 Nov 2015 21:33:40 +0100
Message-ID: <CAPDyKFr2HdQWdrTD_E5s9cdU917mbn29DYk-Q1ydEd8ROoNHUg@mail.gmail.com>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
	<1446590711-18928-2-git-send-email-alex.aring@gmail.com>
	<CAPDyKFrkzMZZjFRM7EbqDqmW8EXzV22O_tp8a45LVGQYSn6b3g@mail.gmail.com>
	<20151105143445.GC599@omega>
	<20151111180019.GB2621@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33650 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbbKKUdl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2015 15:33:41 -0500
Received: by ykdv3 with SMTP id v3so69324152ykd.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2015 12:33:40 -0800 (PST)
In-Reply-To: <20151111180019.GB2621@omega>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 11 November 2015 at 19:00, Alexander Aring <alex.aring@gmail.com> wrote:
> Hi,
>
> On Thu, Nov 05, 2015 at 03:34:45PM +0100, Alexander Aring wrote:
>>
>> What do you suggest to me for e.g. the raspberrypi power domain driver,
>> also simple ignore such error handling?
>>
>
> ping, I also can add some WARN_ON_ONCE, if the list for sub-domains,
> etc. are not empty. This would then report about wrong use of
> pm_genpd_uninit.
>
> - Alex

Sorry for the delay.

I think what you suggest would be an okay solution, at least it will
improve the current behaviour.

We should verify for sub-domains, attached devices, and if the genpd
has an of-provider. That's all I can think of right now, but there may
be other things as well.

Kind regards
Uffe
