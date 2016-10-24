From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V7 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
Date: Mon, 24 Oct 2016 20:25:56 +0200 (CEST)
Message-ID: <1190898538.120930.02d69662-0b1a-447d-9c29-782aec7a1189.open-xchange@email.1und1.de>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
 <1474446227-1147-3-git-send-email-kernel@martin.sperl.org>
 <87twczg27x.fsf@eliezer.anholt.net>
 <eaff4043-5a62-da2d-cee1-9962b8c4783a@i2se.com>
 <87eg35snvg.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:55120 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936135AbcJXS0v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 14:26:51 -0400
In-Reply-To: <87eg35snvg.fsf@eliezer.anholt.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kernel@martin.sperl.org, Eric Anholt <eric@anholt.net>
Cc: Will Deacon <will.deacon@arm.com>, Lee Jones <lee@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Russell King <linux@arm.linux.org.uk>, Zhang Rui <rui.zhang@intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Mark Rutland <mark.rutland@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org

> Eric Anholt <eric@anholt.net> hat am 24. Oktober 2016 um 18:38 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi Martin,
> >
> > Am 28.09.2016 um 23:10 schrieb Eric Anholt:
> >> kernel@martin.sperl.org writes:
> >>
> >>> From: Martin Sperl <kernel@martin.sperl.org>
> >>>
> >>> Add basic thermal driver for bcm2835 SOC.
> >>>
> >>> This driver currently relies on the firmware setting up the
> >>> tsense HW block and does not set it up itself.
> >>>
> >>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> >>> Acked-by: Eric Anholt <eric@anholt.net>
> >>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> >> What's the status of merging this one?  I'd like to merge the other
> >> patches.
> >
> > i think it's necessary to rebase the whole series. Maybe we could get it
> > into 4.10.
> 
> Why would it need to be rebased?  The status, as far as I know, is that
> we're still waiting for the subsystem maintainer to respond.

Since at least this patch won't apply anymore, but feedback from maintainer is
still good :-)

Sorry for this impatience, but i'm afraid that we possibly miss 4.10.
