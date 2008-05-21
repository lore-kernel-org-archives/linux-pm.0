From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Suspend and hibernation patchset for 2.6.26-rc3
Date: Wed, 21 May 2008 23:29:57 +0200
Message-ID: <200805212329.59539.rjw__40625.3482135527$1211405487$gmane$org@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi,

For everyone interested, I have put together a patchset containing some "fresh"
patches related to suspend and hibernation, on top of 2.6.26-rc3, located at:

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.26-rc3/patches/

Patches 01-06 and 11 have been sent to Len as 2.6.27 material.  They have
been tested by me for some time (except for the most recent changes in patches
01 and 11) and have not lead to any problems so far.

Patches 07-10 are in the Jesse's PCI tree, targeted at 2.6.27.

Thanks,
Rafael
