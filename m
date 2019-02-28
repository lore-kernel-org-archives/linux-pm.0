From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Date: Thu, 28 Feb 2019 12:03:38 +0100
Message-ID: <CAJZ5v0gycpqcyZM-XKm36BjGANbgKmhQ+mD_t3oy-CfC8BDjPA@mail.gmail.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com> <20190226232822.GA174696@google.com>
 <d67512fe-42b4-513f-d27a-fed85c19e9c2@arm.com> <CAKv+Gu_fZK7dUqrrVPCejAZNWyUeMUX2ojQ=vQ3hiMkGF6e6tw@mail.gmail.com>
 <20190227205754.GF174696@google.com> <CAJZ5v0gZFDdtbKQ6y52x+X8yoiPhP6BhGYZO=R_varx2nwuv5g@mail.gmail.com>
 <CA+ASDXNT9Taqfoz7R1Z926Vi1fMNNLYg5vqcZTw2m6JvXk+75w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+ASDXNT9Taqfoz7R1Z926Vi1fMNNLYg5vqcZTw2m6JvXk+75w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Ganapathi Bhat <gbhat@marvell.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Devicetree List <devicetree@vger.kernel.org>, Xinming Hu <huxinming820@gmail.com>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Amitkumar Karwar <amitkarwar@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 28, 2019 at 3:29 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi Rafael,
>
> On Wed, Feb 27, 2019 at 3:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, Feb 27, 2019 at 9:58 PM Brian Norris <briannorris@chromium.org> wrote:
> > > On Wed, Feb 27, 2019 at 11:16:12AM +0100, Ard Biesheuvel wrote:
> > > > So I'd argue that we should add an optional 'wake-gpio' DT property
> > > > instead to the generic PCI device binding, and leave the interrupt
> > > > binding and discovery alone.
> > >
> > > So I think Mark Rutland already shot that one down; it's conceptually an
> > > interrupt from the device's perspective.
>
> Perhaps I shouldn't speak for Mark, but I am basically quoting him off IRC.
>
> > Which device are you talking about?  The one that signals wakeup?  If
> > so, then I beg to differ.
>
> Yes, the endpoint device.
>
> > On ACPI platforms WAKE# is represented as an ACPI GPE that is signaled
> > through SCI and handled at a different level (on HW-reduced ACPI it
> > actually can be a GPIO interrupt, but it still is handled with the
> > help of AML).  The driver of the device signaling wakeup need not even
> > be aware that WAKE# has been asserted.
>
> Frankly, ACPI is not relevant to how we represent WAKE# in DT, IMO.

I mentioned ACPI as an example of how WAKE# can be handled.

> Also, we're talking about the *device*, not the driver. When talking
> about Device Tree, that distinction is relevant.

I'm not sure what you mean, really.

I guess we are talking about information in DT and some of it is
consumed by the driver while some of it is consumed by some other
pieces of code.

> So while the driver need not be aware (and I agree! it only needs to
> care about enabling/disabling wake),

Not even that.  Actually, PME enable is handled by the PCI bus type code.

> *something* should be aware,

Right.

> and the signal that "something" should be receiving is simply "did WAKE
> happen"?

Right.  But it may not be clear which device signaled it, because
WAKE# may be shared in general.

> That sounds basically like the device is signalling an interrupt to me.

Well, consider the native PME here.  In there, the device sends an
in-band message over the PCIe hierarchy to a root port and the
interrupt is signaled from there.  There is a PME driver in the kernel
that requests that IRQ and handles it (for all ports that can trigger
it), but for each port it binds to a separate device (or "service" if
you will) that takes care of all PME messages coming from all devices
under that port.

At an abstract level, WAKE# is expected to be similar AFAICS except
that there is a physical signal going from the device(s) (in low-power
states) that have detected external activity (wakeup) to an entity
that can trigger an interrupt.

The original idea in the PCI PM spec regarding WAKE# seems to be to
wire up WAKE# from all devices on the bus to one input that will cause
an interrupt to trigger when one of them drives WAKE# and whatever
handled that interrupt was expected to walk the bus, find the
device(s) with PME Status set and put it (or them) into D0 (clearing
PME Status in the process).  That still is a valid case to consider
IMO.

However, designers of some boards decided to provide dedicated
per-device interrupts for WAKE# and you may regard them as "wakeup
IRQs" except that the handling of each of them is the same as for the
"global WAKE#" above: if the PME Status of the device is set, put it
into D0 etc.  That part belongs to the PCI bus type layer IMO.

Of course, because nothing is easy and simple, there is a third case
in which one WAKE# line (and interrupt) can be shared by a subset of
devices on the bus and there are multiple (say two or three) subsets.

> Maybe this goes back to some confusion we had elsewhere: what is the
> meaning of "interrupt" in device tree?

Maybe.

> > > We just need to figure out a good way of representing it that doesn't stomp on the existing INTx
> > > definitions.
> >
> > WAKE# is a signal that is converted into an interrupt, but that
> > interrupt may arrive at some place your driver has nothing to do with.
>
> I could agree with that, perhaps. But that's also what Device Tree is
> all about, really. We describe the relation between devices. So some
> other <foo> handles events that are triggered by <bar>, so we use a
> phandle to relate <bar> to <foo>.

So you have a PCI endpoint on the one hand and the "wakeup serivce"
device on the other.

> > It generally doesn't make sense to represent it as an interrupt for
> > the target device.
>
> What would you suggest then? I'm not clearly understanding how you
> think we should (a) describe (in DT) and (b) implement this WAKE#
> handling.

I would introduce a "wakeup service" concept (along the lines of the
native PME) and make it request all interrupts associated with WAKE#.

In the case when the WAKE# interrupts are dedicated per-device, it
would be good to avoid walking the bus and use some
"wakeup-IRQ-to-device" mapping if available.

But as I said above, IMO the *handling* of all WAKE# interrupts
belongs to the PCI bus type as it is the same for all PCI devices.
