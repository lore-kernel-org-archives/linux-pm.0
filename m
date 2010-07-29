From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / PCIe: Ask BIOS for control of all
	native services at once (v4)
Date: Thu, 29 Jul 2010 17:45:39 +0200
Message-ID: <201007291745.39285.rjw__35635.6657263406$1280418633$gmane$org@sisk.pl>
References: <201007282323.56351.rjw@sisk.pl>
	<20100728144358.5e2c12ce@virtuousgeek.org>
	<4C510B90.9070302@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C510B90.9070302@jp.fujitsu.com>
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
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, July 29, 2010, Kenji Kaneshige wrote:
> (2010/07/29 6:43), Jesse Barnes wrote:
> > On Wed, 28 Jul 2010 23:23:56 +0200
> > "Rafael J. Wysocki"<rjw@sisk.pl>  wrote:
> >
> >> From: Rafael J. Wysocki<rjw@sisk.pl>
> >>
> >> PCIe port service drivers ask the BIOS, through _OSC, for control of
> >> the services they handle.  Unfortunately, each of them individually
> >> asks for control of the PCIe capability structure and if that is
> >> granted, some BIOSes expect that the other PCIe port services will be
> >> configured and handled by the kernel as well.  If that is not the
> >> case (eg. one of the PCIe port service drivers is not loaded), the
> >> BIOS may be confused and may cause the system as a whole to misbehave
> >> (eg. on one of such systems enabling the native PCIe PME service
> >> without loading the native PCIe hot-plug service driver causes a
> >> storm of ACPI notify requests to appear).
> >>
> >> For this reason rework the PCIe port driver so that (1) it checks
> >> which native PCIe port services can be enabled, according to the
> >> BIOS, and (2) it requests control of all these services
> >> simultaneously.  In particular, this causes pcie_portdrv_probe() to
> >> fail if the BIOS refuses to grant control of the PCIe capability
> >> structure, which means that no native PCIe port services can be
> >> enabled for the PCIe root complex the given port belongs to.
> >>
> >> Make it possible to override this behavior using a new command line
> >> switch pcie_ports= that can be set to 'auto' (ask the BIOS, the
> >> default), 'native' (use the PCIe native services regardless of the
> >> BIOS response to the control request), or 'compat' (do not use the
> >> PCIe native services at all).
> >>
> >> Accordingly, rework the existing PCIe port service drivers so that
> >> they don't request control of the services directly.
> >>
> >> Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
> >> ---
> >
> > Kenji-san, are you ok with this version?  I would like to get your ack
> > (and ideally your tested-by) for this one since it affects
> > functionality you need.
> >
> 
> Hi Jesse, Rafael,
> 
> I've just started reviewing the latest version of the patch. I have good
> impression about this version so far. Please give me a few days for deeper
> review. And I've booked the test machine for this patch in next week. I'll
> try to test the patch and send you the result as soon as I can.
> 
> Here are two comments I have so far.
> 
> Though it is not directly related to Rafael's patch, I found one problem
> in _OSC query handling while reviewing this patch. Currently, all the
> _OSC controls are queried at the same time in acpi_pci_osc_support() and
> the result is preserved for later acpi_pci_osc_control_set() call. But
> query result can vary depending on the combination of requested controls.

In principle it can, but acpi_pci_query_osc() asks for all aplicable control
bits, in which case the formware can only clear those bits in the response if
the corresponding features are unsupported.  Doing otherwise would be in
violation of Section 6.2.9.1. of ACPI spec 3.0b, the following in particular:

"If any bits in the Control Field are returned cleared (masked to zero) by the _OSC control method,
the respective feature is designated unsupported by the platform and must not be enabled by the OS."

> So I think query result must not be preserved. Since Rafael's patch uses
> query result, this problem should be fixed at the same time. I'll try to
> make a patch for this and update Rafael's patch if needed.

It would be sufficient to change acpi_pci_osc_control_get(), introduced
by my patch, to call acpi_pci_query_osc() unconditionally, but as I said above,
I don't think it's necessary.

> I think the following changes should be done in the separated patch. I
> guess this change is for the BIOS which enables hotplug interrupt at when
> _OSC is evaluated with native hot-plug control. Right?

Yes, it is.

> Anyway, it should be separated patch with appropriate description.

But the $subject patch does analogous things for AER and PCIe PME.  Do you
think they also should be introduced by separate patches?

The rationale is that since we've told the BIOS, by requesting
OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL,  that we're going to take the
responsibility for the PCIe native services, we should disable them to a
minimum to prevent spurious events from occurring (the BIOS might have done
something to these bits before we called _OSC and it cannot legitimately do
anything else to them after it's granted control to us).

> +			/*
> +			 * Disable hot-plug interrupts in case the hot-plug
> +			 * service driver is not loaded.
> +			 */
> +			pos += PCI_EXP_SLTCTL;
> +			pci_read_config_word(dev, pos, &reg16);
> +			reg16 &= ~(PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +			pci_write_config_word(dev, pos, reg16);

Thanks,
Rafael
