From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC] PCI prepare/activate instead of enable to avoid IRQ
 storm and rogue DMA access
Date: Wed, 14 Mar 2007 19:16:47 -0400
Message-ID: <45F8825F.3030904@garzik.org>
References: <20070314152302.GB15600@htj.dyndns.org> <20070314215605.GA7194@flint.arm.linux.org.uk> <45F87863.9040408@garzik.org> <20070314225818.GB7194@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20070314225818.GB7194@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, michal.k.k.piotrowski@gmail.com, linux-ide@vger.kernel.org, tglx@linutronix.de, shemminger@linux-foundation.org, mlord@pobox.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Russell King wrote:
> In any case, relying on such a new control bit to implement this kind
> of functionality would result in a very hit and miss result; Linux

How does Tejun's patch or thesis rely on this new control bit?  He 
explicitly mentions DISABLE_INTX variability...

	Jeff


