From: Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
Date: Fri, 16 Jun 2017 11:07:42 +0800
Message-ID: <CAAd53p46piFcy+JKFi6auBLON-4tPHTAHBO_DOyZyL+xxCa4PA@mail.gmail.com>
References: <CAAd53p4-84G=NeJMOGcL_3fd7_s6EC4udLEGTcNNSBF=4FxHyA@mail.gmail.com>
 <Pine.LNX.4.44L0.1706151008380.1573-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1706151008380.1573-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 15, 2017 at 10:12 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> On Thu, 15 Jun 2017, Kai-Heng Feng wrote:
>
>> On Wed, Jun 14, 2017 at 1:28 AM, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> >
>> > The lspci output [1] shows:
>> >
>> >   00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI Controller (rev 39) (prog-if 20 [EHCI])
>> >     Capabilities: [c0] Power Management version 2
>> >       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>> >       Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>> >       Bridge: PM- B3+
>> >
>> > The device claims it can assert PME# from D3hot.  If it can't, that
>> > sounds like a hardware defect that should be addressed with a quirk.
>> > Ideally we would also have a pointer to the AMD hardware erratum.
>>
>> Looks like it's pretty similar to "23 USB Wake on Connect/Disconnect
>> with Low Speed Devices" in [1].
>> It points to a workaround in appendix A2 from [2].
>> However it says this bug only effects Low Speed devices, but it
>> actually also happens on High Speed devices.
>>
>> [1] https://support.amd.com/TechDocs/46837.pdf
>> [2] https://support.amd.com/TechDocs/42413.pdf
>
> Those documents refer to a hardware bug with a workaround in the BIOS.
> Have you checked to see if your BIOS is up to date?

Yes, it's up to date.

>
> Alan Stern
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
