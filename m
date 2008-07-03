From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Handling of suspend/hibernation patches
Date: Thu, 3 Jul 2008 22:47:32 +0200
Message-ID: <200807032247.34049.rjw__20087.6824245372$1215118123$gmane$org@sisk.pl>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Recently, we've had some problems with the handling of suspend/hibernation
patches, because they tend to touch multiple subsystems at a time.  As a
result, it usually is not clear which tree they should be included in and at
the moment there are suspend/hibernation patches in the PCI, ACPI, x86
trees, as well as in -mm.  Of course the resulting dependencies between those
trees are a pain to Stephen and their maintainers.

After the last Kernel Summit we tried to create a branch in the ACPI tree for
suspend/hibernation patches (thanks Len!) and that had worked quite well until
we started to work on the core device power management.  This coincided with
the creation of linux-next and collecting suspend/hibernation patches in the
ACPI tree became inconvenient.

Now, we could go back to the old way of handling suspend/hibernation patches,
which was to merge them through -mm, but the disadvantage of this would be that
the patches wouldn't go through linux-next.  However, I'd like
suspend/hibernation patches to be included in linux-next, so that they can get
as much testing as possible.

For this reason I'd like to create a quilt-based series of suspend/hibernation
(PM sleep) patches, that Stephen will be able to pull from, with the following
rules:
* the patch series will be based on linux-next and will be rebased as often
  as necessary
* the patch series will be periodically (most probably once a week) posted
  to linux-pm and linux-acpi; additionally the maintainers of the subsystems
  affected by the patches will be sent CCs of the messages with them, so that
  they can pick those patches up
* patches taken into the other subsystem trees will be dropped from the
  patchset and the resulting dependencies will be reflected by the annotations
  in the 'series' file
* the patches that are still in the series when the merge window opens, but
  are accepted by the appropriate maintainers, will be put into a git branch
  and pushed to Linus towards the end of the merge window.

If you agree to this plan, I'd like to start by creating the patch series out
of the suspend/hibernation patches that are in -mm at the moment and one
additional patch that was accepted by Len, but not added to the ACPI tree
because of some dependencies with the other subsystem trees.

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
