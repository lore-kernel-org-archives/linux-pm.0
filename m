From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 20 Jun 2006 19:40:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606201933510.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
	<1150843494.1901.42.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201744220.5498@g5.osdl.org>
	<1150852207.12507.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150852207.12507.30.camel@localhost.localdomain>
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

> But the driver queue isn't quiescent !

AND WHAT THE HELL DOES THAT HAVE TO DO WITH THE DRIVER?

It's not up to the driver to worry about request queues. If you guys think =

it is, you have your heads so solidly up your nether regions that it's not =

even funny.

Dammit, stop trying to make that a driver issue. It isn't. Drivers should =

not have to worry about things like that, because it's not actually the =

driver that even _does_ any of the request queue stuff. That's _all_ at a =

much higher level, and trying to push it down to a driver writer is not =

just stupid, it's so incredibly broken and idiotic that it's not even =

funny.

If you want to take a snapshot of memory, you do NOT ask the drivers to =

just make everything quiet. You start from the upper layers, make things =

quiet there, and _than_ you ask the driver to also shut up.

But the fact is, IDE drivers don't even have to be told to shut up. If =

there are no requests coming in from above, then they will be quiet on =

their own. So, pretty much by definition, a freeze/unfreeze event for an =

IDE driver had better be pretty much a no-op, or you have serious serious =

problems anyway.

Trying to claim anything else is beyond stupid.

And yes, I realize that the suspend/resume code has done some damn stupid =

things. That's not an excuse for then making things _worse_ by not even =

admitting that they are idiotic and bad.

			Linus
