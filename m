From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH v10 1/7] dt-bindings: PCI: Add definition of PCIe
 WAKE# irq and PCI irq
Date: Thu, 2 Nov 2017 14:55:01 -0700
Message-ID: <20171102215501.GD28152@atomide.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
 <20171027072612.26565-2-jeffy.chen@rock-chips.com>
 <20171027204513.GA105121@google.com>
 <20171101210541.vacfufnn2ms65xrw@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171101210541.vacfufnn2ms65xrw@rob-hp-laptop>
Sender: linux-pci-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org, bhelgaas@google.com, linux-pm@vger.kernel.org, shawn.lin@rock-chips.com, rjw@rjwysocki.net, dianders@chromium.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

* Rob Herring <robh@kernel.org> [171101 21:07]:
> On Fri, Oct 27, 2017 at 01:45:17PM -0700, Brian Norris wrote:
> > IMO, since you're trying to augment a standardized binding, you need to
> > be a lot clearer here. I expect you should mention the existing standard
> > (that devices may optionally include an 'interrupts' property that
> > represents the legacy PCI interrupt) and how you're augmenting it (that
> > additional interrupts can be supported optionally, but they require a
> > corresponding 'interrupt-names' property).
> 
> There's an additional complication that I'd guess the wakeup is 
> typically a GPIO line and hence a different parent. We have 2 options 
> there. The first is interrupts-extended which is generally implicitly 
> supported (i.e. we only document interrupts). The second is we already 
> have interrupt-map if we have legacy interrupts and can map to different 
> parents. For this to work, we'd have to use a number >4 for the wakeup 
> interrupts.

The wakeup interrupt can also be a separate always on interrupt
controller in addition to GPIOs. Anyways, the interrupts-extended
binding works well for these. And the interrupt-names we seem
to have standardized on are "irq" and "wakeup".

Regards,

Tony
