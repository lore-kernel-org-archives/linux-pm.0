From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC] PCI prepare/activate instead of enable to avoid IRQ
 storm and rogue DMA access
Date: Wed, 14 Mar 2007 18:34:11 -0400
Message-ID: <45F87863.9040408@garzik.org>
References: <20070314152302.GB15600@htj.dyndns.org> <20070314215605.GA7194@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20070314215605.GA7194@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
To: rmk+lkml@arm.linux.org.uk
Cc: Tejun Heo <htejun@gmail.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, michal.k.k.piotrowski@gmail.com, linux-ide@vger.kernel.org, tglx@linutronix.de, shemminger@linux-foundation.org, mlord@pobox.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Russell King wrote:
> pci_enable_device() doesn't deal with this; in most PCI setups I've
> seen, there is no control at PCI level over whether a device generates
> an interrupt on the bus.  Certainly the memory and io command enables

PCI grew an interrupt enable while you weren't looking: 
PCI_COMMAND_INTX_DISABLE

No idea about ARM, but almost all PCI devices made in the past few years 
support that bit.

Unless you are using a PCI Express device (maybe PCI-X too?), though, 
you cannot count on the bit's presence.  It was added in PCI 2.3 I 
think.  Older PCI devices certainly do not have this standardized bit.

	Jeff


