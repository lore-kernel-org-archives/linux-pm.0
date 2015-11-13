From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv2 1/2] power: domain: add pm_genpd_uninit
Date: Fri, 13 Nov 2015 13:56:06 +0100
Message-ID: <20151113125601.GA29318@omega>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
 <1446590711-18928-2-git-send-email-alex.aring@gmail.com>
 <CAPDyKFrkzMZZjFRM7EbqDqmW8EXzV22O_tp8a45LVGQYSn6b3g@mail.gmail.com>
 <20151105143445.GC599@omega>
 <20151111180019.GB2621@omega>
 <CAPDyKFr2HdQWdrTD_E5s9cdU917mbn29DYk-Q1ydEd8ROoNHUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36603 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbbKMM4O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2015 07:56:14 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFr2HdQWdrTD_E5s9cdU917mbn29DYk-Q1ydEd8ROoNHUg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rpi-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, =?utf-8?B?UGF3ZcWC?= Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi,

On Wed, Nov 11, 2015 at 09:33:40PM +0100, Ulf Hansson wrote:
> On 11 November 2015 at 19:00, Alexander Aring <alex.aring@gmail.com> wrote:
> > Hi,
> >
> > On Thu, Nov 05, 2015 at 03:34:45PM +0100, Alexander Aring wrote:
> >>
> >> What do you suggest to me for e.g. the raspberrypi power domain driver,
> >> also simple ignore such error handling?
> >>
> >
> > ping, I also can add some WARN_ON_ONCE, if the list for sub-domains,
> > etc. are not empty. This would then report about wrong use of
> > pm_genpd_uninit.
> >
> > - Alex
> 
> Sorry for the delay.
> 
> I think what you suggest would be an okay solution, at least it will
> improve the current behaviour.
> 
> We should verify for sub-domains, attached devices, and if the genpd
> has an of-provider. That's all I can think of right now, but there may
> be other things as well.
> 

okay, I added now:

WARN_ON_ONCE(!list_empty(genpd->master_links) ||
             !list_empty(genpd->slave_links) ||
             !list_empty(genpd->dev_list));

So far I understand is master/slave something about domains/subdomains,
the dev_list fis for atteched devices.

But how can I check "if the genpd has an of-provider", the "struct
generic_pm_domain" doesn't know a "of-provider". There is a static list
"of_genpd_providers", do you want to iterate over all and then doing
some matching algorithmn? Or do you want to add something inside "struct
generic_pm_domain", so a genpd knows about the "of-provider".

I am currently confused about how to check on "of-provider".

- Alex
