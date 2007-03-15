From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH/RFC] PCI prepare/activate instead of enable to avoid IRQ storm and rogue DMA access
Date: Thu, 15 Mar 2007 17:11:41 +0530
Message-ID: <20070315114141.GA10753@in.ibm.com>
References: <20070314152302.GB15600@htj.dyndns.org> <p73fy878pmg.fsf@bingen.suse.de>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <p73fy878pmg.fsf@bingen.suse.de>
Sender: linux-ide-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Tejun Heo <htejun@gmail.com>, gregkh@suse.de, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, michal.k.k.piotrowski@gmail.com, linux-ide@vger.kernel.org, tglx@linutronix.de, shemminger@linux-foundation.org, mlord@pobox.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 14, 2007 at 10:46:47PM +0100, Andi Kleen wrote:
> Tejun Heo <htejun@gmail.com> writes:
> > 
> > Let's assume there's a device which shares its INTX IRQ line with
> > another device and the other one is already initialized.  During boot,
> > due to BIOS's fault, bad hardware design or sheer bad luck, the device
> > has got a pending IRQ.
> 
> This seems to be also common after kexec during kexec crashdumps
> where the device just continues doing what it did before the crash.
> 

That's true. It happens very frequently in kdump case where underlying device
can very well have pending interrupts while second kernel is booting.
Currently we allow the kernel to disable that irq line and we boot the kernel
with "irqpoll" so that device still operates in polling mode.

But getting this fixed will help. If device interrupts are enabled only after
driver has had a chance to reset the device, things will be better, at least
from kdump perspective.

Thanks
Vivek
