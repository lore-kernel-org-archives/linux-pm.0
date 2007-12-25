From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: x86: Increase PCIBIOS_MIN_IO to 0x1500 to fix nForce
	4 suspend-to-RAM
Date: Tue, 25 Dec 2007 00:03:25 +0000
Message-ID: <200712250003.27570.carlos__2446.90286131135$1198781849$gmane$org@strangeworlds.co.uk>
References: <fa.Tr7qmPdet0rF2FSRX/94s2UEMSE@ifi.uio.no>
	<fa.ZBHAMdWAEaW7Flaz8/Gc8PLZUNg@ifi.uio.no>
	<4770356E.1000407@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4770356E.1000407@shaw.ca>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Monday 24 December 2007 22:40:46 Robert Hancock wrote:
> The ACPI spec has the following to say about the _PTS method:
>
> "The platform must not make any assumptions about the state of the
> machine when _PTS is called. For example, operation region accesses that
> require devices to be configured and enabled may not succeed, as these
> devices may be in a non-decoding state due to plug and play or power
> management operations."

That is from the 3.0 spec though. And it looks like the definition changed 
from pre-3.0 to 3.0 and above.

This is what the 1.0B spec says (and this is also repeated verbatim in 2.0, 
2.0a, 2.0b, and 2.0c):

"The _PTS control method is executed by the operating system at the beginning 
of the sleep process for S1, S2, S3, S4, and for orderly S5 shutdown. The 
sleeping state value (1, 2, 3, 4, or 5) is passed to the _PTS control method. 
Before the OS notifies native device drivers and prepares the system software 
for a system sleeping state, it executes this ACPI control method. Thus, this 
control method can be executed a relatively long time before actually 
entering the desired sleeping state. In addition, the OS can abort the 
sleeping operation without notification to the ACPI driver, in which case 
another _PTS would occur some time before the next attempt by the OS to enter 
a sleeping state. The _PTS control method cannot modify the current 
configuration or power state of any device in the system. For example, _PTS 
would simply store the sleep type in the embedded controller in sequencing 
the system into a sleep state when the SLP_EN bit is set."

According to the earlier versions of the ACPI spec, Linux is doing the wrong 
thing - we should call _PTS() before we start powerding down devices, or 
notifying device drivers to start suspending.

So, my limited understanding of what we currently do for ACPI suspend-to-RAM 
is:

1) Freeze processes/ devices
2) Put all devices into low power mode
3) Execute _PTS()
4) Suspend system

So the problem is - our current suspend order is fine for ACPI 3.0 and above, 
but for pre-3.0 systems, this violates the older specs, where 2) and 3) 
should be reversed.

> I would guess some BIOS writers failed to heed this..

No, it looks like the BIOS is obeying the older specs, and Linux is at fault 
here for breaking the suspend logic of pre ACPI 3.0 systems.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
