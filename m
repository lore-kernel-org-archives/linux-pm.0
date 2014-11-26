From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 9/9] usb: {ohci,ehci}-platform: Use new OF big-endian
 helper function
Date: Wed, 26 Nov 2014 11:24:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411261120300.1322-100000@iolanthe.rowland.org>
References: <CAJiQ=7CuLA2vDpnkDysBU100R0uuUidB_ua3sZdV74vNPjV76w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJiQ=7CuLA2vDpnkDysBU100R0uuUidB_ua3sZdV74vNPjV76w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marc C <marc.ceeeee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Nov 2014, Kevin Cernekee wrote:

> On Wed, Nov 26, 2014 at 7:14 AM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> >> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >> index 43c1a4e..9505c31 100644
> >> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >> @@ -12,6 +12,8 @@ Optional properties:
> >>   - big-endian-regs : boolean, set this for hcds with big-endian registers
> >>   - big-endian-desc : boolean, set this for hcds with big-endian descriptors
> >>   - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
> >> + - native-endian : boolean, enables big-endian-regs + big-endian-desc
> >> +   iff the kernel was compiled for big endian
> >
> > Is this really a property of the hardware?  It appears to depend on the
> > kernel configuration.  As such, is it appropriate for DT?
> 
> Yes, the peripheral registers automatically adjust their endianness to
> match the CPU.  So if the CPU is running an LE kernel, the peripheral
> needs to be accessed in LE mode; if the CPU is running a BE kernel,
> the peripheral needs to be accessed in BE mode.

Okay, then:

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>

But you might want to update the description slightly to say:

 - native-endian : boolean, enables big-endian-regs + big-endian-desc
   iff the CPU is running in big-endian mode

It's a very minor distinction, since you can't run a kernel that was 
compiled for little endian if the CPU is running in big-endian mode, 
but this makes it clear that you're talking about the hardware rather 
than the software.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
