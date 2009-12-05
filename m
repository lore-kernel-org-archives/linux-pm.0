From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 00:55:36 +0100
Message-ID: <200912060055.36130.rjw__6726.11761042408$1260057377$gmane$org@sisk.pl>
References: <200912052216.19540.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051334461.3649@localhost.localdomain>
	<alpine.LFD.2.00.0912051349000.3649@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912051349000.3649@localhost.localdomain>
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

On Saturday 05 December 2009, Linus Torvalds wrote:
> 
> On Sat, 5 Dec 2009, Linus Torvalds wrote:
> > 
> > In other words - I'm not pulling this crazy thing. You'd better explain 
> > why it was done that way, when we already have done the same things better 
> > before in different ways.

OK, I'll send another pull request without these patches if the rest of the
changes if fine with you (they are more important than the async stuff to me).

> I get the feeling that all the crazy infrastructure was due to worrying 
> about the suspend/resume topology.

Yes, that's the main reason.

> But the reason we don't worry about that during init is that it doesn't 
> really tend to matter. Most slow operations are the things that aren't 
> topology-aware, ie things like spinning up/down disks etc, that really 
> could be done as a separate phase instead.

It was based on the observation that in many cases the current drivers' suspend
and resume callbacks can be run in parallel with the other drivers' callbacks
without any changes to the drivers (and without introducing another phase of
suspend for that matter), because there are no dependencies between them.

The approach you're suggesting would require modifying individual drivers which
I just wanted to avoid.  If you don't like that, we'll have to take the longer
route, although I'm afraid that will take lots of time and we won't be able to
exploit the entire possible parallelism this way.

> For example, is there really any reason why resume doesn't look exactly 
> like the init sequence? Drivers that do slow things can start async work 
> to do them, and then at the end of the resume sequence we just do a "wait 
> for all the async work", exactly like we do for the current init 
> sequences.

During suspend we actually know what the dependences between the devicces
are and we can use that information to do more things in parallel.  For
instance, in the majority of cases (I'm yet to find a counter example), the
entire suspend callbacks of "leaf" PCI devices may be run in parallel with each
other.

So, the point is not to look for "async stuff" in a driver's suspend/resume
callbacks, but to execute the whole suspend/resume callbacks in parallel,
if possible.

> And yes, for the suspend sequence we obviously need to do any async work 
> (and wait for it) before we actually shut down the controllers, but that 
> would be _way_ more natural to do by just introducing a "pre-suspend" hook 
> that walks the device tree and does any async stuff. And then just wait 
> for the async stuff to finish before doing the suspend, and perhaps again 
> before doing late_suspend (maybe somebody wants to do async stuff at the 
> second stage too).
>
> Then, because we need a way to undo things if things go wrong in the 
> middle (and because it's also nice to be symmetric), we'd probably want to 
> introduce that kind of "post_resume()" callback that allows you have a 
> separate async wakeup thing for resume time too.

Yes, we can do that, but I'm afraid that the majority of drivers won't use the
new hooks (people generally seem to be to reluctant to modify their
suspend/resume callbacks not to break things).

Also, for an individual driver it really is difficult to separate the "async
stuff" from the stuff which is not async, because everything that can be done
in parallel with the other drivers' suspend callbacks is potentially async, as
long as there are no dependences between the devices in question (like
parent-child dependences, or PCI-shadow ACPI dependences).  And it's
generally worth doing that if a driver's suspend or resume callback calls
msleep() for whatever the reason.
 
> What are actually the expensive/slow things during suspend/resume? Am I 
> wrong when I say it's things like disk spinup/spindown (and USB discovery, 
> which needs USB-level support anyway, since it can involve devices that we 
> didn't even know about before discovery started).

Disk spinup/spindown takes time, but also some ACPI devices resume slowly,
serio devices do that too and there are surprisingly many drivers that wait
(using msleep() during suspend and resume).  Apart from this, every PCI device
going from D0 to D3 during suspend and from D3 to D0 during resume requires
us to sleep for 10 ms (the sleeping is done by the PCI core, so the drivers
don't even realize its there).

Thanks,
Rafael
