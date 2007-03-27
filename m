From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [4/5] 2.6.21-rc5: known regressions
Date: Wed, 28 Mar 2007 00:29:19 +0200
Message-ID: <20070327222919.GI16477@stusta.de>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
	<20070327015949.GB16477@stusta.de> <200703271209.14447.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703271209.14447.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Meyer <thomas@m3y3r.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 27, 2007 at 12:09:13PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, 27 March 2007 03:59, Adrian Bunk wrote:
> > This email lists some known regressions in Linus' tree compared to 2.6.=
20.
> > =

> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you caused a breakage or I'm considering you in any other way
> > possibly involved with one or more of these issues.
> > =

> > Due to the huge amount of recipients, please trim the Cc when answering.
> =

> I think the following two:
>  =

> > Subject    : suspend to disk: keypress required for power down
> > References : http://lkml.org/lkml/2007/3/25/78
> > Submitter  : Thomas Meyer <thomas@m3y3r.de>
> > Status     : unknown
>  =

> > Subject    : suspend to disk: non-boot cpus are disabled again
> > References : http://lkml.org/lkml/2007/3/25/78
> > Submitter  : Thomas Meyer <thomas@m3y3r.de>
> > Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
> >              Eric W. Biederman <ebiederm@xmission.com>
> > Status     : problem is being debugged
> =

> are related to the same issue.
> =

> The problem is that we call disable_nonboot_cpus() in swsusp before
> powering down the system in order to avoid triggering the WARN_ON()
> in arch/x86_64/kernel/acpi/sleep.c:init_low_mapping() and this doesn't
> work well on Thomas' system.
> =

> Since the problem has been introduced by commit
> 94985134b7b46848267ed6b734320db01c974e72
> (swsusp: disable nonboot CPUs before entering platform suspend), I think =
it's
> better to revert this commit and remove the the WARN_ON() in
> arch/x86_64/kernel/acpi/sleep.c:init_low_mapping() (appended is a patch t=
hat
> removes the WARN_ON()).

It's now in Linus' tree.

Thomas (Meyer), are there any regressions left with the latest -git tree =

plus the MSI fix?

> Greetings,
> Rafael
>...

cu
Adrian

-- =


       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
