From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] PM / Sleep: Add pm_generic functions to re-use runtime
 PM callbacks
Date: Wed, 27 Nov 2013 10:59:57 +0100
Message-ID: <CAPDyKFow3Y7bWAWNxQyrKeHizk0TSoCuPLHD=p_1D=CAYQpm9A@mail.gmail.com>
References: <2026361.IiCVpVNYkW@vostro.rjw.lan>
	<Pine.LNX.4.44L0.1311261556480.1359-100000@iolanthe.rowland.org>
	<CAPDyKFp2z=ST6Sd3T+1Ko5pf5pf3Cfr44jS=jTBWABPcSS2RLg@mail.gmail.com>
	<3028580.oiUVTDjyao@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3028580.oiUVTDjyao-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

>>
>> There are already a generic callbacks that does this. Normally the
>> generic callbacks is used from buses and power domains.
>>
>> My new callbacks are intended to be used from the driver, so those are
>> kind of different from the others in that sense.
>
> Hmm.  I see.
>
> For that to work, the subsystem's .suspend() and .resume() callbacks will
> have to be implemented in a special way, because of the unknown runtime PM
> status of devices while those callbacks are being executed.

Not sure I understand why you think the runtime PM status is unknown?

In .suspend the runtime status can still be changed. Since the PM core
disables runtime PM before invoking .suspend_late and since the PM
core will keep runtime PM disabled until after the .resume_early has
been invoked, it will be safe to operate on the runtime PM callbacks
during this period - if the driver/bus are adopted for it. While the
.resume callback gets invoked, the runtime status are restored to it's
previous state, which the bus/driver would expect.

Do you want me to send a patch for a driver that uses these callbacks?
I suppose it would clarify how I am thinking...

>
> Presumably you think about subsystems that don't implement those callbacks
> at all?

If you mean that "drivers" is not a part of the term "subsystem" here,
then I somewhat agree.

My view is that it will be mostly drivers that make use of these callbacks.

Though, I don't think we need to prevent subsystems or power domains
from using them, they will only have to know what the consequences
are. :-)

Maybe there could even be some cases were it actually makes good sense
of using them for subsystems, even if I yet not have come a cross such
a case.

Kind regards
Ulf Hansson

>
> Rafael
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
