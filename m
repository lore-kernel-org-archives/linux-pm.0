From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/8] PCI run-time PM support (rev. 4)
Date: Wed, 17 Feb 2010 23:35:47 +0100
Message-ID: <201002172335.47703.rjw__17718.3812404566$1266446786$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi,

The following (updated) series of patches provides basic run-time power
management support for PCI devices through ACPI and/or the native PCIe
PME.

Patches [1/8] and [3/8] are unchanged, the other patches have been modified to
address the reviewers' comments and/or to fix reported bugs.

[1/8] - Add function for checking PME status of devices

[2/8][Updated] - PCIe PME root port service driver

[3/8] - "Don't use MSIs for PME signaling" switch for PCIe
 
[4/8][New] - ACPI GPE refcounting, based on 3 patches from Matthew Garrett
 
[5/8][Updated] - ACPI, add fields for handling run-wake devices

[6/8][New] - ACPI, make it possible to use more than 1 notify handler per node

[7/8][Updated] - PCI / ACPI platform support for run-time power management

[8/8] - Runtime PM callbacks for the PCI bus type

Bob, Len, patches [4/8] and [6/8] are vitally important for this feature, but
they cannot be merged without your approval.  Please let me know if you have
any objections to these patches.

Thanks,
Rafael
