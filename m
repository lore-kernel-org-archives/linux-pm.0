From: Greg KH <greg@kroah.com>
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Wed, 8 Feb 2006 09:16:49 -0800
Message-ID: <20060208171649.GA21373@kroah.com>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208165803.GA15239@kroah.com> <20060208170857.GA29818@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030292AbWBHRRD@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060208170857.GA29818@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 08, 2006 at 05:08:58PM +0000, Matthew Garrett wrote:
> On Wed, Feb 08, 2006 at 08:58:03AM -0800, Greg KH wrote:
> > > +{
> > > +	down(&pm_sem);
> > 
> > Shouldn't this be a mutex?
> 
> It is, isn't it? The name's somewhat misleading, but I was just using 
> what already existed...

Ah, ok, nevermind, I thought this was new.

> +/**
> + *	pm_set_ac_status - Set the ac status callback. Returns true if the
> + *                         system is on AC and has a registered callback.

kerneldoc will not work with this.  It needs to be a one line, short,
description.  Put the full description below the function paramaters, it
can be as many lines as you want there.

thanks,

greg k-h
