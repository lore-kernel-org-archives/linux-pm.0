From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: RFC: additional event for pm_notifier
Date: Wed, 31 Mar 2010 13:39:51 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1003311333270.2244@localhost>
References: <alpine.LFD.2.00.1003171945130.2469@localhost>
	<201003182119.24070.rjw@sisk.pl>
	<alpine.LFD.2.00.1003262024310.2476@localhost>
	<201003262231.27156.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003262231.27156.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org



On Fri, 26 Mar 2010, Rafael J. Wysocki wrote:

> On Friday 26 March 2010, Sebastian Ott wrote:
> >
> > hi,
> > 
> > i've got that working, but after some more thinking
> > i really didn't like that approach - in short, if we do that,
> > hibernation on s390 will allways be bound to the plattform mode
> > (with certain devices we will crash in our restore callbacks
> > if we haven't previously enabled the hw-feature, which those
> > devices use)
> > 
> > and to the your-gun-your-foot argument - if someone tests
> > hibernation on s390 using the reboot mode he sure cannot
> > expect the potential panic, depending on the involved devices
> 
> Well, on x86 using ACPI the reboot and shutdown modes only work by fortunate
> conincidence, so to speak (if at all).
> 
> That said, your argument is reasonable.
> 
> > do you absolutely oppose against the idea of a new notifier event?
> 
> Yes, I do.  To the extent that I'd rather change the entire design so that the
> "hibernation modes" would be platform-dependent.

ok. i implemented a hook in arch/s390

thanks
sebastian
