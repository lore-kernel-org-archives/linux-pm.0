From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] suspend/resume self-test
Date: Mon, 18 Feb 2008 12:04:36 +0100
Message-ID: <200802181204.37666.rjw__21400.1612192535$1203332899$gmane$org@sisk.pl>
References: <20080130131748.GA3796@elf.ucw.cz>
	<20080218095325.GA7198@elf.ucw.cz>
	<200802180240.47510.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802180240.47510.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, 18 of February 2008, David Brownell wrote:
> > > =A0 - Includes a command line parameter, which needs work yet ... it
> > > =A0 =A0 currently turns this test off, but it should also let the tar=
get
> > > =A0 =A0 state be specified (and maybe even default to "no test").
> =

> I think "no test" should be the default;

Agreed.

> STR working sanely on x86 is unfortunately too much a surprise.

Well, out of 4 boxes I have, one doesn't resume from suspend, but this is t=
he
one that's terminally broken otherwise. :-)

> Someone more active in PM testing should update that.
> =

> =

> > > Also includes some Kconfig tweaks to help reduce configuration bugs on
> > > x86, by avoiding the legacy RTC driver when the generic RTC framework
> > > is enabled ... those should become a separate patch.
> =

> That's already been split out in a separate patch, now in MM.
> Though it may deserve another tweak, forcing off *all* legacy
> RTC drivers if the new framework is enabled.

Yes, the legacy drivers shoule depend on !(new framework).

Thanks,
Rafael
