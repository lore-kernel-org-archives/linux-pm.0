From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 02:24:37 +0100
Message-ID: <200912060224.37752.rjw__44492.3056559221$1260062724$gmane$org@sisk.pl>
References: <200912052216.19540.rjw@sisk.pl> <200912060129.19245.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051648520.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912051648520.3560@localhost.localdomain>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 06 December 2009, Linus Torvalds wrote:
> 
> On Sun, 6 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > > It all looks terminally broken: you force async suspend for all PCI 
> > > drivers, even when it makes no sense.
> > 
> > I'm not exactly sure what you're referring to.  The async suspend is not
> > forced, it just tells the PM core that it can execute PCI suspend/resume
> > callbacks in parallel as long as the devices in question don't depend on each
> > other.
> 
> That's exactly what I mean by forcing async suspend/resume.
> 
> You don't know the ordering rules for PCi devices.

That's true at the moment, but in principle we can abstract all dependences
between devices as PM links that will enforce specific suspend/resume ordering
between them.

> Multi-function PCI devices commonly share registers - they're on the same
> chip, after all.  And even when the _hardware_ is totally independent, we
> often have discovery rules and want to initialize in order because different
> drivers  will do things like unregister entirely on suspend, and then
> re-register on resume.

Do any of the PCI drivers do that?

> Imagine the mess when two ethernet devices randomly end up coming up with 
> different names (eth0/eth1) depending on subtle timing issues.
> 
> THAT is why we do things in order. Asynchronous programming is _hard_. 
> Just deciding that "all PCI devices can always be resumed and suspended 
> asynchronously" is a much MUCH bigger decision than you seem to have 
> even realized.

I have considered that, but at the end of the day I haven't seen a single
problem with that showing up in testing during the last two or three months.

Given the time the patchset spent in linux-next I'd expect someone to report
a problem with it - if there's a problem.  But no one has said a word, so I'm
not that worried, although I'm still a bit cautious.

That's why there is the switch for disabling the feature altogether.  It is
enabled by default, which perhaps is not the right setting, but I don't really
see the reason why not to turn it on where it doesn't break things (like on
all of my test boxes at the moment).

Still, as I said before, the other changes in my pull request are more
important to me than the async patchset, so please let me know if they are fine
with you.

Thanks,
Rafael
