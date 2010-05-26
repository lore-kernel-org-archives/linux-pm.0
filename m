From: Alan Stern <stern@rowland.harvard.edu>
Subject: Runtime PM for PCI-based USB host controllers
Date: Wed, 26 May 2010 11:51:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005261138330.1328-100000__11363.3682638921$1274889275$gmane$org@iolanthe.rowland.org>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Rafael:

I've been updating the patch Matthew Garrett posted last November, 
adding runtime PM methods for PCI USB controllers.  Overall the 
situation is now easier, since the rest of the USB subsystem has been 
converted over to the runtime PM framework.  And it even seems to work!

But there is one problem.  The device driver needs to know, during its
pm_suspend callback, whether or not wakeup should be enabled.  (Or more
accurately, the pm_suspend callback needs to fail if wakeup isn't going
to be available.)  However the wakeup decision isn't made in the PM
core until pci_pm_runtime_suspend() calls pci_finish_runtime_suspend(),
which doesn't occur until later.

Should the code be rearranged?  The parts about selecting the target 
state and pci_dev_run_wake() could be moved up into 
pci_pm_runtime_suspend().  But there still remains the question of how 
to let the driver know what the wakeup setting will be.  Any ideas?

Another question...  The PCI core doesn't call pm_runtime_enable() or
pci_runtime_set_active() anywhere.  Apparently this is left up to the
individual device driver.  But shouldn't the core take this
responsibility?  What happens to PCI devices for which there is no
driver?  Shouldn't the core put them into runtime suspend by default?

Alan Stern
