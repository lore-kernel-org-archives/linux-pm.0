From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PCI: PM-related patches
Date: Mon, 7 Sep 2009 01:02:20 +0200
Message-ID: <200909070102.21056.rjw__27551.4340414249$1252278382$gmane$org@sisk.pl>
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
To: linux-pci <linux-pci@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

Hi,

I have three patches related to PM that I'd like to get some comments on.

First [1/3] moves the clearing of state_saved to pci_restore_state().

Second [2/3] makes pci_pm_resume() return the error codes it gets
from the drivers' callbacks (otherwise the error variable in there is useless).

Finally, [3/3] is my prototype implementation of run-time PM callbacks for
the PCI bus type (of course, to make PCI run-time PM work, we need to add
some PME-handling code as well, but experimental patches for that have been
posted already).

Thanks,
Rafael
