From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 7/10] PCI / PCIe: Ask BIOS for control of all
	native services at once (v7)
Date: Sat, 21 Aug 2010 22:02:38 +0200
Message-ID: <201008212202.39084.rjw__27974.3948289708$1282421125$gmane$org@sisk.pl>
References: <201008060303.51224.rjw@sisk.pl> <201008210149.39576.rjw@sisk.pl>
	<201008210156.45644.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008210156.45644.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, August 21, 2010, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCIe port service drivers ask the BIOS, through _OSC, for control of
> the services they handle.  Unfortunately, each of them individually
> asks for control of the PCIe capability structure and if that is
> granted, some BIOSes expect that the other PCIe port services will be
> configured and handled by the kernel as well.  If that is not the
> case (eg. one of the PCIe port service drivers is not loaded), the
> BIOS may be confused and may cause the system as a whole to misbehave
> (eg. on one of such systems enabling the native PCIe PME service
> without loading the native PCIe hot-plug service driver causes a
> storm of ACPI notify requests to appear).
> 
> For this reason rework the PCIe port driver so that (1) it checks
> which native PCIe port services can be enabled, according to the
> BIOS, and (2) it requests control of all these services
> simultaneously.  In particular, this causes pcie_portdrv_probe() to
> fail if the BIOS refuses to grant control of the PCIe capability
> structure, which means that no native PCIe port services can be
> enabled for the PCIe root complex the given port belongs to.
> 
> Make it possible to override this behavior using 'pcie_ports=native'
> (use the PCIe native services regardless of the BIOS response to the
> control request), or 'pcie_ports=compat' (do not use the PCIe native
> services at all).
> 
> Accordingly, rework the existing PCIe port service drivers so that
> they don't request control of the services directly.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Well, yesterday I thought the old changelog would be fine, but I guess I was
too tired, because I really should have changed it.  Below is the new
changelong, but the patch itself is unmodified.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PCI / PCIe: Ask BIOS for control of all native services at once (v7)

After commit 852972acff8f10f3a15679be2059bb94916cba5d (ACPI: Disable
ASPM if the platform won't provide _OSC control for PCIe) control of
the PCIe Capability Structure is unconditionally requested by
acpi_pci_root_add(), which in principle may cause problems to
happen in two ways.  First, the BIOS may refuse to give control of
the PCIe Capability Structure if it is not asked for any of the
_OSC features depending on it at the same time.  Second, the BIOS may
assume that control of the _OSC features depending on the PCIe
Capability Structure will be requested in the future and may behave
incorrectly if that doesn't happen.  For this reason, control of
the PCIe Capability Structure should always be requested along with
control of any other _OSC features that may depend on it (ie. PCIe
native PME, PCIe native hot-plug, PCIe AER).

Rework the PCIe port driver so that (1) it checks which native PCIe
port services can be enabled, according to the BIOS, and (2) it
requests control of all these services simultaneously.  In
particular, this causes pcie_portdrv_probe() to fail if the BIOS
refuses to grant control of the PCIe Capability Structure, which
means that no native PCIe port services can be enabled for the PCIe
Root Complex the given port belongs to.  If that happens, ASPM is
disabled to avoid problems with mishandling it by the part of the
PCIe hierarchy for which control of the PCIe Capability Structure
has not been received.

Make it possible to override this behavior using 'pcie_ports=native'
(use the PCIe native services regardless of the BIOS response to the
control request), or 'pcie_ports=compat' (do not use the PCIe native
services at all).

Accordingly, rework the existing PCIe port service drivers so that
they don't request control of the services directly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 
