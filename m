From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 09:22:39 -0700
Message-ID: <200606150922.40074.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<200606151600.30410.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606151600.30410.ncunningham@linuxmail.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday 14 June 2006 11:00 pm, Nigel Cunningham wrote:
> Hi.
> =

> On Thursday 15 June 2006 11:46, David Brownell wrote:
> > On Wednesday 14 June 2006 4:57 pm, Pavel Machek wrote:
> > > My point is that you really want the console enabled in writing phase
> > > of suspend-to-disk.
> >
> > Notice how nicely this generalizes a point that's been made before:
> > Linux should have the ability to exclude certain devices (and their
> > parents) from that first "prepare to suspend" phase.  Originally the
> > canonical example was the swap device (and its disk, controller, bus
> > tree, etc).  Now we recognize consoles (and their parents, network
> > controllers, etc) have the same issue ...
> =

> Wouldn't it be simpler to say "We send the prepare_to_suspend/freeze/susp=
end =

> messages to all devices, but some have the nous to know to ignore them"?

That's one potential solution, and one I thought about.
But it has the conceptual problem that the PM framework
code would be (wrongly) thinking the device is suspended;
so it couldn't handle the parent/child relationships
properly.  (The parents of that still-"active" device would
wrongly be allowed to suspend...)


The approach of having a driver suspend() method understand
things about the target system state is IMO just fine.  In
fact the original parameter of suspend() identified that
system state ... but certainly pm_message_t does not.

You may not have understood the point of the clk_must_disable()
API I posted a while back, but what it's doing is exporting
some essential information about that target state ... stuff
that drivers need to know in order to support multiple system
sleep (or run!) states.  Certainly there's other data beyond
clocking that could matter.

- Dave
