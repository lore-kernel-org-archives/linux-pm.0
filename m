From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 23 Jun 2006 19:32:44 -0400
Message-ID: <20060623233244.GB4264@neo.rr.com>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
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

On Fri, Jun 23, 2006 at 12:23:53PM -0700, Linus Torvalds wrote:
> =

> =

> On Fri, 23 Jun 2006, David Brownell wrote:
> > =

> > Seriously, suspend() tends to be less of a problem than resume().  Which
> > is why I'm lukewarm to notions of refactoring suspend().
> =

> Now, I obviously agree, I just don't see any good way to refactor resume =

> at all.
> =

> So I think we should attack the problems that we _can_ attack.
> =

> Btw, I disagree violently with the standpoint that you and Pavel have had =

> that we currently just do enough in "suspend()" to make STR work, and tha=
t =

> gets STD working automatically.
> =

> Several suspend() functions I've seen (networking in particular) do a =

> _hell_ of a lot more than they need for STR, exactly because they try to =

> protect against problems that happen with STD, but _not_ STR.
> =

> Network devices tend to do things like "unregister from the network stack=
" =

> etc, all of which should be totally unnecessary for STR. It's all there =

> really for _disk_ suspend, to make things quiet.
> =

> So the whole argument that "suspend()" is the minimal functionality is =

> just totally bogus. Its' simply not _true_. The current suspend() =

> functions do lots of things that have nothing to do with actual device =

> suspend, exactly because the current setup forces them to do so, not =

> because they would actually _need_ to do so for STR.
> =

> 			Linus

As far as I understand, most of them call netif_device_detach(), which just
set's a flag bit that indicates the hardware isn't available for a moment,
but this isn't the same as unregistering from the netdev stack.

In my opinion, the point here is that the suspend functions are trying to
prevent access to hardware.  In the suspend-to-ram case the device might be
uninitialized or powered off.  As a result touching the hardware may lead to
driver errors, master aborts, lost data, or other problems.  Similarly, the
goal during suspend-to-disk memory snapshotting is just to quiet down the
drivers by stopping DMA, interrupts, and other hardware access so it's easi=
er
to create a functional memory snapshot, even if it isn't entirely atomic.

In either case, it's important to a.) tell the driver to stop touching it's
hardware for a moment, b.) make sure the hardware itself is quiet enough and
c.) optionally push out any queues or buffers of data waiting to hit the
device.  Of course, there are also a lot of activities that are not shared
between each suspend scenario.  For example, when suspending devices before
entering S3 (or whatever the platform calls suspend-to-ram) it's important,
in addition to the above, to save dynamic device context, enter the correct
device power state, and enable wakeup capabilities if needed.  In contrast,
when preparing for a memory snapshot, it's important to save dynamic device
context but device power must be maintained.  As a third example, before
entering S5 it might be best to transition devices to lower power states
and enable wakeup features, but there is no need to save dynamic context.

Now I'm not arguing that the current suspend model is correct, in fact I th=
ink
it's in need of some major restructuring.  Nor am I arguing that this all m=
ust
happen in a single unified suspend callback.  I just want to suggest that in
any suspend case, one of the most important objectives is to quiesce the
driver and hardware.  As a result, every type of suspend() operation has at
least some similar requirements.

Thanks,
Adam
