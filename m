From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V7 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
Date: Tue, 25 Oct 2016 10:47:55 +0800
Message-ID: <1477363675.2298.2.camel@intel.com>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
         <1474446227-1147-3-git-send-email-kernel@martin.sperl.org>
         <87twczg27x.fsf@eliezer.anholt.net>
         <eaff4043-5a62-da2d-cee1-9962b8c4783a@i2se.com>
         <87eg35snvg.fsf@eliezer.anholt.net>
         <1190898538.120930.02d69662-0b1a-447d-9c29-782aec7a1189.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1190898538.120930.02d69662-0b1a-447d-9c29-782aec7a1189.open-xchange-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2016-10-24 at 20:25 +0200, Stefan Wahren wrote:
> > 
> > Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org> hat am 24. Oktober 2016 um 18:38
> > geschrieben:
> > 
> > 
> > Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> writes:
> > 
> > > 
> > > Hi Martin,
> > > 
> > > Am 28.09.2016 um 23:10 schrieb Eric Anholt:
> > > > 
> > > > kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:
> > > > 
> > > > > 
> > > > > From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> > > > > 
> > > > > Add basic thermal driver for bcm2835 SOC.
> > > > > 
> > > > > This driver currently relies on the firmware setting up the
> > > > > tsense HW block and does not set it up itself.
> > > > > 
> > > > > Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> > > > > Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
> > > > > Acked-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> > > > What's the status of merging this one?  I'd like to merge the
> > > > other
> > > > patches.
> > > i think it's necessary to rebase the whole series. Maybe we could
> > > get it
> > > into 4.10.
> > Why would it need to be rebased?  The status, as far as I know, is
> > that
> > we're still waiting for the subsystem maintainer to respond.
> Since at least this patch won't apply anymore, but feedback from
> maintainer is
> still good :-)
> 
> Sorry for this impatience, but i'm afraid that we possibly miss 4.10.

Eduardo,

any comments on this patchset?

thanks,
rui
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
