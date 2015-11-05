From: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFCv2 2/2] rpi: add support to enable usb power domain
Date: Thu, 5 Nov 2015 15:12:36 +0100
Message-ID: <20151105141231.GA599@omega>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
 <1446590711-18928-3-git-send-email-alex.aring@gmail.com>
 <20151105133510.GA12530@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151105133510.GA12530@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Nov 05, 2015 at 07:35:10AM -0600, Rob Herring wrote:
> On Tue, Nov 03, 2015 at 11:45:11PM +0100, Alexander Aring wrote:
...
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> > new file mode 100644
> > index 0000000..c3abc24
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> > @@ -0,0 +1,25 @@
> > +Raspberry Pi power domain driver
> > +
> > +Required properties:
> > +
> > +- compatible:		Should be "raspberrypi,bcm2835-power".
> 
> These are board or chip level power domains? If the latter, the vendor 
> should not be raspberrypi, but Broadcom. If the former, then it should 
> describe the board rather than the chip.
> 

the access to the power domains is provided by the firmware. The
firmware is RPi specific. On an other bcm2835 with another firmware it
would be working complete different.

Everything which is accessable over the firmware is RPi specific.

- Alex
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
