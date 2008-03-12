From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Suspend and hibernation patchset
Date: Wed, 12 Mar 2008 01:29:24 +0100
Message-ID: <200803120129.25585.rjw__49163.813427049$1205281957$gmane$org@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi,

For everyone interested, I have put together a patchset containing some "fresh"
patches related to suspend and hibernation, on top of 2.6.25-rc5, located at:

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc5/patches/

I have not yet decided what to do with patches 01-03.  Patch 03 will probably
be sent upstream soon.

Patch 04 is currently in the "test" branch of the ACPI tree and has been
tested already for some time in -mm and linux-next.

Patches 05-08, being mainly fixes, have just been sent upstream.

Patch 09, which I'm considering as the most important one, is the first of
a series that will introduce a new suspend and hibernation framework for
device drivers.  It introduces the highest-level structures and documents
them, so if you are planning any modifications in this area, have a look at it
and please let me know if there are any conflicts, so that we can avoid them.

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
