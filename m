From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [PATCH/RFC] PCI prepare/activate instead of enable to avoid IRQ storm and rogue DMA access
Date: Thu, 15 Mar 2007 00:45:45 -0600
Message-ID: <20070315064545.GC14839@colo.lackof.org>
References: <20070314152302.GB15600@htj.dyndns.org> <20070314100716.5965dca1@freekitty> <45F8B160.6010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45F8B160.6010603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Stephen Hemminger <shemminger@linux-foundation.org>, gregkh@suse.de, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, michal.k.k.piotrowski@gmail.com, linux-ide@vger.kernel.org, tglx@linutronix.de, mlord@pobox.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 15, 2007 at 11:37:20AM +0900, Tejun Heo wrote:
...
> Also, the current implementation doesn't have any arch independent part. 

I thnk you meant "arch dependent" here.

>  It's wholly contained in arch independent PCI layer, but it might be 
> beneficial to have arch dependent hooks (IRQ line enable/disable?) in 
> the future.
> 
> >What if the device with the IRQ problem is never loaded? Sometimes
> >devices aren't loaded until after boot.
> 
> What do you mean by loading a device?  Do you mean loading driver for 
> the device?

Yes, I think that's what he meant.

> >Any change like this has to be done without changing device drivers.
> >Changing the skge/sky2 drivers as special case is not acceptable.

I don't like the idead of changing the driver API for PCI device setup.
But if it's necessary to solve this class of problem, I think it's ok.

> I dunno about that.  What I'm proposing is alternative two-step PCI 
> initialization step - the first step enables the device just enough for 
> initialization/reset and the second one enables full access.  We're 
> doing part of it already for bus master.  I'm proposing to expand that 
> approach and make them handled by generic PCI layer.  As you can see, it 
> doesn't add noticeable complexity to drivers.  I think it's even clearer 
> than doing pci_set_master() explicitly.

Please update Documentation/pci.txt to reflect the API changes too.

> If this way of solving the problem is chosen, eventually most drivers 
> should be converted to new initialization steps.  And there is no way to 
> do this without modifying low level driver.  Only low level driver knows 
> when full blown access can be enabled and such thing must happen before 
> registering the device to upper layer (e.g. ATA/SCSI, netif).

Agreed. ISTR this has been discussed before but don't recall
the exact context. I'll try to find the previous thread.

When I started the parisc port on 2.4 kernels, the policy was to
leave all interrupts enabled even if no interrupt handler was registered.
This is useful for debugging misconfigured IRQ routing.
Did the policy already change or is this a proposal to change the policy?

thanks,
grant

> sky2/skge aren't exceptions.  If this way of solving the problem is 
> chosen, eventually most if not all drivers should be converted to new 
> model.  It may take two years, maybe five, but as a start just 
> converting ATA and network drivers shouldn't take too long and that 
> would help a lot of cases.
> 
> Thanks.
> 
> -- 
> tejun
