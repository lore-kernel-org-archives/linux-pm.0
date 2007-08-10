From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [3/3] 2.6.23-rc2: known regressions v2
Date: Fri, 10 Aug 2007 21:24:00 +0200
Message-ID: <200708102124.01218.rjw__11708.671358838$1186773297$gmane$org@sisk.pl>
References: <46B9F664.9060600@googlemail.com> <200708082210.25836.rjw@sisk.pl>
	<Pine.SOC.4.64.0708102202400.13577@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.SOC.4.64.0708102202400.13577@math.ut.ee>
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
To: Meelis Roos <mroos@linux.ee>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 10 August 2007 21:03, Meelis Roos wrote:
> > > Power management
> > > 
> > > Subject         : Kconfig: 'SUSPEND_SMP' refers to undefined symbol 'HOTPLUG_CPU'
> > > References      : http://lkml.org/lkml/2007/8/4/39
> > > Last known good : ?
> > > Submitter       : Meelis Roos <mroos@linux.ee>
> > > Caused-By       : ?
> > > Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
> > > Status          : unknown
> > 
> > I can't reproduce this with my cross compilation toolchain for PPC.
> 
> Still present with todays git and make oldconfig, on native powerpc with 
> Debian unstable.

1. Is that with the same .config you sent me previously?

2. What exactly is the consequence of this warning?

3. Can you please check if this patch changes anything:
http://marc.info/?l=linux-mm-commits&m=118669680811669&w=2

Greetings,
Rafael
