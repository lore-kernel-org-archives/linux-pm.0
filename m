From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [3/3] 2.6.23-rc2: known regressions v2
Date: Mon, 13 Aug 2007 15:21:54 +0200
Message-ID: <6bffcb0e0708130621s74411866mc07446854fb96cd4@mail.gmail.com>
References: <46B9F664.9060600@googlemail.com> <200708102206.58438.rjw@sisk.pl>
	<Pine.SOC.4.64.0708111349520.725@math.ut.ee>
	<200708112342.01989.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708112342.01989.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sam Ravnborg <sam@ravnborg.org>, Meelis Roos <mroos@linux.ee>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 11/08/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday, 11 August 2007 12:53, Meelis Roos wrote:
> > > > > 3. Can you please check if this patch changes anything:
> > > > > http://marc.info/?l=linux-mm-commits&m=118669680811669&w=2
> > > >
> > > > Tried it on current git, kernel/power/Kconfig gave 2 rejects.
> > > > Tried on 2.6.23-rc2, still 2 rejects from the same file, .rej below:
> > >
> > > Sorry, but:
> > >
> > > rafael@albercik:~/src/linux-2.6> git-pull git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> > > Already up-to-date.
> > > rafael@albercik:~/src/linux-2.6> cat ~/pm-fix-dependencies-of-config_suspend-and-config_hibernation-updated-3x.patch | patch -p1
> > > patching file arch/x86_64/defconfig
> > > patching file include/linux/cpu.h
> > > patching file kernel/cpu.c
> > > patching file kernel/power/Kconfig
> > >
> > > How come?
> >
> > Hmm, must have been mangled on the web (downloaded via wget so should be
> > byte-by-byte exact). I now downloaded it from akpm-s broken-out tarball
> > and this one applied fine.
> >
> > The patch changes the warning to a different warning, it's now
> > kernel/power/Kconfig:79:warning: 'select' used by config symbol 'PM_SLEEP_SMP' refers to undefined symbol 'HOTPLUG_CPU'
> >
> > The warning also appears when running just "make ARCH=ppc" after
> > "make ARCH=ppc oldconfig".
>
> Yes, I have reproduced it now.
>
> Well, it's clearly a false positive, since none of the options PM_SLEEP_SMP
> depends on is set in your .config.  Also, it seems to be ppc-specific (for
> example, if I change the architecture to powerpc, the warning doesn't show up).
>
> The only problem I see here is that the warning in fact should not be printed,
> but I don't know how to make the build system stop printing it.

I removed this from KR list. Sam, is it possible to remove this warning?

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
