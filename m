From: Adam Belay <abelay@novell.com>
Subject: Re: [RFC][PATCH 5/6] PCI PM: kzalloc() cleanup
Date: Wed, 16 Nov 2005 02:21:33 -0500
Message-ID: <1132125693.3656.9.camel@localhost.localdomain>
References: <1132111891.9809.57.camel@localhost.localdomain>
	 <20051116062257.GC31375@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751172AbVKPHMq@vger.kernel.org>
In-Reply-To: <20051116062257.GC31375@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2005-11-15 at 22:22 -0800, Greg KH wrote:
> On Tue, Nov 15, 2005 at 10:31:31PM -0500, Adam Belay wrote:
> > Use kzalloc() instead of kmalloc() and memset().
> > 
> > 
> > --- a/drivers/pci/pm.c	2005-11-08 17:10:37.000000000 -0500
> > +++ b/drivers/pci/pm.c	2005-11-08 17:11:33.000000000 -0500
> > @@ -300,12 +300,10 @@
> >  		return -EIO;
> >  	}
> >  
> > -	dev->pm = pm_data = kmalloc(sizeof(struct pci_dev_pm), GFP_KERNEL);
> > +	dev->pm = pm_data = kzalloc(sizeof(struct pci_dev_pm), GFP_KERNEL);
> >  	if (!pm_data)
> >  		return -ENOMEM;
> >  
> > -	memset(pm_data, 0, sizeof(struct pci_dev_pm));
> > -
> 
> You can merge this back with your other patch :)
> 
> thanks,
> 
> greg k-h

Will do.

Thanks,
Adam
