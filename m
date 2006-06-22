From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 17:48:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606211737260.5498@g5.osdl.org>
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
	<1150930302.16303.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150930302.16303.17.camel@localhost.localdomain>
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



On Thu, 22 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> As long as you don't go anywhere near persistant storage like
> filesystems... Might be worth having a global ro remount as part of
> preparing subsystems....

Right, now you're thinking at the _high_ level. =


For swap, we actually have this nice notion of a per-swap "SWAP_WRITEOK" =

bit, which we use during swapoff (we clear the WRITEOK bit to say that =

such a device is still available for swapping _in_ from, but not _out_ =

to).

So clearing that bit basically says that the device is "active", in the =

sense that it's a legal swap-device, and anything you swapped out to it =

can still be read in, but nothing can be written to it any more. That's =

exactly the kind of thing that makes sense to clear during the "freeze" =

phase (and it would actually magically make the VM do exactly the right =

thing wrt swap in the "zombie" state afterwards).

We don't actually have anything like that for filesystems. Mountign things =

read-only comes closest, but doing a read-only mount will currently fail =

if we have inodes open for writing (which we will have), so unlike the =

swap situation, we'd actually have to implement that "global read-only" =

thing as a whole new state.

But it shouldn't be that hard. At worst, we'd just have to kill things at =

the writeout level (we might want to still read stuff _in_, so we dont' =

actually want to kill the queues at the block device level, we'd be much =

better off doing it at a VM/FS level).

> > > The only little possible issue there is that the subsystems being sti=
ll
> > > stopped, some drivers may need to have a hard time doing 5 if they ne=
ed
> > > to send requests to their own hardware for things like hard disk
> > > spindown, and they happen to use the block layer request queue for th=
at
> > > (pumping device specific requests into it).
> > =

> > I'd wake up all kernel daemons after snapshotting. There's no reason no=
t =

> > to, really (kswapd might be a special case, but quite frankly, I think =

> > we're better off "turning off swap" than necessarily turning off kswapd =

> > itself - ie again, the appropriate level to make sure swap doesn't get =

> > dirtied afterwards is likely _higher_ up than the level that actually =

> > makes the IO itself happen).
> =

> Beware with things like knfsd trying to hit your filesystems too ...

Yes. I suspect that if we do it right, it would be caught by the same =

read-only checks at the VM/FS layer, but knfsd is one of the things that =

we might very well want to just kill when freezing, or at least not =

wake from any freeze activity.

		Linus
