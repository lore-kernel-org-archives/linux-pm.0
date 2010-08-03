From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 0/8] ACPI / PCI / PCIe: Rework _OSC handling
	(v2)
Date: Tue, 03 Aug 2010 13:51:16 +0900
Message-ID: <4C57A044.2020706__33373.4957072467$1280811230$gmane$org@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008022351.31406.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

(2010/08/03 6:51), Rafael J. Wysocki wrote:
> Hi,
>
> This is the second iteration of the patchset based on
> https://patchwork.kernel.org/patch/114917/ and the comments I received on that
> patch.  Hopefully, I took all of the comments into account this time.
>
> [1/8] - Introduce acpi_pci_osc_control_query() allowing the caller to get a
>          mask of _OSC control bits the BIOS allows the kernel to control
>          for a given PCI root bridge.
>
> [2/8] - Introduce pci_aer_available() allowing the caller to check if the
>          AER service driver should be enabled.
>
> [3/8] - Introduce kernel command line switch pcie_ports=.
>
> [4/8] - Rework the PCIe port driver to request _OSC control for all serives at
>          once.
>
> [5/8] - Disable PCIe port services (that might be enabled by the BIOS) during
>          initialization.
>
> [6/8] - Remove the PCIe port driver modules exit function.
>
> [7/8] - Rework acpi_pci_osc_control_set() so that it doesn't use cached
>          result of a query and remove the fields of struct acpi_pci_root that
>         aren't used any more.
>
> [8/8] - Reorder checks in acpi_pci_osc_control_set()
>

Hi Rafael,

I'm sorry for delayed responding.

Your latest patchset looks much clearer than mine.
I have comments on [1/8] and [7/8]. I'll send comment for each patch.

Thanks,
Kenji Kaneshige
