From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Enable runtime PM automatically?
Date: Fri, 19 Dec 2014 11:08:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1412191059061.1599-100000@iolanthe.rowland.org>
References: <CAMuHMdWmy82=cnoSVD3gdEu=5Ttr1j-PJv6EXKYwbR3o_FEDiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42854 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751916AbaLSQIB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Dec 2014 11:08:01 -0500
In-Reply-To: <CAMuHMdWmy82=cnoSVD3gdEu=5Ttr1j-PJv6EXKYwbR3o_FEDiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

[CC: list trimmed drastically]

On Fri, 19 Dec 2014, Geert Uytterhoeven wrote:

> > Some thoughts: devices without drivers would be runtime resumed by the
> > core, but will never be suspended, so the PM domain will never shut
> > down.  I guess the core will have to keep track of the devices it
> > automatically runtime resumed and decide to runtime suspend them too?
> > Hmm, where would that go?
> 
> No, devices without a driver just need to become runtime PM enabled.
> They will only be resumed when a dependent device (e.g. a child) is resumed,
> and are suspended again after all dependents are suspended. That's how
> simple-pm-bus behaves.

What you"re talking about would be a tremendous job.  It would mean 
changing the interface presented to all the drivers and subsystems that 
currently support runtime PM.

And what would be the point?  Is there any significant advantage?  
Buses and drivers that are currently capable of using runtime PM do so 
already, using the current API.  Buses and drivers that are not capable 
of using runtime PM will remain that way even after you make this 
change; their devices will never go into runtime suspend.

Are you perhaps talking about something special that should happen only 
for devices that are part of a PM domain?

Alan Stern

