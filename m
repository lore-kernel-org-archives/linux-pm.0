From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] vfio: platform: Fix using devices in PM Domains
Date: Mon, 28 May 2018 17:02:38 +0200
Message-ID: <CAMuHMdXfEj9Z8b3csyM_5rbS5-ki99bWJqnWZcL2chK9P39vTg@mail.gmail.com>
References: <1526640912-894-1-git-send-email-geert+renesas@glider.be> <10a503da-d431-f2c9-3ddc-91b065563a0d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10a503da-d431-f2c9-3ddc-91b065563a0d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Alex Williamson <alex.williamson@redhat.com>, KVM list <kvm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Eric,

On Mon, May 28, 2018 at 4:54 PM, Auger Eric <eric.auger@redhat.com> wrote:
> On 05/18/2018 12:55 PM, Geert Uytterhoeven wrote:
>> If a device is part of a PM Domain (e.g. power and/or clock domain), its
>> power state is managed using Runtime PM.  Without Runtime PM, the device
>> may not be powered up or clocked, causing subtle failures, crashes, or
>> system lock-ups when the device is accessed by the guest.
>>
>> Fix this by adding Runtime PM support, powering the device when the VFIO
>> device is opened by the guest.
>
> I fail to apply this on master branch?

It's against git://github.com/awilliam/linux-vfio.git#next.

>> Note that while more fine-grained power management could be implemented
>> on the guest side, if exported by the host, this would be inherently
>> unsafe, as abusing it may take down the whole system.
> I think I would prefer we get rid of the above paragraph.

OK, I will drop it. But you've been warned ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
