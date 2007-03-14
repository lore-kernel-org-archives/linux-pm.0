From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH/RFC] PCI prepare/activate instead of enable to avoid IRQ storm and rogue DMA access
Date: Wed, 14 Mar 2007 22:58:18 +0000
Message-ID: <20070314225818.GB7194@flint.arm.linux.org.uk>
References: <20070314152302.GB15600@htj.dyndns.org> <20070314215605.GA7194@flint.arm.linux.org.uk> <45F87863.9040408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45F87863.9040408@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, michal.k.k.piotrowski@gmail.com, linux-ide@vger.kernel.org, tglx@linutronix.de, shemminger@linux-foundation.org, mlord@pobox.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 14, 2007 at 06:34:11PM -0400, Jeff Garzik wrote:
> Russell King wrote:
> >pci_enable_device() doesn't deal with this; in most PCI setups I've
> >seen, there is no control at PCI level over whether a device generates
> >an interrupt on the bus.  Certainly the memory and io command enables
> 
> PCI grew an interrupt enable while you weren't looking: 
> PCI_COMMAND_INTX_DISABLE

That's fine for devices which conform to the later PCI specs, but not
all do.

> It was added in PCI 2.3 I think.

Correct.

> Older PCI devices certainly do not have this standardized bit.

No PCI device that I have has that bit - including the raid card I
bought last year...

In any case, relying on such a new control bit to implement this kind
of functionality would result in a very hit and miss result; Linux
tends to get used on things other than the bleeding edge of hardware
technology.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
