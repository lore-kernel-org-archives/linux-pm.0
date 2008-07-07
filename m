From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/8] PCI PM: Handling of PCI devices wake-up
	functionality (rev. 4)
Date: Mon, 7 Jul 2008 03:30:01 +0200
Message-ID: <200807070330.02849.rjw__12691.6450601586$1215394820$gmane$org@sisk.pl>
References: <200807012356.26669.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807012356.26669.rjw@sisk.pl>
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
Cc: Zhao Yakui <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Jesse,
 
This is a new (4th) iteration of the series of patches intended to rework the power
management of PCI devices so that the handling of their wake-up functionality
is consistent with the other PM operations and so that the user space can
manage the wake-up functionality of PCI devices using the
/sys/devices/.../power/wakeup interface regardless of whether the wake-up
function is based on the native PCI mechanism (PME#), or it is handled by the
platform (eg. ACPI).
 
Apart from the ACPI and PCI changes necessary for this purpose, the series
includes some clean-ups that are not strictly required, but make the code more
straightforward and (IMHO) easier to follow.

The patchset is on top of the linux-next branch of the PCI tree and is regarded
as 2.6.27 material.

Thanks,
Rafael
