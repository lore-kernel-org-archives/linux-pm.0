From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V11 6/6] thermal: bcm2835: add thermal driver for bcm2835
 SoC
Date: Thu, 30 Mar 2017 18:06:45 -0700
Message-ID: <20170331010643.GA1923@localhost.localdomain>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
 <1489356665-3175-7-git-send-email-stefan.wahren@i2se.com>
 <20170329045807.GC2582@localhost.localdomain>
 <20170330045725.GA12995@localhost.localdomain>
 <1620097357.332334.1490901102005@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1620097357.332334.1490901102005-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello,
On Thu, Mar 30, 2017 at 09:11:41PM +0200, Stefan Wahren wrote:
> Hi Eduardo,
> 
> > Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> hat am 30. März 2017 um 06:57 geschrieben:
> > 
> > 

<cut>

> > A third option on top of what I suggested above is to split the series.
> > Given that you could still get the proper coefficients
> > with current of-thermal, I would suggest you to split this series into
> > two (patches 1-2, 3-6) in your next version, so we avoid futher delays
> > on the driver, while patches 1-2 waits for acks from OF side.
> 
> i revert patches #1, #2 and the slope value was still correct. So i will choose the third option and split the series.

Sounds good to me.

> 
> Thanks
> Stefan
> 
> > 
> > [1] - https://patchwork.kernel.org/patch/9612613/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
