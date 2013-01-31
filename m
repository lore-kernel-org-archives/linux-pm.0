From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] firewire: Fix ohci free_irq() warning
Date: Thu, 31 Jan 2013 10:04:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1301311002190.1876-100000@iolanthe.rowland.org>
References: <CANK3SE09VqvshdLrV4xp2W8BHZqLmuz-pV9jQVj7tbk1JBX+9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51314 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753567Ab3AaPEB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jan 2013 10:04:01 -0500
In-Reply-To: <CANK3SE09VqvshdLrV4xp2W8BHZqLmuz-pV9jQVj7tbk1JBX+9g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Einon <mark.einon@gmail.com>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 30 Jan 2013, Mark Einon wrote:

> >> > >> This patch fixes the kernel warning generated when putting an MSI MS-1727
> >> > >> GT740 laptop into suspend mode. The call sequence in this case calls
> >> > >> free_irq() twice, once in pci_remove() and once then in pci_suspend().
> >> > >
> >> > > You mean /first/ in pci_suspend() and /then/ in pci_remove() on the
> >> > > already suspended devices, right?
> >> >
> >> > Yes, I did. The call sequence is suspend then resume. My bad.
> >
> > Why does the pci_suspend routine call free_irq() at all?  As far as I
> > know, it's not supposed to do that.  Won't the device continue to use
> > the same IRQ after it is resumed?
> 
> This sounds reasonable to me - I think we could probably get rid of
> the request_irq() call from resume, and use
> disable_irq()/enable_irq()?

Why mess around with IRQ settings at all?  Just have the suspend
routine tell the controller to stop generating them.

Alan Stern

