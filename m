From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Power management for SCSI
Date: Wed, 13 Aug 2008 16:16:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808131613400.13982-100000@iolanthe.rowland.org>
References: <1218656526.3237.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754154AbYHMUQV@vger.kernel.org>
In-Reply-To: <1218656526.3237.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Oliver Neukum <oneukum@suse.de>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Aug 2008, James Bottomley wrote:

> > With the original patch, you can't operate on the link independent from 
> > the devices.  But with the revised patch (whenever I manage to find 
> > time to write it!), you _will_ be able to.
> 
> That sounds great .. if you link it through the transport class, that
> can implement the policy you want (as in power all devices down before
> the link for USB, but just power down the link for SAS/SATA).

Assuming we have a transport class for USB/Firewire!  That's the reason
I proposed adding such a thing.

Alan Stern
