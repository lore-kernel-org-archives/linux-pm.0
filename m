From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [PATCH/RFC] PCI prepare/activate instead of enable to avoid IRQ
 storm and rogue DMA access
Date: Fri, 16 Mar 2007 14:21:31 -0700
Message-ID: <20070316142131.0a4cc953@freekitty>
References: <20070314152302.GB15600@htj.dyndns.org>
	<20070314100716.5965dca1@freekitty>
	<45F8B160.6010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <45F8B160.6010603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: gregkh@suse.de, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, michal.k.k.piotrowski@gmail.com, linux-ide@vger.kernel.org, tglx@linutronix.de, mlord@pobox.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

All this discussion is well and good, but I suspect there is a driver setup
problem where the interrupt isn't being handled properly. Please retest with
the latest version of skge driver (I just pushed patches to netdev about 2min ago).
One patch changes to disable IRQ's from device for packets until device
is brought up.

