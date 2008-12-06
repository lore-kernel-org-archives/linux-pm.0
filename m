From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] Fix hibernation regression on Toshiba
	Portege R500
Date: Sat, 6 Dec 2008 15:05:33 +0100
Message-ID: <200812061505.33815.rjw__46676.731730304$1228572800$gmane$org@sisk.pl>
References: <200812020320.31876.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812020320.31876.rjw@sisk.pl>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following three patches address the hibernation/suspend issue described in
http://bugzilla.kernel.org/show_bug.cgi?id=12121 and in the very long thread at
http://lkml.org/lkml/2008/12/1/382.

In short, the problem is that resume (from hibernation and/or suspend-to-RAM)
occasionally fails (approximately 20-25% of attempts) in the middle of resuming
PCI devices.  We were able to find a specific layout of devices within the
memory address space in which the failure appeared to be extremely unlikely,
but this layout was no really valid for other reasons.  We also found out that
using the NMI watchdog decreased the probablitily of failure which indicated
that the problem could be timing-related.

Next, we started to look at the PCI resume code and we generally agreed that
it would be a good idea to restore the standard PCI configuration registers
with interrupts disabled.  Also, we thought we could move the saving of those
registers for some devices into functions executed with interrupts disabled.

I have followed these observations and created the three following patches.
With all of these patches applied, I'm not able to reproduce the problem.

Thanks,
Rafael
