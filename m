From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
 all devices early (was: Re: EeePC resume failure - timers)
Date: Fri, 16 Jan 2009 11:40:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901161138320.2417-100000__45469.7424931966$1232124293$gmane$org@iolanthe.rowland.org>
References: <200901161727.05026.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901161727.05026.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: john stultz <johnstul@us.ibm.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 16 Jan 2009, Rafael J. Wysocki wrote:

> IMO suspend-resume is quite difficult to implement in a PCI driver unless
> the driver writer knows very well how PCI PM is supposed to work and interact
> with things like interrupts control, ACPI etc.

I agree.  There's plenty of boilerplate PCI stuff in the USB
suspend/resume routines which really belongs in the PCI core.  When we
switch over to the new framework (perhaps as soon as 2.6.30) the driver
code will be a lot simpler.

Alan Stern
