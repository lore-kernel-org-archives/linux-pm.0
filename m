From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/4] PCI / ACPI PM: Run-time PM,
	PME handling and PCI bus type callbacks
Date: Sun, 13 Sep 2009 23:20:04 +0200
Message-ID: <200909132320.05077.rjw__1888.78489793769$1252877324$gmane$org@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following patches implement experimental run-time PM support for PCI bus
type.

[1/4] - add PME status checking/clearing
[2/4] - Implement native PCIe PME driver for root ports
[3/4] - Add ACPI platform support for PCI PME signaling
[4/4] - Implement run-time PM callbacks for the PCI bus type

All of this is highly theoretical, because I didn't have the time to add
runtime PM callbacks to any drivers I can test, but at least the patchset
compiles and doesn't break things outright.

Comments welcome.

Thanks,
Rafael
