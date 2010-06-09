From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Wakeup races, PCI, and ACPI
Date: Thu, 10 Jun 2010 01:30:48 +0200
Message-ID: <201006100130.48861.rjw__33779.6344109394$1276126419$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006091148320.1728-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006091148320.1728-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-pci@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 09, 2010, Alan Stern wrote:
> Rafael:
> 
> I see that the kacpi_notify_wq thread isn't freezable.  This means we
> are subject to a race during system sleep transitions.  If a PCI device
> is already runtime-suspended, then a PME# wakeup request could cause
> kacpi_notify_wq to attempt a runtime resume at the same time as the
> regular suspend or freeze method is running.  (The same is true for 
> non-PCI devices and ACPI-platform-specific wakeup requests.)

That, among other things, is why PCI devices are runtime resumed automatically
by the PCI subsystem in its pm->prepare() callback.

Thanks,
Rafael
