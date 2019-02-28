From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Date: Wed, 27 Feb 2019 18:29:21 -0800
Message-ID: <CA+ASDXNT9Taqfoz7R1Z926Vi1fMNNLYg5vqcZTw2m6JvXk+75w@mail.gmail.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <20190226232822.GA174696@google.com>
 <d67512fe-42b4-513f-d27a-fed85c19e9c2@arm.com>
 <CAKv+Gu_fZK7dUqrrVPCejAZNWyUeMUX2ojQ=vQ3hiMkGF6e6tw@mail.gmail.com>
 <20190227205754.GF174696@google.com>
 <CAJZ5v0gZFDdtbKQ6y52x+X8yoiPhP6BhGYZO=R_varx2nwuv5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAJZ5v0gZFDdtbKQ6y52x+X8yoiPhP6BhGYZO=R_varx2nwuv5g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Amitkumar Karwar <amitkarwar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Nishant Sarmukadam <nishants-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ganapathi Bhat <gbhat-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Xinming Hu <huxinming820-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "<netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "<linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Wed, Feb 27, 2019 at 3:04 PM Rafael J. Wysocki <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Feb 27, 2019 at 9:58 PM Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> > On Wed, Feb 27, 2019 at 11:16:12AM +0100, Ard Biesheuvel wrote:
> > > So I'd argue that we should add an optional 'wake-gpio' DT property
> > > instead to the generic PCI device binding, and leave the interrupt
> > > binding and discovery alone.
> >
> > So I think Mark Rutland already shot that one down; it's conceptually an
> > interrupt from the device's perspective.

Perhaps I shouldn't speak for Mark, but I am basically quoting him off IRC.

> Which device are you talking about?  The one that signals wakeup?  If
> so, then I beg to differ.

Yes, the endpoint device.

> On ACPI platforms WAKE# is represented as an ACPI GPE that is signaled
> through SCI and handled at a different level (on HW-reduced ACPI it
> actually can be a GPIO interrupt, but it still is handled with the
> help of AML).  The driver of the device signaling wakeup need not even
> be aware that WAKE# has been asserted.

Frankly, ACPI is not relevant to how we represent WAKE# in DT, IMO.
Also, we're talking about the *device*, not the driver. When talking
about Device Tree, that distinction is relevant.

So while the driver need not be aware (and I agree! it only needs to
care about enabling/disabling wake), *something* should be aware, and
the signal that "something" should be receiving is simply "did WAKE
happen"? That sounds basically like the device is signalling an
interrupt to me.

Maybe this goes back to some confusion we had elsewhere: what is the
meaning of "interrupt" in device tree?

> > We just need to figure out a good way of representing it that doesn't stomp on the existing INTx
> > definitions.
>
> WAKE# is a signal that is converted into an interrupt, but that
> interrupt may arrive at some place your driver has nothing to do with.

I could agree with that, perhaps. But that's also what Device Tree is
all about, really. We describe the relation between devices. So some
other <foo> handles events that are triggered by <bar>, so we use a
phandle to relate <bar> to <foo>.

> It generally doesn't make sense to represent it as an interrupt for
> the target device.

What would you suggest then? I'm not clearly understanding how you
think we should (a) describe (in DT) and (b) implement this WAKE#
handling.

Brian
