From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
	Software Suspend, aka swsusp):
Date: Tue, 14 Aug 2007 19:37:05 +0200
Message-ID: <200708141937.06676.rjw@sisk.pl>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com>
	<200708132338.25925.rjw@sisk.pl> <20070814070528.GA2903@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070814070528.GA2903@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>, Joe Perches <joe@perches.com>
Cc: linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 14 August 2007 09:05, Pavel Machek wrote:
> Hi!
>=20
> > > > + include/linux/suspend.h
> > > > + include/linux/freezer.h
> > > > + include/linux/pm.h
> > > > + include/asm-*/suspend.h
> > > >=20
> > > > Hm, they are also relevant for suspend to RAM, so perhaps one com=
mon
> > > > list of files for suspend to RAM and hibernation would be better?
> > >=20
> > > Maybe just collapse the 2 maintainers blocks into one?
>=20
> No, please don't.

So, I think the F: entries should be the following:

(1) hibernation
F:=A0=A0=A0=A0=A0=A0Documentation/power/
F:=A0=A0=A0=A0=A0=A0arch/i386/power/
F:=A0=A0=A0=A0=A0=A0arch/x86_64/kernel/suspend_asm.S
F:=A0=A0=A0=A0=A0=A0arch/x86_64/kernel/suspend.c
F:=A0=A0=A0=A0=A0=A0drivers/base/power/
F:=A0=A0=A0=A0=A0=A0kernel/power/
F:=A0=A0=A0=A0=A0=A0include/linux/suspend.h
F:=A0=A0=A0=A0=A0=A0include/linux/freezer.h
F:=A0=A0=A0=A0=A0=A0include/linux/pm.h
F:=A0=A0=A0=A0=A0=A0include/asm-*/suspend.h

(2) suspend
F:=A0=A0=A0=A0=A0=A0Documentation/power/
F:=A0=A0=A0=A0=A0=A0arch/i386/kernel/acpi/
F:=A0=A0=A0=A0=A0=A0arch/x86_64/kernel/acpi/
F:=A0=A0=A0=A0=A0=A0arch/x86_64/kernel/suspend.c
F:=A0=A0=A0=A0=A0=A0drivers/base/power/
F:=A0=A0=A0=A0=A0=A0kernel/power/
F:=A0=A0=A0=A0=A0=A0include/linux/suspend.h
F:=A0=A0=A0=A0=A0=A0include/linux/freezer.h
F:=A0=A0=A0=A0=A0=A0include/linux/pm.h
F:=A0=A0=A0=A0=A0=A0include/asm-*/suspend.h

> > > HIBERNATION (aka Software Suspend, aka swsusp) and SUSPEND TO RAM:
> > > P:	Pavel Machek
> > > M:	pavel@suse.cz
> > > P:	Rafael J. Wysocki
> > > M:	rjw@sisk.pl
> > > L:	linux-pm@lists.linux-foundation.org
> > > S:	Supported
> >=20
> > Then I think it should be "Maintained".
>=20
> No, supported is still right :-).

OK

Greetings,
Rafael
