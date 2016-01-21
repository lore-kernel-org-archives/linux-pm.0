From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Thu, 21 Jan 2016 19:56:36 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601211936260.3886@nanos>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org> <20160120190718.GS6357@twins.programming.kicks-ass.net> <alpine.DEB.2.11.1601202050050.3575@nanos> <56A0A9E3.2070306@linaro.org>
 <alpine.DEB.2.11.1601211128240.3873@nanos> <56A0E8F1.7010409@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56A0E8F1.7010409@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, 21 Jan 2016, Daniel Lezcano wrote:
> On 01/21/2016 02:52 PM, Thomas Gleixner wrote:

> > And why would that thing care about shared interruts at all? It's a legacy
> > burden and I really don't see a reason why that new thing which is
> > targeted on modern hardware should deal with them. Just treat them as a
> > single interrupt for now and be done with it.
> 
> If the shared interrupts are only related to old hardware, these ones
> shouldn't have cpuidle, hence there is no need to enable the irq timings. So
> you are right in this case and we can keep the feature simple.
> 
> On a other hand, Peter sent three examples of /proc/interrupts with shared
> interrupts. I don't know how old are the platforms and what are they, but it
> seems the shared irq are still used.

Well, its still there on x86 but slowly on the way out. What I meant with
legacy burden is, that the HW people finally got the idea that shared
interrupts are a horrible concept.

So we are seing them go away. My laptop (not the newest thingy) doesn't have
them anymore. Most devices use MSI now, except for the holdouts:

  0:         20          0          0          0   IO-APIC-edge      timer
  1:          1          1          5          3   IO-APIC-edge      i8042
  8:          5          6          0          4   IO-APIC-edge      rtc0
  9:        294       1231        118        318   IO-APIC-fasteoi   acpi
 12:         96       1748         55         76   IO-APIC-edge      i8042
 18:          0          0          0          0   IO-APIC  18-fasteoi   i801_smbus
 23:         11         12          8         51   IO-APIC  23-fasteoi   ehci_hcd:usb1

My latest server toy still has one shared entry:

   18-fasteoi   ehci_hcd:usb1, ehci_hcd:usb2, i801_smbus

which is just a complete braindamage on the hardware side. There are a
gazillion of free interrupt lines on that beast and of course they must route
3 devices to the same line.

We really should ignore that sillyness and if people complain, make them
complain to their HW vendor. That's the only way this crap will go away.

If we just keep on supporting this completely pointless nonsense the HW folks
will just not fix it.

We've been successful in the past to 'educate' hw people by making features
not available for mindless designs.

In this case we still support the feature, but it might be suboptimal. The
real interesting ports on that platform are MSI anyway, so I really couldn't
care less.

I have no idea how wide spread the shared nonsense is on the relevant ARM
platforms, but you might be able to figure that out faster than me.

Thanks,

	tglx
