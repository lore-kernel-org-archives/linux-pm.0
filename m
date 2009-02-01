From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] PCI PM: More refinements of suspend-resume
	framework
Date: Sun, 1 Feb 2009 22:29:26 +0100
Message-ID: <200902012229.27517.rjw__21924.8871588663$1233524597$gmane$org@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

After the recent discussion with Linus, I have the following three fixes of the
PCI PM framework.

The first patch fixes the bug that bridges (and PCIe ports) are disabled
during suspend, althouth they shouldn't.

The second one makes the PCI PM core handle devices more carefully (details
in the changelog). [Note to Linus: devices are still put into low power states
with interrupts on after this patch.  Moving that to the late suspend phase
will be the next step.]

The last patch makes the warning in pci_legacy_suspend() more useful.

Thanks,
Rafael
