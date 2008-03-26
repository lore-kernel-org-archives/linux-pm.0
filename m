From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Suspend and hibernation patchset against -rc7
Date: Thu, 27 Mar 2008 00:51:31 +0100
Message-ID: <200803270051.31778.rjw__49554.6383121566$1206575697$gmane$org@sisk.pl>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803172317.33745.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Monday, 17 of March 2008, Rafael J. Wysocki wrote:
> On Wednesday, 12 of March 2008, Rafael J. Wysocki wrote:
> >
> > For everyone interested, I have put together a patchset containing some "fresh"
> > patches related to suspend and hibernation, on top of 2.6.25-rc5, located at:
> > 
> > http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc5/patches/
> 
> There's a new patchset against 2.6.25-rc6 at:
> 
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc6/patches/

There's a new patchset against 2.6.25-rc7 at:

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc7/patches/

It contains some more patches than the previous one.  Most importantly,
there are pm-remove-destroy_suspended_device.patch (from me) and
ACPI-force-acpi_new_pts_ordering-for-ASUS-A6VC-laptop.patch (from Shaohua) in
it.

I still have not decided what to do with patches 01-03.  Patch 03 will probably
be sent upstream soon, as well as patches 12 and 14.

Patch 04 is currently in the "test" branch of the ACPI tree and has been
tested already for some time in -mm and linux-next.

Patches 05-11 are in the Greg's tree and have been tested in -mm and
linux-next.

Patch 13 is in -mm.

Patches 15-17 are new, but they don't crash my box, so hopefully they're not
broken. ;-)
 
Everything has been compiled and (lightly) tested on HP nx6325 (64-bit).

Thanks,
Rafael
