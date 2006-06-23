From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 12:23:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606231106.46863.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



On Fri, 23 Jun 2006, David Brownell wrote:
> =

> Seriously, suspend() tends to be less of a problem than resume().  Which
> is why I'm lukewarm to notions of refactoring suspend().

Now, I obviously agree, I just don't see any good way to refactor resume =

at all.

So I think we should attack the problems that we _can_ attack.

Btw, I disagree violently with the standpoint that you and Pavel have had =

that we currently just do enough in "suspend()" to make STR work, and that =

gets STD working automatically.

Several suspend() functions I've seen (networking in particular) do a =

_hell_ of a lot more than they need for STR, exactly because they try to =

protect against problems that happen with STD, but _not_ STR.

Network devices tend to do things like "unregister from the network stack" =

etc, all of which should be totally unnecessary for STR. It's all there =

really for _disk_ suspend, to make things quiet.

So the whole argument that "suspend()" is the minimal functionality is =

just totally bogus. Its' simply not _true_. The current suspend() =

functions do lots of things that have nothing to do with actual device =

suspend, exactly because the current setup forces them to do so, not =

because they would actually _need_ to do so for STR.

			Linus
