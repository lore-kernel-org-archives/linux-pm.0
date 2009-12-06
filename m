From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sat, 5 Dec 2009 16:52:05 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912051648520.3560__42003.0851303183$1260060876$gmane$org@localhost.localdomain>
References: <200912052216.19540.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051334461.3649@localhost.localdomain>
	<200912060129.19245.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912060129.19245.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 6 Dec 2009, Rafael J. Wysocki wrote:
> 
> > It all looks terminally broken: you force async suspend for all PCI 
> > drivers, even when it makes no sense.
> 
> I'm not exactly sure what you're referring to.  The async suspend is not
> forced, it just tells the PM core that it can execute PCI suspend/resume
> callbacks in parallel as long as the devices in question don't depend on each
> other.

That's exactly what I mean by forcing async suspend/resume.

You don't know the ordering rules for PCi devices. Multi-function PCI 
devices commonly share registers - they're on the same chip, after all. 
And even when the _hardware_ is totally independent, we often have 
discovery rules and want to initialize in order because different drivers 
will do things like unregister entirely on suspend, and then re-register 
on resume.

Imagine the mess when two ethernet devices randomly end up coming up with 
different names (eth0/eth1) depending on subtle timing issues.

THAT is why we do things in order. Asynchronous programming is _hard_. 
Just deciding that "all PCI devices can always be resumed and suspended 
asynchronously" is a much MUCH bigger decision than you seem to have 
even realized.

		Linus
