From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 08:51:41 +1000
Message-ID: <1150930302.16303.17.camel@localhost.localdomain>
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
	<Pine.LNX.4.64.0606202109410.5498@g5.osdl.org>
	<1150865132.12507.131.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606210754080.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606210754080.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, 2006-06-21 at 08:08 -0700, Linus Torvalds wrote:

> > 4-driver thaw, subsystems stay frozen (that is VM, filesystems,
> > userland)
> =

> Yes and no. We might actually want to thaw some subsystems too. =

> =

> Obviously, there's no reason to thaw user programs (even if you could =

> wake them up, they couldn't be allowed to make any forward progress that =

> is "visible"), but once you have snapshotted things, you might actually b=
e =

> better off allowing a fair amount of "normal" operations.

As long as you don't go anywhere near persistant storage like
filesystems... Might be worth having a global ro remount as part of
preparing subsystems....

> For example, you might decide that you want to actually _kill_ all user =

> processes at that point, and allow kernel processes that you wanted =

> quiescent for snapshotting to thaw. Once you have built the snapshot =

> image, many of the reasons to freeze are gone - not just for drivers.

Ok.

> At that point, the only thing you want to make sure of is that nobody =

> writes to swap any more, and doesn't write to the filesystem (or network, =

> for that matter).
> =

> > 5-shutdown or driver suspend S4
> =

> Not yet. =

> =

>  5 - write snapshot to disk
> =

> Because ytou need to do that after the thaw, of course.

Yes, sure, that one was so obvious that I forgot about it :)

> And only _then_ do you actually shutdown or do S4.

Yup.

> > The only little possible issue there is that the subsystems being still
> > stopped, some drivers may need to have a hard time doing 5 if they need
> > to send requests to their own hardware for things like hard disk
> > spindown, and they happen to use the block layer request queue for that
> > (pumping device specific requests into it).
> =

> I'd wake up all kernel daemons after snapshotting. There's no reason not =

> to, really (kswapd might be a special case, but quite frankly, I think =

> we're better off "turning off swap" than necessarily turning off kswapd =

> itself - ie again, the appropriate level to make sure swap doesn't get =

> dirtied afterwards is likely _higher_ up than the level that actually =

> makes the IO itself happen).

Beware with things like knfsd trying to hit your filesystems too ...

Ben.
 =
