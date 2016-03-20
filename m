From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2 1/5] thermal: change "hysteresis" as optional property
Date: Sun, 20 Mar 2016 23:40:31 +0800
Message-ID: <20160320154031.GA12693@leoy-linaro>
References: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
 <1456458227-12950-2-git-send-email-leo.yan@linaro.org>
 <20160303162942.GA2445@localhost.localdomain>
 <20160304030349.GA11012@leoy-linaro>
 <20160304115752.GA13894@e104805>
 <20160308135743.GC4921@leoy-linaro>
 <20160308205558.GA7010@localhost.localdomain>
 <20160309111051.GA3369@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35195 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873AbcCTPkn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Mar 2016 11:40:43 -0400
Received: by mail-vk0-f46.google.com with SMTP id e6so191467516vkh.2
        for <linux-pm@vger.kernel.org>; Sun, 20 Mar 2016 08:40:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160309111051.GA3369@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, kongxinwei <kong.kongxinwei@hisilicon.com>, Punit Agrawal <Punit.Agrawal@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi Javi,

Sorry for late response.

On Wed, Mar 09, 2016 at 11:10:52AM +0000, Javi Merino wrote:
> On Tue, Mar 08, 2016 at 12:55:59PM -0800, Eduardo Valentin wrote:
> > On Tue, Mar 08, 2016 at 09:57:43PM +0800, Leo Yan wrote:

[...]

> > > > > > > The property "hysteresis" is mandatory for trip points, so if without
> > > > > > > it the thermal zone cannot register successfully. But "hysteresis" is
> > > > > > > ignored in the thermal subsystem and only inquired by several thermal
> > > > > > > sensor drivers.
> > > > > > 
> > > > > > If the Linux thermal subsystem has a problem with handling hysteresis, I
> > > > > > would rather fix Linux code than relaxing the DT binding. Or if you
> > > > > > still believe hysteresis is really optional, I would prefer to see a
> > > > > > better justification than "Linux ignores it".
> > > > 
> > > > I see it the other way round, Is hysteresis a property that, without
> > > > it, the thermal code can't configure itself so it fails to create the
> > > > trip point?  The current code goes "There is no hysteresis for this
> > > > property, I don't know how to set up this trip point!".  I think we
> > > > can do better than this.
> > > 
> > > Do you agree with Javi's suggestion? If you think it's okay, I will
> > > move on to send out a new version patch based on Javi's comments.
> > 
> > No I don't. This discussion so far has been about Linux code. I still
> > havent seen an argument explaining why hysteresis has to be optional.
> 
> Fair enough.  Looks like I'm holding this driver from being
> upstreamed, so I'll back off.
> 
> Leo, sorry for misguiding you.  Please bring back the hysteresis
> property you had in v1.

Not at all. I will add back hysteresis property and resend new patches.

Thanks,
Leo Yan
