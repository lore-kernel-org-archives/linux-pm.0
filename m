From: Adrian Bunk <bunk@stusta.de>
Subject: Re: Linux 2.6.21-rc6
Date: Sat, 14 Apr 2007 15:00:45 +0200
Message-ID: <20070414130045.GE3691@stusta.de>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<20070413212954.GA2545@melchior.yamamaya.is-a-geek.org>
	<20070413235017.GR5907@stusta.de>
	<20070414120900.GA3001@melchior.yamamaya.is-a-geek.org>
	<20070414122447.GA2827@melchior.yamamaya.is-a-geek.org>
	<20070414123154.GA2863@melchior.yamamaya.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070414123154.GA2863@melchior.yamamaya.is-a-geek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz, linux-pm@lists.osdl.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 14, 2007 at 02:31:54PM +0200, Tobias Diedrich wrote:
> Tobias Diedrich wrote:
> > > ed746e3b18f4df18afa3763155972c5835f284c5 is first bad commit
> > > commit ed746e3b18f4df18afa3763155972c5835f284c5
> > > Author: Rafael J. Wysocki <rjw@sisk.pl>
> > > Date:   Sat Feb 10 01:43:32 2007 -0800
> > > =

> > >     [PATCH] swsusp: Change code ordering in disk.c
> > >     =

> > >     Change the ordering of code in kernel/power/disk.c so that device=
_suspend() is
> > >     called before disable_nonboot_cpus() and platform_finish() is cal=
led after
> > >     enable_nonboot_cpus() and before device_resume(), as indicated by=
 the recent
> > >     discussion on Linux-PM (cf.
> > >     http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.htm=
l).
> > >     =

> > >     The changes here only affect the built-in swsusp.
> > >     =

> > >     [alexey.y.starikovskiy@linux.intel.com: fix LED blinking during i=
mage load]
> > >     Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > >     Acked-by: Pavel Machek <pavel@ucw.cz>
> > >     Cc: Greg KH <greg@kroah.com>
> > >     Cc: Nigel Cunningham <nigel@suspend2.net>
> > >     Cc: Patrick Mochel <mochel@digitalimplant.org>
> > >     Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > =

> > > :040000 040000 7eca5b3a8f9606bc4f2ff41192ec8c9d4ca90d18 8313b674e1d1b=
df6849350af06d28a89b3bb3054 M      kernel
> > > =

> > > =

> > > Now, the remaining test is to try reverting this commit from -rc6. :)
> > =

> > Doesn't apply cleanly against -rc6, but fixes the problem when
> > reverted from -rc1.
> =

> Now, this was already reported in
> http://lkml.org/lkml/2007/3/16/126
> and I even flagged that message in my local folder, but apparently forgot
> to follow up on it... *sigh*

Unless I misunderstood something, all of the problems Maxim described in =

this email are fixed for him in -rc6.

But it's quite possible that you are running into a different issue =

exposed by this commit.

> Tobias

cu
Adrian

-- =


       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
