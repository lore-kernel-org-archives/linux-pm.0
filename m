From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 20 Jun 2006 17:49:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606201744220.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
	<1150843494.1901.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150843494.1901.42.camel@localhost.localdomain>
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



On Wed, 21 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> But they will :) If you look at IDE, actually spinning down the platter
> or not is a very simple decision in the suspend process (which is a
> state machine). About 95% of the code in there is absolutely identical
> between the freeze and the suspend case. It's only a "detail" that when
> doing suspend we actually go hit the disk with a spindown request.

Nope.

You could actually make the disk driver do nothing AT ALL for the freeze =

case.

I really don't understand how anybody even half-way sane can say that =

"freeze" and "suspend" is 95% the same thing for IDE. There is exactly =

_zero_ in common.

If the drive queue is quiescent (which isn't even a driver issue), a IDE =

controller won't touch memory _anyway_. So "freeze" for the IDE driver is =

100% a total no-op, apart from perhaps disabling interrupts, "just =

because". =


Unlike network devices and USB, an IDE controller doesn't do anything on =

its own anyway. =


So where do you find that "95% the same" logic? =


Let's recap: for "freeze"/"unfreeze", there is absolutely zero to do. The =

disk controller won't be doing any IO on its own anyway.

For "suspend"/"resume", you need to put the controller in a sleep state =

(which, in the case of IDE, means turning it off into D3cold - there is =

absolutely no reason to even keep it powered), and on resume you need to =

do a lot of work to wait for the disks etc to actuall come back and =

re-connect to the disks.

Where's the "95% shared?"

I tell you where it is: it's in the current _IDIOTIC_ design, which thinks =

that the two are the same issue, when they have absolutely _zero_ in =

common.

			Linus
