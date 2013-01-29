From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] firewire: Fix ohci free_irq() warning
Date: Tue, 29 Jan 2013 12:01:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1301291158130.1507-100000@iolanthe.rowland.org>
References: <20130129170423.0f83cd31@stein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36716 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751392Ab3A2RBO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jan 2013 12:01:14 -0500
In-Reply-To: <20130129170423.0f83cd31@stein>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Mark Einon <mark.einon@gmail.com>, linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 29 Jan 2013, Stefan Richter wrote:

> Added Cc: linux-pm.
> 
> On Jan 29 Mark Einon wrote:
> > On 28 January 2013 23:01, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> > > On Jan 28 Mark Einon wrote:
> > >> This patch fixes the kernel warning generated when putting an MSI MS-1727
> > >> GT740 laptop into suspend mode. The call sequence in this case calls
> > >> free_irq() twice, once in pci_remove() and once then in pci_suspend().
> > >
> > > You mean /first/ in pci_suspend() and /then/ in pci_remove() on the
> > > already suspended devices, right?
> > 
> > Yes, I did. The call sequence is suspend then resume. My bad.

Why does the pci_suspend routine call free_irq() at all?  As far as I 
know, it's not supposed to do that.  Won't the device continue to use 
the same IRQ after it is resumed?

Alan Stern

