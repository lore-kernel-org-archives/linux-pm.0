From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc6 0/7] misc pm wake patches
Date: Thu, 20 Mar 2008 14:08:33 -0700
Message-ID: <200803201408.33466.david-b__49929.0269487121$1206048781$gmane$org@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Here are patches I've had sitting around for a while ... many of
them are IMO now mergeable, but I think the last two need work
to integrate better with ACPI and PCI.

 - Crosslink ACPI and matching "real" device nodes in sysfs.
   Updated version of a patch from early last year.

 - acpi_pm_device_sleep_state() cleanup

 - pci_choose_state() cleanup and fixes (but arguably this
   needs to change given the new method scheme)

 - USB uses pci_choose_state(), seems safe given those fixes

 - Make ACPI set up device.power.can_wakeup driver model flags

 - Make ACPI use device_may_wakeup(dev) policy inputs from
   userspace, instead of /proc/acpi/wakeup ... probably needs
   work yet given the method reordering stuff

 - Make PCI set up device.power.can_wakeup flags ... presumably
   this still breaks on PPC, which needs more work.
