From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 18:05:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606241802460.6483@g5.osdl.org>
References: <1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221641180.6483@g5.osdl.org>
	<20060622235100.GA4940@elf.ucw.cz>
	<200606231115.21265.david-b@pacbell.net>
	<20060624213522.GE2777@elf.ucw.cz>
	<Pine.LNX.4.64.0606241454030.6483@g5.osdl.org>
	<1151197051.4547.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151197051.4547.5.camel@localhost.localdomain>
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



On Sun, 25 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> > I think requiring X to reinitialize the screen for us is perfectly fine.
> =

> When X can :) Wether we need X or some other userland based emulator,

Right. X usually can, but regardless, if you end up doing something like a =

vm86 mode post through userland emulation, it's still better done in =

_user_ land than in the kernel.

> Out of curiosity, do you get the video back at all on the mini ? Or will
> we have at some point to get code to do a full re-initialization of the
> intel video chip ?

We already do. The current i810 driver tree does it all (in the =

"modesetting" branch). =


So on the Mac Mini, I can have full X with all the bells and whistles, and =

no BIOS calls used anywhere.

			Linus
