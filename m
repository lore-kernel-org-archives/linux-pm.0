From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [linux-pm] Bug in PCI core
Date: Fri, 13 Oct 2006 21:07:45 -0600
Message-ID: <20061014030745.GK11633@parisc-linux.org>
References: <1160780425.4792.275.camel@localhost.localdomain> <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030230AbWJNDHs@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Adam Belay <abelay@MIT.EDU>, Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 13, 2006 at 10:33:04PM -0400, Alan Stern wrote:
> That seems like a reasonable thing to do.  (BTW, can anyone explain 
> quickly what "BIST" means?)

Built In Self Test.  Devices can take up to 2 seconds to complete the
test, and some drop off the PCI bus while doing it.
