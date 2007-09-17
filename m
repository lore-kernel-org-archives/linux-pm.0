From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: [3/3] 2.6.23-rc6: known regressions v2
Date: Mon, 17 Sep 2007 22:51:06 +0200
Message-ID: <200709172251.07769.arekm__15756.6280955963$1190062421$gmane$org@maven.pl>
References: <46EB3EF8.6040103@googlemail.com>
	<200709172144.43761.arekm@maven.pl>
	<1190058463.2995.14.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1190058463.2995.14.camel@chaos>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Thomas Voegtle <tv@lio96.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 17 of September 2007, Thomas Gleixner wrote:
> On Mon, 2007-09-17 at 21:44 +0200, Arkadiusz Miskiewicz wrote:
> > On Saturday 15 of September 2007, Rafael J. Wysocki wrote:
> > > On Saturday, 15 September 2007 04:29, Michal Piotrowski wrote:
> > > > Subject         : resume from ram much slower
> > > > References      : http://lkml.org/lkml/2007/8/10/275
> > > > Last known good : 2.6.23-rc1 ?
> > > > Submitter       : Arkadiusz Miskiewicz <arekm@maven.pl>
> > > > Caused-By       : ?
> > > > Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
> > > > Status          : problem is being debugged
> > >
> > > Unresolved, bisection might be helpful.
> >
> > Took 16 hours of bisecting and playing with stuff.
> >
> > It looks like the problematic patch is
> > 18de5bc4c1f1f1fa5e14f354a7603bd6e9d4e3b6. bisection was hard and I'm =
95%
> > sure that this is the problematic patch. I'm currently using 2.6.23-r=
c6
> > with this reverted and so far resume works as it should.
> >
> >
> > commit 18de5bc4c1f1f1fa5e14f354a7603bd6e9d4e3b6
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Sat Jul 21 04:37:34 2007 -0700
> >
> >     clockevents: fix resume logic
>
> Linus pulled a series of patches which are addressing this issue into
> his tree yesterday. Can you please retest against current git ?

Looks like the problem is fixed in current git for me. Thanks!

ps. The description about vaio not resuming without key pressing matches =
what=20
I was seeing here on thinkpad z60m, too.

> 	tglx



--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
