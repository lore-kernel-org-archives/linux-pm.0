From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Mon, 26 Jun 2006 01:09:49 +0200
Message-ID: <20060625230949.GB2519@elf.ucw.cz>
References: <1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221641180.6483@g5.osdl.org>
	<20060622235100.GA4940@elf.ucw.cz>
	<200606231115.21265.david-b@pacbell.net>
	<20060624213522.GE2777@elf.ucw.cz>
	<Pine.LNX.4.64.0606241454030.6483@g5.osdl.org>
	<1151197051.4547.5.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606241802460.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606241802460.6483@g5.osdl.org>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > I think requiring X to reinitialize the screen for us is perfectly fi=
ne.
> > =

> > When X can :) Wether we need X or some other userland based emulator,
> =

> Right. X usually can, but regardless, if you end up doing something like =
a =

> vm86 mode post through userland emulation, it's still better done in =

> _user_ land than in the kernel.

I admit that X can do the job for some people, but I'd somehow prefer
to have option of s2ram on console, tool. vbetool allows to do that,
and that's why it is integrated into s2ram program... along with
whitelist which tells it what method to use on what machine. We do not
yet have _any_ method that works everywhere :-(.

								Pavel
-- =

suspend.sf.net
