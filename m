From: Meelis Roos <mroos@linux.ee>
Subject: Re: [3/3] 2.6.23-rc2: known regressions v2
Date: Fri, 10 Aug 2007 22:03:38 +0300 (EEST)
Message-ID: <Pine.SOC.4.64.0708102202400.13577__33298.0328276337$1186772704$gmane$org@math.ut.ee>
References: <46B9F664.9060600@googlemail.com> <46B9F983.9020700@googlemail.com>
	<200708082210.25836.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708082210.25836.rjw@sisk.pl>
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
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > Power management
> > 
> > Subject         : Kconfig: 'SUSPEND_SMP' refers to undefined symbol 'HOTPLUG_CPU'
> > References      : http://lkml.org/lkml/2007/8/4/39
> > Last known good : ?
> > Submitter       : Meelis Roos <mroos@linux.ee>
> > Caused-By       : ?
> > Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
> > Status          : unknown
> 
> I can't reproduce this with my cross compilation toolchain for PPC.

Still present with todays git and make oldconfig, on native powerpc with 
Debian unstable.

-- 
Meelis Roos (mroos@linux.ee)
