From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: x86: Increase PCIBIOS_MIN_IO to 0x1500 to fix nForce
 4 suspend-to-RAM
Date: Mon, 24 Dec 2007 16:40:46 -0600
Message-ID: <4770356E.1000407__11116.6882598356$1198536131$gmane$org@shaw.ca>
References: <fa.Tr7qmPdet0rF2FSRX/94s2UEMSE@ifi.uio.no>
	<fa.5MPS0t6OtOOALbc90ywKDrtik+4@ifi.uio.no>
	<fa.zg2cR0292Evub+o7LgQUdg4A7ZM@ifi.uio.no>
	<fa.ZBHAMdWAEaW7Flaz8/Gc8PLZUNg@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <fa.ZBHAMdWAEaW7Flaz8/Gc8PLZUNg@ifi.uio.no>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Carlos Corbacho wrote:
> On Monday 24 December 2007 18:34:21 Linus Torvalds wrote:
>> On Mon, 24 Dec 2007, Rafael J. Wysocki wrote:
>>> Well, having considered that for a longer while, I think the AML code is
>>> referring to a device that we have suspended already, and since it's in a
>>> low power state, it just can't handle the reference.
>>>
>>> If that is the case, we'll have to find the device (that should be
>>> possible using some code instrumentation) and move the suspending of it
>>> into the late stage.
>> Yes.
> 
> My own experimentation (in device_suspend(), calling _PTS() in the AML after 
> each suspend_device() runs, until one device causes it to hang) points to 
> ohci_hcd being the culprit here (with or without any devices attached). With 
> the ohci_hcd module unloaded, the machine suspends just fine[1].
> 
> Of course, I'm at a complete loss as to why suspending OHCI would cause a 
> problem for an IO port write.

The name of the operation region, SMIP, suggests that the BIOS has an 
SMI trap on that port. In that case, writing to that port will result in 
the BIOS taking control. We have little idea what it could be doing. 
Could be it's trying to access the OHCI controller which has been 
suspended already.

This sounds kind of like the Toshiba laptops that go nuts somewhere if 
the AHCI SATA controller gets put into suspend state before the system 
suspends..

The ACPI spec has the following to say about the _PTS method:

"The platform must not make any assumptions about the state of the 
machine when _PTS is called. For example, operation region accesses that 
require devices to be configured and enabled may not succeed, as these 
devices may be in a non-decoding state due to plug and play or power 
management operations."

I would guess some BIOS writers failed to heed this..

> 
>> NOTE! This following patch is just for discussion, and while I think it's
>> conceptually a good thing to try, I don't think it will help Carlos'
>> problem. But removing the "pci_set_power_state()" in agp_nvidia_suspend()
>> might.
> 
> nvidia-agp cannot be built on x86-64, so it's not the culprit in this case.

Yeah, and this is a PCI Express system not AGP, so it wouldn't load anyway.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
