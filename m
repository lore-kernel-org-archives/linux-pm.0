From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 20 Jun 2006 21:22:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606202109410.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
	<1150843494.1901.42.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201744220.5498@g5.osdl.org>
	<1150852207.12507.30.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201933510.5498@g5.osdl.org>
	<1150858653.12507.69.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606202008290.5498@g5.osdl.org>
	<1150862396.12507.103.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150862396.12507.103.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Wed, 21 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> But there are very good reasons why the suspend process is driven by the
> drivers in the first place, for big bold dependencies on parent busses
> based on the above model. And in that picture, it's actually very easy
> and works pretty well to have a given driver, when asked to suspend, to
> then call it's own "customers" to tell them to shut up (example; a
> network driver calling netif_stop_queue() before suspending).

I absolutely agree that on a _suspend_ level, it makes sense to do it =

device-model-centric.

But I think the basic disconnect here is that I simply do not believe that =

the "image save" has _anything_ to do with "suspend".

Let's cut right to the chase:
 - I think "image save" is snapshotting
 - I think snapshotting is well-defined (and possibly useful) without any =

   suspend activity what-so-ever.
 - I think that anybody who confuses and mixes the two is (a) missing the =

   real potential of snapshotting, but even more importantly (b) making it =

   much more complex by having the wrong mental model.

Mental models are supremely important. Often you can say that they don't =

actually matter, because the end result should be the same, but the fact =

is, they have a huge impact on _how_ people think, and on how you get to =

the end result. =


The fact is, suspend has nothing to do with the "save to disk" part. I =

think the whole Linux kernel suspend code has been _destroyed_ by the STD =

code. Exactly because the STD people have thought that the save-to-disk =

part was somehow part of "suspend", when it has _nothing_ to do with it =

other than a very incidental connection.

The sad part is that STR (aka "real suspend") has been made much more =

complex because allt he things THAT HAVE NOTHING TO DO WITH SUSPENDING A =

DEVICE have been pushed into the STR path.

Think about the "snapshotting" idea for a while. =


I claim, that the only _sane_ way to do STD is to create a snapshot, and =

resume that snapshot. But notice how "suspendign" isn't part of that =

picture AT ALL. Really. =


It's a perfectly valid operation to create a snapshot AND CONTINUE =

RUNNING! You can create a million snapshots, and only later decide that =

you want to resume one of them after you've rebooted much later.

The current code mixes the two operations up. I've said so from the =

beginning. The current code seems to think that "suspend" should have =

something to do with creating a snapshot, AND THE CURRENT CODE IS WRONG!

Dammit, I'm right about this.

(And btw, I've done device snapshotting that works like the above, and =

taking snapshots every 5 minutes or so. It's damn useful - you can go =

backwards in time when something goes wrong, and re-examine what went =

wrong. Admittedly, that was done with simulator software - and hardware - =

but the point is, snapshotting and continuing to run isn't even all that =

strange, and it sure as hell isn't an invalid operation).

As long as you continue to confuse "suspend to disk" with "real suspend", =

you're not going to see the point. Just FORGET about the fact that STD is =

called "suspend". It has nothing to do with reality. STD has no suspend in =

it what-so-ever.

In STD, you shut the damn machine off, there's not a whiff of real power =

management anywhere, and device power management is totally unnecessary =

and useless for it.

			Linus
