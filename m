From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/4] PCI run-time Power Management
Date: Fri, 9 Oct 2009 00:51:50 +0200
Message-ID: <200910090051.50932.rjw__15228.8887686611$1255042615$gmane$org@sisk.pl>
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
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following four patches implement some features needed for PCI run-time PM.

[1/4] adds a function for checking and clearing the PME status of a device

[2/4] adds support for PCIe native PME signaling mechanism

[3/4] adds support for ACPI-based PME signaling at run time

[4/4] adds prototype run-time PM callbacks for the PCI bus type

Patches [1/4] - [3/4] are rather complete, unless I missed something,
but [4/4] still requires some work.  For example, there should be some sort of
synchronization between the run-time PM and system-wide sleep transitions
which is missing at the moment.  In addition, it would make sense to
"autosuspend" PCI devices without drivers which has not been implemented
yet.

Comments welcome.

Thanks,
Rafael
