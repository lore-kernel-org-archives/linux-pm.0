From: Greg KH <greg@kroah.com>
Subject: Re: [patch 2.6.13-rc2] PCI: Add symbol exports for pci_restore_bars
Date: Mon, 11 Jul 2005 10:18:30 -0700
Message-ID: <20050711171830.GA31050@kroah.com>
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com> <20050711144844.A16143@tin.liacs.nl> <20050711131518.GB23093@tuxdriver.com> <20050711131859.GC23093@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261357AbVGKRWN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050711131859.GC23093@tuxdriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Lennert Buytenhek <buytenh+lkml@liacs.nl>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk, matthew@wil.cx, grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, ambx1@neo.rr.com, byjac@matfyz.cz, herbertb@cs.vu.nl
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 11, 2005 at 09:19:03AM -0400, John W. Linville wrote:
> Globalize and add EXPORT_SYMBOL for pci_restore_bars.

EXPORT_SYMBOL_GPL() perhaps as this is a new function?

thanks,

greg k-h
