From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 22:36:41 -0700
Message-ID: <200606212236.41734.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606211921.16289.david-b@pacbell.net>
	<1150946591.947.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150946591.947.56.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 June 2006 8:23 pm, Benjamin Herrenschmidt wrote:
> On Wed, 2006-06-21 at 19:21 -0700, David Brownell wrote:
> > On Wednesday 21 June 2006 5:15 pm, Benjamin Herrenschmidt wrote:
> > >		Additionally, as I explained earlier, it
> > > will make everybody's life MUCH easier (especially USB) if we define
> > > that between prepare() and finish(), no hotplug activity takes place
> > > (the bus drivers just basically ignore devices being plugged in during
> > > that phase, or if they can't completely ignore them, at least just le=
ave
> > > a bit somewhere "need to come back on resume look what's going on
> > > here").
> > =

> > In the USB case, you're basically saying that prepare() should freeze
> > khubd.  I think you've implied elsewhere that not all kernel tasks
> > should be frozen at that time, though.
> =

> Yes, but I'm saying that it will just make life easier to everybody if
> we define that we don't get new devices in while we are in the
> suspend/resume process. Don't you agree ?

It certainly gets rid of various deadlocks we've observed.

For example, the appropriate action on a "power was lost" resume is
often to delete some devices ... which means self-deadlocking in the
PM core.  Our workaround for that has been to punt the work to khubd,
which gets unfrozen later (after devices are resumed), marking the
devices as disconnected so that the pointless "resume dead device"
logic will be fail-fast.

- Dave
