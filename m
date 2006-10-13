From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-pm] Bug in PCI core
Date: Fri, 13 Oct 2006 22:25:50 +1000
Message-ID: <1160742350.4792.257.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
	 <1160701263.4792.179.camel@localhost.localdomain>
	 <1160729427.26091.98.camel@localhost.localdomain>
	 <1160731004.4792.245.camel@localhost.localdomain>
	 <mj+md-20061013.093014.26714.atrey@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751647AbWJMM3O@vger.kernel.org>
In-Reply-To: <mj+md-20061013.093014.26714.atrey@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Mares <mj@ucw.cz>
Cc: Adam Belay <abelay@MIT.EDU>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2006-10-13 at 11:31 +0200, Martin Mares wrote:
> Hi!
> 
> > For example, currently, if I power off the ethernet of my mac, or the
> > firewire chip (which are powered off if the module isn't loaded), lspci
> > will get the device id and vendor id right ... but won't get the class
> > code.
> 
> Ehm, you aren't using any recent pciutils, are you? ;-)

Whatever came with the distro that complained about the problem back
then :) I agree that the problem is fixed on the kernel level (sysfs)
and I'm happy to hear that pciutils is fixed too :) So we can probably
do what Adam suggest and just return errors or ff's

Ben.
