From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 11:33:30 +1000
Message-ID: <1150940010.947.6.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<1150852207.12507.30.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201933510.5498@g5.osdl.org>
	<200606211418.16236.david-b@pacbell.net>
	<1150938496.16303.107.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211823290.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606211823290.5498@g5.osdl.org>
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

On Wed, 2006-06-21 at 18:24 -0700, Linus Torvalds wrote:
> =

> On Thu, 22 Jun 2006, Benjamin Herrenschmidt wrote:
> > =

> > Linus, You are contradicting yourself a bit I think... On one mailed,
> > you agreed that suspend() would happen in a "live" systems with no
> > quiescing of subsystems and now you say drivers shouldn't bother
> =

> Right.
> =

> SUSPEND.
> =

> Not SNAPSHOT.
> =

> The real STR shouldn't actually need to quiesce anything.
> =

> But STD isn't suspend. And it damn well needs to quiesce things.
> =

> As long as you think of STD as suspend, you're never going to get =

> _anywhere_. It's not. It has never been. And it never will be.

Ok, ok... just read my other mail then and pls answer to my objection
about save_state() vs. suspend() :) That is, my worry about the state
actually changing between those 2 calls and restoring the wrong one,
essentially, what is the precise definition of "state".

Ben.
