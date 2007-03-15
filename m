From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC] PCI prepare/activate instead of enable to avoid IRQ
 storm and rogue DMA access
Date: Thu, 15 Mar 2007 11:37:20 +0900
Message-ID: <45F8B160.6010603@gmail.com>
References: <20070314152302.GB15600@htj.dyndns.org> <20070314100716.5965dca1@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20070314100716.5965dca1@freekitty>
Sender: linux-ide-owner@vger.kernel.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: gregkh@suse.de, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, michal.k.k.piotrowski@gmail.com, linux-ide@vger.kernel.org, tglx@linutronix.de, mlord@pobox.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Stephen Hemminger wrote:
> The problem is the BIOS is busted on these machines. How much effort
> do we want to put into dealing with systems with broken BIOS?
> I would rather have the root cause fixed than creating a bandaid that
> has to be maintained for all the other architectures and platforms.

For sky2/skge, it might be caused by broken BIOS.  For some ATA devices, 
it's just the hardware which is designed that way.  Also, under non-x86 
machines and during resume, there's no BIOS to nudge chips into sane 
state.  This is an existing problem which has to be solved.  How much 
effort we are gonna put into it is certainly debatable.

Also, the current implementation doesn't have any arch independent part. 
  It's wholly contained in arch independent PCI layer, but it might be 
beneficial to have arch dependent hooks (IRQ line enable/disable?) in 
the future.

> What if the device with the IRQ problem is never loaded? Sometimes
> devices aren't loaded until after boot.

What do you mean by loading a device?  Do you mean loading driver for 
the device?  The patch as posted is probably not a complete solution. 
We probably need to make sure during early boot and resume that all IRQ 
/ bus master are turned off where possible and let low level drivers 
enable them as needed and after certain amount of initialization is 
performed.

> If you use MSI interrupts, they aren't shared so there isn't a problem.
> Maybe the root cause of this is bad MSI emulation handling in BIOS.

Yes, if MSI is used things are better.

> Any change like this has to be done without changing device drivers.
> Changing the skge/sky2 drivers as special case is not acceptable.

I dunno about that.  What I'm proposing is alternative two-step PCI 
initialization step - the first step enables the device just enough for 
initialization/reset and the second one enables full access.  We're 
doing part of it already for bus master.  I'm proposing to expand that 
approach and make them handled by generic PCI layer.  As you can see, it 
doesn't add noticeable complexity to drivers.  I think it's even clearer 
than doing pci_set_master() explicitly.

If this way of solving the problem is chosen, eventually most drivers 
should be converted to new initialization steps.  And there is no way to 
do this without modifying low level driver.  Only low level driver knows 
when full blown access can be enabled and such thing must happen before 
registering the device to upper layer (e.g. ATA/SCSI, netif).

sky2/skge aren't exceptions.  If this way of solving the problem is 
chosen, eventually most if not all drivers should be converted to new 
model.  It may take two years, maybe five, but as a start just 
converting ATA and network drivers shouldn't take too long and that 
would help a lot of cases.

Thanks.

-- 
tejun
