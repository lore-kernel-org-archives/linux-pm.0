From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: PME# for add-on cards
Date: Mon, 24 Aug 2009 01:12:39 +0200
Message-ID: <200908240112.39424.rjw__26674.4239409038$1251069293$gmane$org@sisk.pl>
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
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Recently we've had a bug report indicating that WoL doesn't work with e100,
although the driver does everything needed to support it.  Apparently, the user
had to echo PCI0 to /proc/acpi/wakeup to make it work.

After some debugging it turned out that PCI0 is the PCI host bridge
(no-bus:pci0000:00), so apparently echoing PCI0 to /proc/acpi/wakeup causes
a wake-up GPE to be set up for the host bridge which triggers wake-up once
eth0 signals PME#.

So, it looks like we need to set up wake-up GPE for a host bridge for PME#
from add-on cards to work, at least on this particular box.

First, I wonder if that's the case in general (anybody knows?).  Second, if
that is the case, would it be a good idea to set up the host bridge wake-up GPE
by default?

Rafael
 
