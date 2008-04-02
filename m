From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PM: Rework suspend and hibernation code
	for devices (rev. 4)
Date: Wed, 2 Apr 2008 02:07:39 +0200
Message-ID: <200804020207.40278.rjw__26300.7894893692$1207095303$gmane$org@sisk.pl>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi,

This is the 4th revision of the patches intended to start the redesign of the suspend
and hibernation framework for devices, addressing (hopefully) all of the recent
comments.

Patch [1/3] is the 7th revision of the patch introducing new callbacks for
suspend and hibernation.

The other two patches implement the new suspend and hibernation callbacks
for the platform and PCI bus types (3rd revision of both).

The main differences between these patches and the previous revision:
* Dropped DPM_INVALID and made the PM core only report errors returned by
  resume callbacks, without handling them in any other way
* Updated the comments in pm.h accordingly
* Added a function for printing error messages to main.c

The platform and PCI patches are unchanged.

More comments welcome.

Thanks,
Rafael
