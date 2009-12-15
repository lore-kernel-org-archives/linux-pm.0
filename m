From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Tue, 15 Dec 2009 12:03:22 +0100
Message-ID: <200912151203.22916.rjw__684.09782038561$1260875024$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912150018.11837.rjw@sisk.pl>
	<alpine.LFD.2.00.0912141609020.14385@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912141609020.14385@localhost.localdomain>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 15 December 2009, Linus Torvalds wrote:
> 
> On Tue, 15 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > Because the PCI bridges are not the only case where it matters (I'd say they
> > are really a corner case).  Basically, any two async devices separeted by a
> > series of sync ones are likely not to be suspended (or resumed) in parallel
> > with each other, because the parent is usually next to its children in dpm_list.
> 
> Give a real example that matters.

I'll try.  Let -> denote child-parent relationships and assume dpm_list looks
like this:

..., A->B->C, D, E->F->G, ...

where A, B, E, F are all async and C, D, G are sync (E, F, G may be USB and
A, B, C may be serio input devices and D is a device that just happens to be in
dpm_list between them).  Say A and C take the majority of the total suspend
time and assume we traverse the dpm_list from left to right.

Now, during suspend, C waits for B that waits for A and G waits for F that
waits for E.  Moreover, since C is sync, the PM core won't start the suspend
of D until the suspend of C has returned.  In turn, since D is sync, the
suspend of E won't be started until the suspend of D has returned.  So in
this situation the gain from the async suspends of A, B, E, F is zero.

However, it won't be zero if we start the async suspends of A, B, E, F
upfront.

I'm not sure if this is sufficiently "real life" for you, but this is how
dpm_list looks on one of my test boxes, more or less.

> Really. 
> 
> How hard can it be to understand: KISS. Keep It Simple, Stupid.
> 
> I get really tired of this whole stupid async discussion, because you're 
> overdesigning it.
> 
> To a first approximation, THE ONLY THING THAT MATTERS IS USB.

If this applies to _resume_ only, then I agree, but the Arjan's data clearly
show that serio devices take much more time to suspend than USB.

But if we only talk about resume, the PCI bridges don't really matter,
because they are resumed before all devices that depend on them, so they don't
really need to wait for anyone anyway.

Rafael
