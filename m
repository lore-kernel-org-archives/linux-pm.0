From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] ACPI vs device ordering on resume
Date: Tue, 14 Nov 2006 15:59:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611141545440.4144@woody.osdl.org>
References: <20061114153026.730deb94@freekitty>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20061114153026.730deb94@freekitty>
Sender: linux-acpi-owner@vger.kernel.org
To: Stephen Hemminger <shemminger@osdl.org>
Cc: len.brown@intel.com, Greg KH <greg@kroah.com>, Pavel Machek <pavel@suse.cz>, linux-acpi@vger.kernel.org, linux-pm@osdl.org, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 14 Nov 2006, Stephen Hemminger wrote:
> 
> During the pci_restore process, the MSI information and the PCI command register 
> are restored properly. But later during resume, inside the ACPI evaluation of
> the WAK method, the PCI_COMMAND  INTX_DISABLE (0x400) flag is being cleared.
> My guess is that the BIOS ends up doing some resetting of devices.

Hmm.. I think calling "pm_ops->finish()" early is the right thing to do, 
so your patch looks fine. I'd hate to apply it at this stage in the 2.6.19 
development, though. Comments?

Looking at the code (at least for ACPI), pm_ops->finish() function does 
things that we'd generally want done early. I'm a bit nervous about the 
"nesting", though - we call the "->prepare" function _before_ we do the 
device suspend stuff, so if "->finish" undoes something that was done by 
"->prepare", then we will restore the devices with the state they were in 
_after_ the "->prepare".

So from a logical _nesting_ perspective, the "->finish()" routine should 
happen after devices have been restored. And anything that ACPI does to 
undo "->enter" should have been done early by ACPI itself as it was 
exiting that "->enter" routine - that would make the things nest properly.

Gaah. Since there is no way to know what the HELL those ACPI routines will 
actually end up doing, there is no way to know what is the right answer. 
Does anybody know what Windows does? 

I think Stephen's patch is likely good, but I really don't see myself 
applying it to my tree right now. It should either go into -mm, or early 
into the post-2.6.19 tree (or, most likely, both).

Anybody?

		Linus
