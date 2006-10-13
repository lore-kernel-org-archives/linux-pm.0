From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [linux-pm] Bug in PCI core
Date: Fri, 13 Oct 2006 17:29:50 +0200
Message-ID: <1160753390.3000.494.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	 <1160753187.25218.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751192AbWJMPaI@vger.kernel.org>
In-Reply-To: <1160753187.25218.52.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>, Adam Belay <abelay@MIT.EDU>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2006-10-13 at 16:26 +0100, Alan Cox wrote:
> Ar Gwe, 2006-10-13 am 10:29 -0400, ysgrifennodd Alan Stern:
> > > I'd like to propose that we have the pci config sysfs interface return
> > > -EIO  when it's blocked (e.g. active BIST or D3cold).  This accurately
> > > reflects the state of the device to userspace, reduces complexity, and
> > > could potentially save some memory per PCI device instance.
> > 
> > Could you resubmit your old patches and include a corresponding fix for 
> > this access problem?
> 
> And then you can fix the applications it breaks, like the X server which
> does actually want to know where all the devices are located in PCI
> space.
> 

.. but which could equally well mmap the resource from sysfs ;)


also the thing this patch does is ONLY when the device is effectively
off the bus return -EIO.
One can argue that -EAGAIN is nicer since it's only a temporary
condition though....
