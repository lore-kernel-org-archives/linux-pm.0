From: Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
Date: Mon, 19 Jun 2017 11:30:18 +0800
Message-ID: <CAAd53p6iH=T+ynpsdmQVeexOXRdwdiznLiRGM40Q88__r1s7QQ@mail.gmail.com>
References: <CAAd53p4ntaZ48dsHG+ftDadgOnX=xwX9c3WeBr2SXZye3VL4CA@mail.gmail.com>
 <Pine.LNX.4.44L0.1706161327410.1715-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1706161327410.1715-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 17, 2017 at 1:30 AM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> On Sat, 17 Jun 2017, Kai-Heng Feng wrote:
>
>> On Fri, Jun 16, 2017 at 11:07 AM, Kai-Heng Feng
>> <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org> wrote:
>> > On Thu, Jun 15, 2017 at 10:12 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
>> >> Those documents refer to a hardware bug with a workaround in the BIOS.
>> >> Have you checked to see if your BIOS is up to date?
>> >
>> > Yes, it's up to date.
>> >
>>
>> Alan, I re-sent a patch but I forgot to add you to CC list:
>> http://marc.info/?l=linux-pci&m=149760607914628&w=2
>
> Thanks for letting me know.  The patch seems reasonable.
>
> Have you tested it with system suspend?  That is, if you suspend the
> whole computer, does plugging or unplugging a USB device cause the
> system to wake up?

No, the system will not wake up when plugging or unplugging.
Tried several times, nether runtime PM enabled nor runtime PM disabled
will wake up the system under S3, when (un)plugging USB devices.

>
> Alan Stern
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
