From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 01:31:37 +0200
Message-ID: <20060622233137.GE4462@elf.ucw.cz>
References: <1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
	<1151014893.4046.24.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
	<1151017911.4046.55.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
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

> > The main reason is the video problem (chips not coming back on resume
> > and needing a POST). This has always been the main issue and that's what
> > is causing STR not to work for a lot of people.
> =

> No.
> =

> Not for me. Every single time something doesn't work for me, I just plug =

> it into the network and try to debug it over the net.

Well, apparently you were the first one to try to use netconsole for
s2ram debugging. Sorry -- we were using regular vgacon.

> > The model does and I think your model would 1- break all existing
> > drivers that got it right since they have to be changed
> =

> Actually, it won't break a single driver for STR.
> =

> Why? Because if you do it the old way, STR will still happen to work. I'm =

> just giving you a separate phase.

Separate phase, that Ben demonstrated is totally useless. How is that
supposed to help?

> So you say. Have you actually ever done anything to make debugging easier?
> =

> Nope. In the years I've been frustrated with suspend, nobody has ever don=
e =

> anything to this. And now I have to push through changes, just because =

> people think that "status quo" is acceptable.

It actually works on a lot of machines. Maybe we are pushing way too
much work to drivers... but that should be solved by providing
subsystem-specific helpers, not by changing the design.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
