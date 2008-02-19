From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] suspend/resume self-test
Date: Tue, 19 Feb 2008 11:11:16 +0100
Message-ID: <20080219101116.GA2202@elf.ucw.cz>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200802180240.47510.david-b@pacbell.net>
	<20080218130914.GC17697@elte.hu>
	<200802181216.25350.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802181216.25350.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 2008-02-18 12:16:24, David Brownell wrote:
> On Monday 18 February 2008, Ingo Molnar wrote:
> > =

> > * David Brownell <david-b@pacbell.net> wrote:
> > =

> > > > > =A0 - Includes a command line parameter, which needs work yet ...=
 it
> > > > > =A0 =A0 currently turns this test off, but it should also let the=
 target
> > > > > =A0 =A0 state be specified (and maybe even default to "no test").
> > > =

> > > I think "no test" should be the default; STR working sanely on x86 is =

> > > unfortunately too much a surprise.  Someone more active in PM testing =

> > > should update that.
> > =

> > All i'm asking for is to make the self-test easily accessible. Not for =

> > it to blow up in the face of users who do not ask for it.
> =

> I'm all for that, but also I don't want to see it blow up regularly
> in the face of people who just enable all the selftest options.  The
> other tests have a much better expectation of working "by default".

> > And, at least to me, there seems to be a rather apparent correlation =

> > between "suspend/resume regressions caught as early as possible" and th=
e =

> > future, desired state of: "STR working sanely on x86" ;-)
> =

> Thing is, this will catch not just regressions ... but cases where
> STR never worked in the first place.  Video problems, etc.  Also
> various system startup races, as in the PCMCIA and MMC/SD/SDIO
> cases I noted.

David is right here. At minimum, s2ram needs acpi_sleep=3D... options to
tell it how to set up the video. That is not issue for you, but it
means we should not be doing it by default.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
