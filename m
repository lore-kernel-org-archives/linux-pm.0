From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH V11 6/6] thermal: bcm2835: add thermal driver for
 bcm2835 SoC
Date: Thu, 30 Mar 2017 08:30:29 +0200 (CEST)
Message-ID: <1205844664.21224.1490855429497@email.1und1.de>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
 <1489356665-3175-7-git-send-email-stefan.wahren@i2se.com>
 <20170329045807.GC2582@localhost.localdomain>
 <20170330045725.GA12995@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170330045725.GA12995-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


> Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> hat am 30. März 2017 um 06:57 geschrieben:
> 
> 
> On Tue, Mar 28, 2017 at 09:58:09PM -0700, Eduardo Valentin wrote:
> > On Sun, Mar 12, 2017 at 10:11:05PM +0000, Stefan Wahren wrote:
> > > Add basic thermal driver for bcm2835 SoC.
> > > 
> > > This driver currently make sure that tsense HW block is set up
> > > correctly.
> > > 
> > > Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> > > Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> > > Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
> > 
> > I see no issue with this driver at this point.
> > 
> > As I mentioned, the full series needs to go together. You either get an
> > Ack from OF maintainers, and I take the series, or you can add my
> > 
> > Acked-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > 
> > after fixing the small comment from Nobuhiro.
> > 
> 
> Based on other drivers that require negative values, I assume patches 1
> and 2 of these series are needed, but more for enforcing the API, given
> that the current of-thermal driver still retrieves the negative values
> from DTB [1].
> 
> [1] - https://patchwork.kernel.org/patch/9612613/

I can't see that the OMAP5 thermal driver is using thermal_zone_get_slope() [2]. I got the wrong values without patch 1 and 2. So i wouldn't rely on that statement. But i will doublecheck it.

[2] - http://elixir.free-electrons.com/ident?v=4.11-rc4&i=thermal_zone_get_slope
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
