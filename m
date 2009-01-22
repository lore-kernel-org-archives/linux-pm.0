From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] PCI PM: Corrections of recent changes
Date: Thu, 22 Jan 2009 23:35:06 +0100
Message-ID: <200901222335.07341.rjw__19744.795424822$1232664211$gmane$org@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-pm@vger.kernel.org

Hi,

The three patches below are corrections of the recent changes in the PCI PM
code.  They apply on top of the "PCI PM: Restore standard config registers of
all devices early" patch (commit aa8c6c93747f7b55fa11e1624fec8ca33763a805 in
your for-linus branch).

The first patch fixes hibernation breakage on eeepc 701 reported by Alan
Jenkins.  The breakage is probably related to a hardware or BIOS problem, but
the patch just gets us back to the previous behaviour.

The remaining two patches deal with two theoretical issues with the PCI PM code
after commit aa8c6c93747f7b55fa11e1624fec8ca33763a805.  I don't really think
they have practical relevance, but keeping the code theoretically correct is
also important.

Please consider for applying.

Thanks,
Rafael
