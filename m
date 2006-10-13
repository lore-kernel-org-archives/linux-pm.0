From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-pm] Bug in PCI core
Date: Fri, 13 Oct 2006 17:06:02 +0100
Message-ID: <1160755562.25218.60.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	 <1160753187.25218.52.camel@localhost.localdomain>
	 <1160753390.3000.494.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751228AbWJMPkK@vger.kernel.org>
In-Reply-To: <1160753390.3000.494.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Adam Belay <abelay@MIT.EDU>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Ar Gwe, 2006-10-13 am 17:29 +0200, ysgrifennodd Arjan van de Ven:
> > And then you can fix the applications it breaks, like the X server which
> > does actually want to know where all the devices are located in PCI
> > space.
> > 
> 
> .. but which could equally well mmap the resource from sysfs ;)

That doesn't help deal with the location and PCI control side of things
X has to perform and deal with. You also forgot to attach the tested
patch set for the X server and other affected apps.

The cached stuff was put in place precisely because stuff broke
