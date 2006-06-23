From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sat, 24 Jun 2006 09:53:38 +1000
Message-ID: <1151106818.16946.19.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
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


> Several suspend() functions I've seen (networking in particular) do a =

> _hell_ of a lot more than they need for STR, exactly because they try to =

> protect against problems that happen with STD, but _not_ STR.
> =

> Network devices tend to do things like "unregister from the network stack=
" =

> etc, all of which should be totally unnecessary for STR. It's all there =

> really for _disk_ suspend, to make things quiet.

How so ? Are you talking about netif_device_detach ? There should never
be need to unregister completel from the network stack for either STR or
STD, but netif_device_detach() is needed for STR (and won't harm for
STD) for making sure your xmit() isn't called on a sleeping hardware
(and to sync with it). There may be _differnet_ ways of doing it but
netif_device_detach() works fine and doesn't seem to cause any problem
(and avoids the network stack bmbing you with tx timeouts unlike what
happens if you just use netif_stop_queue() from memory..)

I've very rarely seen drivers trying to do _anything_ to work around STD
specific issues. I think Pavel and David are right there... suspend() is
mostly written for STR and that way happens to work with STD...

> So the whole argument that "suspend()" is the minimal functionality is =

> just totally bogus. Its' simply not _true_. The current suspend() =

> functions do lots of things that have nothing to do with actual device =

> suspend, exactly because the current setup forces them to do so, not =

> because they would actually _need_ to do so for STR.

What are you talking about now ? Precisely that is ? The current
suspend() mostly do things to make sure we don't hit the hardware when
it's suspended. That's it. In some cases it's a one liner due to the
subsystem we attach to being nice and providing us with a single call
that just does it, in some cases it's more complicated because we don't
have that (but could add such helpers) or because we may be hit directly
by things like ioctl path and need to guard them.

It's all STR issues.

Ben.
