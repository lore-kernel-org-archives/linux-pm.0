From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFD] Asynchronous suspend/resume of PCI devices
Date: Sun, 20 Dec 2009 00:31:38 +0100
Message-ID: <200912200031.38775.rjw__33685.5280948386$1261265555$gmane$org@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi,

I'd like to know your opinions about the viability of suspending and resuming
PCI devices asynchronously during system-wide PM transitions (suspend to RAM
and hibernation).

Linus says it's generally dangerous, because some PCI devices may indirectly
depend on the others, but if that's the case, I wonder if we really can power
manage PCI devices at run time.

It follows from my experiments that suspending and resuming PCI devices
asynchronously doesn't lead to problems as long as we make sure that every
PCI device is suspended before and resumed after its ACPI "shadow" partner.
However, I'm not sure if this is generally correct.

What are possible problems we can run into while doing asynchronous suspend
and resume of PCI devices?  What do we need to do in general to avoid that
problems?

Please tell me what you think.

Thanks,
Rafael
