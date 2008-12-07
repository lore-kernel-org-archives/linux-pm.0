From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 2/3] PCI: Suspend and resume PCI Express
	ports with interrupts disabled
Date: Sat, 6 Dec 2008 18:18:54 -0800
Message-ID: <200812061818.55115.jbarnes__48833.6612158038$1228616606$gmane$org@virtuousgeek.org>
References: <200812020320.31876.rjw@sisk.pl>
	<alpine.LFD.2.00.0812060933430.3425@nehalem.linux-foundation.org>
	<200812061846.12167.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812061846.12167.rjw@sisk.pl>
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
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, December 6, 2008 9:46 am Rafael J. Wysocki wrote:
> On Saturday, 6 of December 2008, Linus Torvalds wrote:
> > On Sat, 6 Dec 2008, Rafael J. Wysocki wrote:
> > > I think it should go through Jesse?
> >
> > Probably correct. And we want it in -next, so that it can get some
> > testing even before I open the merge window. Because I hope everybody
> > realizes that there's no way we're doing this in 2.6.28, and we'll leave
> > the broken and unreliable suspend.
> >
> > Because afaik this is not a new bug (I tried to push a patch to do
> > suspend_late/resume_early for the PCI code a _loong_ time ago, but it
> > never got merged), and the only reason it showed up as a regression was
> > almost certainly simply that we've always had this.
> >
> > IOW, suspend/resume has always been dodgy wrt interrupts, and there's
> > some luck involved. And your machine just happened to get unlucky.
> >
> > I'd love to fix this in 2.6.28, but it's just not reasonable - it needs
> > widespread testing with an early -rc merge. And if it turns out to fix a
> > lot of machines, and there are no regressions, we can always back-port it
> > later.
>
> I agree.

I'll stuff it into my -next branch tonight.

-- 
Jesse Barnes, Intel Open Source Technology Center
