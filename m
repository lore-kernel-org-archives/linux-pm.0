From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch] suspend/resume self-test
Date: Mon, 18 Feb 2008 02:40:46 -0800
Message-ID: <200802180240.47510.david-b__25823.1352469467$1203331414$gmane$org@pacbell.net>
References: <20080130131748.GA3796@elf.ucw.cz> <20080218094650.GA31970@elte.hu>
	<20080218095325.GA7198@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080218095325.GA7198@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@elte.hu>
Cc: linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> > =A0 - Includes a command line parameter, which needs work yet ... it
> > =A0 =A0 currently turns this test off, but it should also let the target
> > =A0 =A0 state be specified (and maybe even default to "no test").

I think "no test" should be the default; STR working sanely on
x86 is unfortunately too much a surprise.  Someone more active
in PM testing should update that.


> > Also includes some Kconfig tweaks to help reduce configuration bugs on
> > x86, by avoiding the legacy RTC driver when the generic RTC framework
> > is enabled ... those should become a separate patch.

That's already been split out in a separate patch, now in MM.
Though it may deserve another tweak, forcing off *all* legacy
RTC drivers if the new framework is enabled.
