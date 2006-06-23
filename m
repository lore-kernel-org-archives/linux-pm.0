From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 02:01:48 +0200
Message-ID: <20060623000148.GC4940@elf.ucw.cz>
References: <1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
	<1151014893.4046.24.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
	<1151017911.4046.55.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
	<1151019097.4046.69.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221636210.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606221636210.6483@g5.osdl.org>
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

> > > So you say. Have you actually ever done anything to make debugging ea=
sier?
> > =

> > I've implemented suspend/resume for a whole range of machiens where
> > everything goes down and all I have to debug on resume is ... sending
> > commands to a chip to blink a LED. So yes, I have.
> =

> That's not what I asked.
> =

> I didn't ask whether you had debugged suspend/resume.
> =

> I asked whether you had tried to make it easier.
> =

> > None of the problems I've had were ever related to something that would =

> > be in save_state.
> =

> Ok, I've had very different things happen.
> =

> Here's a _fact_:
> =

>  - we currently walk the device chain to suspend different devices
>  - one device returns an error
>  - we've now suspended half the machine, done major things, and we need t=
o =

>    undo it
>  - the thing fails.

You are right, suspend error handling sucks...

> Are you seriously claiming this has never happened to you? It sure has =

> happened to me.
> =

> And YES, THIS WOULD BE IMPROVED BY MY SCHEME. Instead of getting a
> machine =


...unfortunately your proposal makes non-errors paths to suck, too.

Now, if we really wanted to do something about this... we could just
resume the console, then print a message and panic(). If our error
handling never ever works, this at least has chance to show that
message.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
