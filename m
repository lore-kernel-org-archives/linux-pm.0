From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Suspend and hibernation patchset against -rc9
Date: Sun, 13 Apr 2008 19:39:13 +0200
Message-ID: <200804131939.14965.rjw__38670.2747121037$1208108556$gmane$org@sisk.pl>
References: <200803120129.25585.rjw@sisk.pl> <200803270051.31778.rjw@sisk.pl>
	<200804020227.12943.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804020227.12943.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Alexey Starikovskiy <astarikovskiy@suse.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi,

For everyone interested, there's a new suspend/hibernation patchset against
2.6.25-rc8 at:
  
http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc9/patches/
 
It contains one new patch picked up from -mm,
gregkh-driver-power_state-remove-it-from-driver-core.patch , that patch 16 is
based on.

I still have not decided what to do with patches 01-03.  Patch 03 will probably 
be sent upstream.

A new version of patch 04 has recently been included into the x86 git tree and
before it had been tested in -mm and linux-next for quite some time.

Patches 05-11 and 13 are in the Greg's tree and have been tested in -mm and
linux-next.
  
Patch 12 is in the ACPI test tree and has been tested in -mm and linux-next.

Patches 16-18 are the 5th revision of the patchset introducing new suspend and
hibernation callbacks for drivers.  They are in -mm and have just been resent to
Greg.

Thanks,
Rafael
