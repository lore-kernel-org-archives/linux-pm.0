From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
	all devices early (was: Re: EeePC resume failure - timers)
Date: Fri, 16 Jan 2009 21:48:40 +0100
Message-ID: <200901162148.42357.rjw__27483.9622820311$1232139206$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<200901161727.05026.rjw@sisk.pl>
	<alpine.LFD.2.00.0901160834380.29252@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0901160834380.29252@localhost.localdomain>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 16 January 2009, Linus Torvalds wrote:
> 
> On Fri, 16 Jan 2009, Rafael J. Wysocki wrote:
> > 
> > So, does it mean the patch looks reasonable? ;-)
> 
> I haven't tested it myself, and I probably won't have time to before I 
> leave for LCA, but it looks reasonable. I'd suggest replacing this:
> 
> +               if (pci_dev->current_state != PCI_D0) {
> +                       /*
> +                        * Warn users if the driver puts the device into a low
> +                        * power state, but doesn't bother to save its config
> +                        * registers.
> +                        */
> +                       WARN_ON(true);
> +                       goto Fixup;
> 
> with the much simpler
> 
> 	if (WARN_ON_ONCE(pci_dev->current_state != PCI_D0))
> 		goto Fixup;
> 
> instead, because we don't want to get millions of warnings, and it's kind 
> of silly to have WARN_ON(true) inside a conditional code-sequence.

I'll do that, thanks.

Somehow, I didn't realize that WARN_ON_ONCE() returned !!(its argument).

Rafael
