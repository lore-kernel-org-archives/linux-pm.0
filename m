From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/4] usb: introduce usb force power off mechanism
Date: Mon, 8 Apr 2013 15:24:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1304081517240.1529-100000@iolanthe.rowland.org>
References: <20130408175519.GH6117@xanatos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53700 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1763113Ab3DHTYc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2013 15:24:32 -0400
In-Reply-To: <20130408175519.GH6117@xanatos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lenb@kernel.org, kristen.c.accardi@intel.com

On Mon, 8 Apr 2013, Sarah Sharp wrote:

> That could work.  However, we have to think about future platform power
> changes as well.  Coming up with a USB specific way to work around the
> runtime PM core will hurt us in the long run, if we end up having to
> change the runtime PM core for another kernel user.
> 
> Len, Rafael, and Kristen, is there a need from any of the future power
> work to have an 'off' mechanism added to the runtime PM core, so that
> power/control would have 'on', 'auto', and 'off' options?  It currently
> only has 'on' and 'auto'.

I can't say anything about future power work -- Len, Rafael, et al.  
will have to speak to that -- but the current design of the runtime PM
core doesn't allow for a distinction between "low power" and "no
power".  As far as the core is concerned, either the device is fully
active or else it isn't (i.e., it is suspended).  To change this would
be a major rewrite.

> The kernel is always going to be more conservative about what policies
> cause the 'auto' option to turn off USB ports.  A Linux distro may want
> to override those policies and force the port off, or power off a
> misbehaving device for a hard reset.  That's why we need an 'off'
> extension to power/control to bypass the runtime PM usage counts and
> power something off.
> 
> Are there analogous needs for other users of power/control?

In fact, some other people have made similar requests.  I can't 
remember the exact contexts now...  One of them may have been related 
to the PCI D4cold stuff.

Alan Stern

