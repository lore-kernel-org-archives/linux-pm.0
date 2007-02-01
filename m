From: Zhu Yi <yi.zhu@intel.com>
Subject: Re: [Ipw2100-devel] [RFC] Runtime power management on ipw2100
Date: Thu, 01 Feb 2007 09:47:05 +0800
Message-ID: <1170294425.6601.182.camel@debian.sh.intel.com>
References: <20070131075249.GA22115@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20070131075249.GA22115@srcf.ucam.org>
Sender: netdev-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ipw2100-devel@lists.sourceforge.net, netdev@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2007-01-31 at 07:52 +0000, Matthew Garrett wrote:
> Based on previous discussions, I've implemented a rough attempt at 
> providing some level of basic runtime power management on the ipw2100 
> chipset. This patch does the following:
> 
> 1) On load, it initialises the hardware and then quiesces it again
> 2) On interface up, it powers the hardware back up
> 3) On interface down, it powers the hardware down and puts the chip in 
> D3
> 4) It attempts to behave correctly over suspend/resume - ie, if the 
> interface was down beforehand, it will ensure that the chip is powered 
> down

>From my understanding, the intention of this patch is to defer the
device self-initialization work (including firmware loading) from netdev
initialization time to netdev open time (ifconfig up) and de-initialize
the device when it is not being used (ifconfig down). This saves power
during the time the driver is loaded but the interface is not open.

You should remove ipw2100_up() from ipw2100_net_init() which is
netdev->init() since it will be called in ->open() in your patch. I'd
also suggest you to request_irq()/free_irq() in the netdev ->open() and
->close() in case the device shares IRQ with other devices, the
interrupt handler should not be invoked anyway.

Thanks,
-yi
