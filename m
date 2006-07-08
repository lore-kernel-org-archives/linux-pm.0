From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [BUG] sleeping function called from invalid context
 during resume
Date: Fri, 7 Jul 2006 20:45:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607072043150.16856-100000@netrider.rowland.org>
References: <20060708003003.GE1700@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20060708003003.GE1700@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 8 Jul 2006, Pavel Machek wrote:

> > I didn't propose that kmalloc callers peek at system_state.
> > I proposed that system_state be set properly on resume
> > exactly like it is set on boot -- SYSTEM_RUNNING means
> > we are up with interrupts enabled.
> > 
> > Note that this issue is not specific to ACPI, any other code
> > that calls kmalloc during resume will hit __might_sleep().
> > This is taken care of by system_state in the case of boot
> > and the callers don't know anything about it -- resume
> > is the same case and should work the same way.
> 
> I'd agree with Andrew here -- lets not mess with system_state. It is
> broken by design, anyway.
> 
> Part of code would prefer SYSTEM_BOOTING during resume (because we are
> initializing the devices), but I'm pretty sure some other piece of
> code will get confused by that.

Whichever way you guys decide this should go, let me know.  I'm sitting on 
a patch for ACPI (a couple of routines that make blocking calls with 
interrupts disabled) and I'd like to know what to do with it.  Should I 
just send it to Len and linux-acpi as is?

Alan Stern

