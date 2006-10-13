From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [linux-pm] Bug in PCI core
Date: Fri, 13 Oct 2006 13:18:54 -0600
Message-ID: <20061013191854.GF11633@parisc-linux.org>
References: <1160760867.25218.77.camel@localhost.localdomain> <Pine.LNX.4.44L0.0610131355550.6612-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751825AbWJMTS4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610131355550.6612-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adam Belay <abelay@MIT.EDU>, Arjan van de Ven <arjan@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 13, 2006 at 01:57:48PM -0400, Alan Stern wrote:
> Would it be okay for pci_block_user_cfg_access() to use its own cache, so 
> it doesn't interfere with data previously cached by pci_save_state()?

My suggestion is just to require that the callers have previously called
pci_save_state().  The PCI PM stack already has, and it's a one-line
change to the IPR driver.
