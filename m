From: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Date: Wed, 27 Feb 2019 11:16:12 +0100
Message-ID: <CAKv+Gu_fZK7dUqrrVPCejAZNWyUeMUX2ojQ=vQ3hiMkGF6e6tw@mail.gmail.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com> <20190226232822.GA174696@google.com>
 <d67512fe-42b4-513f-d27a-fed85c19e9c2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d67512fe-42b4-513f-d27a-fed85c19e9c2-5wv7dgnIgG8@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ganapathi Bhat <gbhat-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Xinming Hu <huxinming820-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "<netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "<linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Amitkumar Karwar <amitkarwar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nishant Sarmukadam <nishants-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Lo
List-Id: linux-pm@vger.kernel.org

On Wed, 27 Feb 2019 at 11:02, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org> wrote:
>
> + Lorenzo
>
> Hi Brian,
>
> On 26/02/2019 23:28, Brian Norris wrote:
> > + others
> >
> > Hi Marc,
> >
> > Thanks for the series. I have a few bits of history to add to this, and
> > some comments.
> >
> > On Sun, Feb 24, 2019 at 02:04:22PM +0000, Marc Zyngier wrote:
> >> For quite some time, I wondered why the PCI mwifiex device built in my
> >> Chromebook was unable to use the good old legacy interrupts. But as MSIs
> >> were working fine, I never really bothered investigating. I finally had a
> >> look, and the result isn't very pretty.
> >>
> >> On this machine (rk3399-based kevin), the wake-up interrupt is described as
> >> such:
> >>
> >> &pci_rootport {
> >>      mvl_wifi: wifi@0,0 {
> >>              compatible = "pci1b4b,2b42";
> >>              reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
> >>                     0x83010000 0x0 0x00100000 0x0 0x00100000>;
> >>              interrupt-parent = <&gpio0>;
> >>              interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> >>              pinctrl-names = "default";
> >>              pinctrl-0 = <&wlan_host_wake_l>;
> >>              wakeup-source;
> >>      };
> >> };
> >>
> >> Note how the interrupt is part of the properties directly attached to the
> >> PCI node. And yet, this interrupt has nothing to do with a PCI legacy
> >> interrupt, as it is attached to the wake-up widget that bypasses the PCIe RC
> >> altogether (Yay for the broken design!). This is in total violation of the
> >> IEEE Std 1275-1994 spec[1], which clearly documents that such interrupt
> >> specifiers describe the PCI device interrupts, and must obey the
> >> INT-{A,B,C,D} mapping. Oops!
> >
> > You're not the first person to notice this. All the motivations are not
> > necessarily painted clearly in their cover letter, but here are some
> > previous attempts at solving this problem:
> >
> > [RFC PATCH v11 0/5] PCI: rockchip: Move PCIe WAKE# handling into pci core
> > https://lkml.kernel.org/lkml/20171225114742.18920-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org/
> > http://lkml.kernel.org/lkml/20171226023646.17722-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org/
> >
> > As you can see by the 12th iteration, it wasn't left unsolved for lack
> > of trying...
>
> I wasn't aware of this. That's definitely a better approach than my
> hack, and I would really like this to be revived.
>

I don't think this approach is entirely sound either.

>From the side of the PCI device, WAKE# is just a GPIO line, and how it
is wired into the system is an entirely separate matter. So I don't
think it is justified to overload the notion of legacy interrupts with
some other pin that may behave in a way that is vaguely similar to how
a true wake-up capable interrupt works.

So I'd argue that we should add an optional 'wake-gpio' DT property
instead to the generic PCI device binding, and leave the interrupt
binding and discovery alone.
