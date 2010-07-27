From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH] PCI / PCIe: Ask BIOS for control of all
	native	services simultaneously
Date: Tue, 27 Jul 2010 18:18:42 +0100
Message-ID: <20100727171842.GB7324__49595.4923019328$1280251198$gmane$org@srcf.ucam.org>
References: <201007250105.23610.rjw@sisk.pl> <4C4E2BBD.7080003@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C4E2BBD.7080003@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 27, 2010 at 09:43:41AM +0900, Kenji Kaneshige wrote:

> I think this will break PCIe services currently working. For example,
> firmware doesn't grant PCIe AER control on my hardware. On the other
> hand, firmware grants PCIe native hot-plug control on the same machine.
> So I think PCIe hot-plug will not work with your patch. Another example,
> what would happen on the platform that doesn't have any PCIe hot-plug
> slot? I guess firmware doesn't grant PCIe native hot-plug control on
> that environment. So I think all the other PCIe port services would
> not work on such platform.

I've done some more testing of this and found that my intial belief 
(supported by Microsoft's documentation...) that all PCIe support had to 
be handed over for any to be used is incorrect. It turns out that the 
firmware must support native hotplug, native power management and PCI 
express capability structure control - ie, SHPC and AER aren't required.

However, if any of the other flags are missing then Windows doesn't use 
any PCIe functionality on the system. That's the behaviour we wish to 
duplicate.

> (1) Query all controls for PCIe port services and see what controls
>     will be granted to OS by firmware.
> (2) Request all the controls acquired in step (1) at the same time.
> (3) Create PCIe port services for those controls.
>
> What do you think about this?

I think we need to do:

(1) Query all controls and see what will be granted
(2) If any of bits 0, 2 and 4 are unsupported, disable all PCIe support 
via _OSC
(3) Ask for the set of supported bits & 0x1d

> I think there is still a problem that needs to be addressed. The 
> problem is that if ACPIPHP (ACPI based hot-plug driver) is required 
> for PCIe hot- plug, all the PCIe port services needs to be disabled. I 
> don't think it is acceptable for ACPIPHP users.

I believe that that's the only way Windows will work on their system, 
which generally implies that that's how the machine was intended to run.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
