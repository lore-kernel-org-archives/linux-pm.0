From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sat, 5 Dec 2009 16:48:00 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912051635330.3560__35771.153556607$1260060622$gmane$org@localhost.localdomain>
References: <200912052216.19540.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051334461.3649@localhost.localdomain>
	<alpine.LFD.2.00.0912051349000.3649@localhost.localdomain>
	<200912060055.36130.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912060055.36130.rjw@sisk.pl>
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
> The approach you're suggesting would require modifying individual drivers which
> I just wanted to avoid.

In the init path, we had the reverse worry - not wanting to make 
everything (where "everything" can be some subsystem like just the set of 
PCI drivers, of course - not really "everything" in an absolute sense) 
async, and then having to try to work out with the random driver that 
couldn't handle it.

And there were _lots_ of drivers that couldn't handle it, because they 
knew they got woken up serially. The ATA layer needed to know about 
asynchronous things, because sometimes those independent devices aren't so 
independent at all. Which is why I don't think your approach is safe.

Just to take an example of the whole "independent devices are not 
necessarily independent" thing - things like multi-port PCMCIA controllers 
generally show up as multiple PCI devices. But they are _not_ independent, 
and they actually share some registers. Resuming them asynchronously might 
well be ok, but maybe it's not. Who knows?

In contrast, a device driver can generally know that certain _parts_ of 
the initialization is safe. As an example of that, I think the libata 
layer does all the port enumeration synchronously, but then once the ports 
have been identified, it does the rest async. 

That's the kind of decision we can sanely make when we do the async part 
as a "drivers may choose to do certain parts asynchronously". Doing it at 
a higher level sounds like a problem to me.

> If you don't like that, we'll have to take the longer route, although 
> I'm afraid that will take lots of time and we won't be able to exploit 
> the entire possible parallelism this way.

Sure. But I'd rather do the safe thing. Especially since there are likely 
just a few cases that really take a long time.

> During suspend we actually know what the dependences between the devicces
> are and we can use that information to do more things in parallel.  For
> instance, in the majority of cases (I'm yet to find a counter example), the
> entire suspend callbacks of "leaf" PCI devices may be run in parallel with each
> other.

See above. That's simply not at all guaranteed to be true. 

And when it isn't true (ie different PCI leaf devices end up having subtle 
dependencies), now you need to start doing hacky things. 

I'd much rather have the individual drivers say "I can do this part in 
parallel", and not force it on them. Because it is definitely _not_ 
guaranteed that PCI devices can do parallel resume and suspend.

> Yes, we can do that, but I'm afraid that the majority of drivers won't use the
> new hooks (people generally seem to be to reluctant to modify their
> suspend/resume callbacks not to break things).

See above - I don't think this is a "majority" issue. I think it's a 
"let's figure out the problem spots, and fix _those_". IOW, get 2% of the 
coverage, and get 95% of the advantage.

> Disk spinup/spindown takes time, but also some ACPI devices resume slowly,

We actually saw that when we did async init. And it was horrible. There's 
nothing that says that the ACPI stuff necessarily even _can_ run in 
parallel. 

I think we currently only do the ACPI battery ops asynchronously.

				Linus
