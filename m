From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Suspend and hibernation patchset against -rc6
Date: Mon, 17 Mar 2008 23:17:32 +0100
Message-ID: <200803172317.33745.rjw__32136.2793366008$1205792583$gmane$org@sisk.pl>
References: <200803120129.25585.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803120129.25585.rjw@sisk.pl>
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

On Wednesday, 12 of March 2008, Rafael J. Wysocki wrote:
>
> For everyone interested, I have put together a patchset containing some "fresh"
> patches related to suspend and hibernation, on top of 2.6.25-rc5, located at:
> 
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc5/patches/

There's a new patchset against 2.6.25-rc6 at:

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc6/patches/

It contains some more patches, specifically the "legacy PM removal" series, the
fixed "PM: make wakeup flags available whenever CONFIG_PM is set" series posted
recently by Alan (the second patch rebased by me), the Johannes' apm-emulation
patch and the patches introducing the new suspend/hibernation callbacks I sent
yesterday.

These remarks still apply:

> I have not yet decided what to do with patches 01-03.  Patch 03 will probably
> be sent upstream soon.
> 
> Patch 04 is currently in the "test" branch of the ACPI tree and has been
> tested already for some time in -mm and linux-next.

Also, patches 05-06 are upstream (in the Greg's tree).

Everything has been compiled and (lightly) tested on HP nx6325 and Asus L5D
(both 64-bit).

Thanks,
Rafael
