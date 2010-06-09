From: Alan Stern <stern@rowland.harvard.edu>
Subject: Wakeup races, PCI, and ACPI
Date: Wed, 9 Jun 2010 12:04:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006091148320.1728-100000__4138.36771990663$1276099511$gmane$org@iolanthe.rowland.org>
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
Cc: linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Rafael:

I see that the kacpi_notify_wq thread isn't freezable.  This means we
are subject to a race during system sleep transitions.  If a PCI device
is already runtime-suspended, then a PME# wakeup request could cause
kacpi_notify_wq to attempt a runtime resume at the same time as the
regular suspend or freeze method is running.  (The same is true for 
non-PCI devices and ACPI-platform-specific wakeup requests.)

Can kacpi_notify_wq be made freezable?  (Are ACPI wakeup notifications 
handled by any other workqueues?)  If not, should it call 
pm_request_resume() instead of pm_runtime_resume()?

Also, can this be handled in a way that doesn't end up losing wakeup 
events?  For quite some time, I've been thinking that any attempt to 
add a resume action to the pm workqueue should abort an ongoing system 
sleep, if device_may_wakeup() is true for the device in question.

Alan Stern
