From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/1] Fix resume breakage of USB PCI controllers
	behind cardbus bridges
Date: Fri, 13 Feb 2009 23:40:14 +0100
Message-ID: <200902132340.15427.rjw__35083.4511955783$1234565289$gmane$org@sisk.pl>
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
To: Greg KH <gregkh@suse.de>
Cc: Miles Lane <miles.lane@gmail.com>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

[Sorry for resending, I forgot to send CCs to the mailing lists.]

Hi,

Unfortunately, we broke the resume of USB PCI controllers behind cardbus
bridges by moving the restoration of their standard config registers to
usb_hcd_pci_resume_early().  Namely, if USB PCI controller is behind a cardbus
bridge, we're restoring its config registers too early, before the bridge
becomes operational.

IMO in the future it's better to move the resume of cardbus bridges to the
early resume phase (ie. before device interrupts will be enabled), but for
2.6.29 I think we should just go back to the 2.6.28 behavior, which is to
call pci_restore_state() from usb_hcd_pci_resume().  The following patch
does this.

Thanks,
Rafael
