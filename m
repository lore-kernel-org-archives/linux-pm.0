From: Tobias Diedrich <ranma@tdiedrich.de>
Subject: Re: Linux 2.6.21-rc6
Date: Sat, 14 Apr 2007 21:56:11 +0200
Message-ID: <20070414195611.GC806@yamamaya.is-a-geek.org>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<20070414123154.GA2863@melchior.yamamaya.is-a-geek.org>
	<20070414130045.GE3691@stusta.de> <200704142028.04694.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704142028.04694.rjw@sisk.pl>
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
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Saturday, 14 April 2007 15:00, Adrian Bunk wrote:
> > On Sat, Apr 14, 2007 at 02:31:54PM +0200, Tobias Diedrich wrote:
> > > Tobias Diedrich wrote:
> > > > > ed746e3b18f4df18afa3763155972c5835f284c5 is first bad commit
> > > > > commit ed746e3b18f4df18afa3763155972c5835f284c5
> > > > > Author: Rafael J. Wysocki <rjw@sisk.pl>
> > > > > Date:   Sat Feb 10 01:43:32 2007 -0800
> > > > > =

> > > > >     [PATCH] swsusp: Change code ordering in disk.c
> > > > >     =

> > > > >     Change the ordering of code in kernel/power/disk.c so that de=
vice_suspend() is
> > > > >     called before disable_nonboot_cpus() and platform_finish() is=
 called after
> > > > >     enable_nonboot_cpus() and before device_resume(), as indicate=
d by the recent
> > > > >     discussion on Linux-PM (cf.
> > > > >     http://lists.osdl.org/pipermail/linux-pm/2006-November/004164=
.html).
> > > > >     =

> > > > >     The changes here only affect the built-in swsusp.
> > > > >     =

> > > > >     [alexey.y.starikovskiy@linux.intel.com: fix LED blinking duri=
ng image load]
> > > > >     Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > > >     Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > >     Cc: Greg KH <greg@kroah.com>
> > > > >     Cc: Nigel Cunningham <nigel@suspend2.net>
> > > > >     Cc: Patrick Mochel <mochel@digitalimplant.org>
> > > > >     Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.co=
m>
> > > > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > > >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > =

> > > > > :040000 040000 7eca5b3a8f9606bc4f2ff41192ec8c9d4ca90d18 8313b674e=
1d1bdf6849350af06d28a89b3bb3054 M      kernel
> > > > > =

> > > > > =

> > > > > Now, the remaining test is to try reverting this commit from -rc6=
. :)
> > > > =

> > > > Doesn't apply cleanly against -rc6, but fixes the problem when
> > > > reverted from -rc1.
> > > =

> > > Now, this was already reported in
> > > http://lkml.org/lkml/2007/3/16/126
> > > and I even flagged that message in my local folder, but apparently fo=
rgot
> > > to follow up on it... *sigh*
> > =

> > Unless I misunderstood something, all of the problems Maxim described i=
n =

> > this email are fixed for him in -rc6.
> > =

> > But it's quite possible that you are running into a different issue =

> > exposed by this commit.
> =

> Yes, it's likely.
> =

> Tobias, I'm unable to reproduce the problem with your .config, but my har=
dware
> is certainly different.  Which suspend mode do you use?  If that's "platf=
orm",
> can you try to use "shutdown" or "reboot" and see if that helps?

Sure.
shutdown/reboot works fine, only platform is broken.

-- =

Tobias						PGP: http://9ac7e0bc.uguu.de
