From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 2.6.14-rc1] pci: only call pci_restore_bars at boot
Date: Wed, 14 Sep 2005 09:26:50 -0700 (PDT)
Message-ID: <20050914.092650.99910742.davem@davemloft.net>
References: <09142005095242.32027@bilbo.tuxdriver.com>
	<43283CDC.3070603@pobox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030240AbVINQ1X@vger.kernel.org>
In-Reply-To: <43283CDC.3070603@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik@pobox.com
Cc: linville@tuxdriver.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, torvalds@osdl.org, akpm@osdl.org, ink@jurassic.park.msu.ru, kaos@sgi.com, greg@kroah.com, rmk+lkml@arm.linux.org.uk, matthew@wil.cx, grundler@parisc-linux.org, ambx1@neo.rr.com
List-Id: linux-pm@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Wed, 14 Sep 2005 11:08:12 -0400

> This seems like it will break a lot of stuff that -does- need the BARs 
> restored when resuming from D3.

I wasn't going to say anything about this ia64 workaround,
but yes I have to agree with Jeff, this change starts to
lose the whole point of the original change.

Why in the world can a PCI device not handle it's BARs being
rewritten, especially if we're just rewriting the same exact
values it had when we probed it beforehand?

IA64 could handle the necessary cases in it's PCI config space
access methods.  Ugly, but keeps the core clean and limits the
avoidance to the cases that really truly cannot handle the BAR
rewrites.
