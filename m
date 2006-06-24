From: Jim Gettys <jg@laptop.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sat, 24 Jun 2006 07:57:39 -0400
Message-ID: <1151150259.15365.316.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
Reply-To: jg@laptop.org
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

We're building the OLPC machine in which the wireless hardware is alive
(and able to forward packets in the mesh) even with the machine STR.
Even our ATest hardware supports this for wireless.

Similarly for the screen; it can be "alive" while the machine is STR.
The power savings are dramatic. the screen takes an ASIC we don't have
back yet, so that we won't have until the next batch of boards.  And
with the Geode's UMA, all we should have to do on the console is save
and restore the graphics registers, which should be very fast.

The Wireless chip can wake the processor if it detects a packet bound
for that machine, rather than just being forwarded.  As far as other
machines are concerned, the destination machine can be considered
"alive" and not STR.
                         Regards,
                            - Jim


On Fri, 2006-06-23 at 12:23 -0700, Linus Torvalds wrote:

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
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
-- =

Jim Gettys
One Laptop Per Child
