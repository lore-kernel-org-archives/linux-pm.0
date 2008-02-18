From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] suspend/resume self-test
Date: Mon, 18 Feb 2008 14:09:14 +0100
Message-ID: <20080218130914.GC17697__14661.7319704548$1203340376$gmane$org@elte.hu>
References: <20080130131748.GA3796@elf.ucw.cz> <20080218094650.GA31970@elte.hu>
	<20080218095325.GA7198@elf.ucw.cz>
	<200802180240.47510.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802180240.47510.david-b@pacbell.net>
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
Cc: linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


* David Brownell <david-b@pacbell.net> wrote:

> > > =A0 - Includes a command line parameter, which needs work yet ... it
> > > =A0 =A0 currently turns this test off, but it should also let the tar=
get
> > > =A0 =A0 state be specified (and maybe even default to "no test").
> =

> I think "no test" should be the default; STR working sanely on x86 is =

> unfortunately too much a surprise.  Someone more active in PM testing =

> should update that.

All i'm asking for is to make the self-test easily accessible. Not for =

it to blow up in the face of users who do not ask for it.

And, at least to me, there seems to be a rather apparent correlation =

between "suspend/resume regressions caught as early as possible" and the =

future, desired state of: "STR working sanely on x86" ;-)

You really seem to treat S2R suckiness as a fact of life, but it isnt. =

Yes, it's a hard field for a number of reasons, but we could be doing _a =

lot_ better. One of them would be this "notice s2r breakage when i =

create or add the patch that breaks it" angle.

        Ingo
