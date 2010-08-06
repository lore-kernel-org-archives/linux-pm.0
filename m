From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/10] ACPI / PCI / PCIe: Rework _OSC handling
	(v3)
Date: Fri, 6 Aug 2010 12:42:33 +0200
Message-ID: <201008061242.33319.rjw__9844.28326269171$1281091462$gmane$org@sisk.pl>
References: <201008060303.51224.rjw@sisk.pl> <4C5B80A4.2050503@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C5B80A4.2050503@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

First of all, thanks for the detailed review!

On Friday, August 06, 2010, Hidetoshi Seto wrote:
> (2010/08/06 10:03), Rafael J. Wysocki wrote:
> > Hi,
> > 
> > This is the 3rd iteration of the patchset based on
> > https://patchwork.kernel.org/patch/114917/ and the comments I received on that
> > patch and the previous two iterations of this patchset.
> > 
> > The patches below do not make the intermediate step to put an unconditional
> > _OSC query into acpi_pci_osc_control_set(), but the final result is quite
> > similar to the 2nd iteration with https://patchwork.kernel.org/patch/116976/
> > applied on top.
> > 
> > [1/10] - Introduce acpi_pci_osc_control_query() allowing the caller to get a
> >          mask of _OSC control bits the BIOS allows the kernel to control
> >          for a given PCI root bridge.  This version repeats _OSC queries until
> >          the BIOS doesn't mask any requested bits.
> 
> This contains 2 parts:
>  1-A) change acpi_status acpi_pci_query_osc() to take support and *control
>  1-B) introduce acpi_pci_osc_control_query()
> 
> and I'd like to kill 1-B since it is removed soon by patch [10/10].

OK

> > [2/10] - Introduce pci_aer_available() allowing the caller to check if the
> >          AER service driver should be enabled.
> > 
> > [3/10] - Introduce kernel command line switch pcie_ports=.
> 
> These 2 are prep for following big changes.
> 
> > 
> > [4/10] - Rework the PCIe port driver to request _OSC control for all serives at
> >          once.
> > 
> > [5/10] - Disable PCIe port services (that might be enabled by the BIOS) during
> >          initialization.
> 
> These 2 are core part to solve the issue.
> 
> > 
> > [6/10] - Remove the PCIe port driver modules exit function.
> 
> This is a cleanup. There is no reason to keep this in the series.

OK, I'll drop it.

> > [7/10] - Make PCI hotplug code query _OSC before requesting control of _OSC
> >          features.
> 
> Needless since removed soon by patch [10/10].

OK

> > [8/10] - Rework acpi_pci_osc_control_set() so that it doesn't use cached
> >         result of a query and remove the fields of struct acpi_pci_root that
> >         aren't used any more.
> 
> This also contains 2 parts:
>  8-A: don't use cached result
>  8-B: remove query in acpi_pci_osc_control_set()
> 
> I think 8-B is not required since query relives in patch [10/10].

OK
 
> > [9/10] - Reorder checks in acpi_pci_osc_control_set().
> 
> A minor cleanup can be out of the series.

OK, I'll drop it.
 
> > [10/10] - Merge acpi_pci_osc_control_set() with acpi_pci_osc_control_query().
> 
> This removes many badness in this series.
> I think we should have this improved acpi_pci_osc_control_set() before [4/10].

OK

> > Comments welcome.
> 
> I recommend you to rearrange the order of patches in this series.
>
> 1. Misc cleanups
>    [6/10]
>    [9/10]
> 2. Prep1: prepare small parts
>    [2/10]
>    [3/10]
> 3. Prep2: improve acpi_pci_osc_control_set()
>    [1-A]
>    [8-A]
>    [10/10]
> 4. Main
>    [4/10]
>    [5/10]

OK, I'll do that.

Probably, though, I will only be able to do it after I get back from LinuxCon.
At least I really won't be able to test the patches during the conference. :-)
 
> I think there is no objections to 4 patches from the first ([6,9,2,3/10]).

OK, thanks.

Best,
Rafael
