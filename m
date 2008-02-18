From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch] suspend/resume self-test
Date: Mon, 18 Feb 2008 12:16:24 -0800
Message-ID: <200802181216.25350.david-b__4116.77236338637$1203365984$gmane$org@pacbell.net>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200802180240.47510.david-b@pacbell.net>
	<20080218130914.GC17697@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080218130914.GC17697@elte.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 18 February 2008, Ingo Molnar wrote:
> =

> * David Brownell <david-b@pacbell.net> wrote:
> =

> > > > =A0 - Includes a command line parameter, which needs work yet ... it
> > > > =A0 =A0 currently turns this test off, but it should also let the t=
arget
> > > > =A0 =A0 state be specified (and maybe even default to "no test").
> > =

> > I think "no test" should be the default; STR working sanely on x86 is =

> > unfortunately too much a surprise.  Someone more active in PM testing =

> > should update that.
> =

> All i'm asking for is to make the self-test easily accessible. Not for =

> it to blow up in the face of users who do not ask for it.

I'm all for that, but also I don't want to see it blow up regularly
in the face of people who just enable all the selftest options.  The
other tests have a much better expectation of working "by default".


> And, at least to me, there seems to be a rather apparent correlation =

> between "suspend/resume regressions caught as early as possible" and the =

> future, desired state of: "STR working sanely on x86" ;-)

Thing is, this will catch not just regressions ... but cases where
STR never worked in the first place.  Video problems, etc.  Also
various system startup races, as in the PCMCIA and MMC/SD/SDIO
cases I noted.
 =


> You really seem to treat S2R suckiness as a fact of life, but it isnt.

Until it starts working on a given platform, it *IS* a fact of life.

Once it works, then it's fair to enter "no regressions" mode.  Despite
all the recent improvements, I think it's unwise to pretend that STR
works properly on most systems.


> Yes, it's a hard field for a number of reasons, but we could be doing _a =

> lot_ better. One of them would be this "notice s2r breakage when i =

> create or add the patch that breaks it" angle.

Right, and the best way to ensure that it's only *regressions* that
break things is to expect someone to have configured the kernel command
line appropriately (in grub or whatever).

Another way to achieve that is to include the test code based on one
config option, and change the test *mode* based on another one.  That
way a distro could include that in standard kernels with "no test" mode
as the default, but it would be easy to enable only for oneshot tests
or field troubleshooting ... while developers could turn on the more
dangerous "always test STR" (or standby, or hibernate) mode, if they
were helping to find and fix problems surfaced by such tests.

- Dave
