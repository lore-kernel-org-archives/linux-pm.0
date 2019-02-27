From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Date: Wed, 27 Feb 2019 12:57:55 -0800
Message-ID: <20190227205754.GF174696@google.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <20190226232822.GA174696@google.com>
 <d67512fe-42b4-513f-d27a-fed85c19e9c2@arm.com>
 <CAKv+Gu_fZK7dUqrrVPCejAZNWyUeMUX2ojQ=vQ3hiMkGF6e6tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_fZK7dUqrrVPCejAZNWyUeMUX2ojQ=vQ3hiMkGF6e6tw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Ganapathi Bhat <gbhat@marvell.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Devicetree List <devicetree@vger.kernel.org>, Xinming Hu <huxinming820@gmail.com>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Amitkumar Karwar <amitkarwar@gmail.com>, linux-rockchip@lists.infradead.org, Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lorenz
List-Id: linux-pm@vger.kernel.org

Hi Ard,

On Wed, Feb 27, 2019 at 11:16:12AM +0100, Ard Biesheuvel wrote:
> On Wed, 27 Feb 2019 at 11:02, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On 26/02/2019 23:28, Brian Norris wrote:
> > > You're not the first person to notice this. All the motivations are not
> > > necessarily painted clearly in their cover letter, but here are some
> > > previous attempts at solving this problem:
> > >
> > > [RFC PATCH v11 0/5] PCI: rockchip: Move PCIe WAKE# handling into pci core
> > > https://lkml.kernel.org/lkml/20171225114742.18920-1-jeffy.chen@rock-chips.com/
> > > http://lkml.kernel.org/lkml/20171226023646.17722-1-jeffy.chen@rock-chips.com/
> > >
> > > As you can see by the 12th iteration, it wasn't left unsolved for lack
> > > of trying...
> >
> > I wasn't aware of this. That's definitely a better approach than my
> > hack, and I would really like this to be revived.
> >
> 
> I don't think this approach is entirely sound either.

(I'm sure there may be problems with the above series. We probably
should give it another shot though someday, as I think it's closer to
the mark.)

> From the side of the PCI device, WAKE# is just a GPIO line, and how it
> is wired into the system is an entirely separate matter. So I don't
> think it is justified to overload the notion of legacy interrupts with
> some other pin that may behave in a way that is vaguely similar to how
> a true wake-up capable interrupt works.

I think you've conflated INTx with WAKE# just a bit (and to be fair,
that's exactly what the bad binding we're trying to replace did,
accidentally). We're not trying to claim this WAKE# signal replaces the
typical PCI interrupts, but it *is* an interrupt in some sense --
"depending on your definition of interrupt", per our IRC conversation ;)

> So I'd argue that we should add an optional 'wake-gpio' DT property
> instead to the generic PCI device binding, and leave the interrupt
> binding and discovery alone.

So I think Mark Rutland already shot that one down; it's conceptually an
interrupt from the device's perspective. We just need to figure out a
good way of representing it that doesn't stomp on the existing INTx
definitions.

Brian
