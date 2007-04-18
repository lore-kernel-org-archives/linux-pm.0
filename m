From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][RFC] Kill off legacy power management stuff.
Date: Wed, 18 Apr 2007 22:10:36 +0200
Message-ID: <20070418201036.GA2112@elf.ucw.cz>
References: <Pine.LNX.4.64.0704122025380.3628@CPE00045a9c397f-CM001225dbafb6>
	<200704131022.45315.rjw@sisk.pl> <46254666.2020308@tmr.com>
	<Pine.LNX.4.64.0704172045100.18821@localhost.localdomain>
	<46265F60.4040600@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46265F60.4040600@tmr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, "Robert P. J. Day" <rpjday@mindspring.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >>One reason was that there are (were?) a number of machines which only =

> >>powered
> >>down properly using apm. It was discussed as part of shutting down afte=
r =

> >>power
> >>failure when your UPS is running out of power.
> >>    =

> >
> >um ... what does APM have to do with legacy PM?  two different issues,
> >no?
> >  =

> Since the patches are going into apm.c and apm was used for suspend and =

> poweroff before ACPI was a feature of the hardware, I assume there's a =

> relationship. As of 2.6.9 ACPI still couldn't power down one of my
>old

There is not. The patches should not affect you unless you use obscure
68000 driver.

We are removing infrastructure that has no users.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
