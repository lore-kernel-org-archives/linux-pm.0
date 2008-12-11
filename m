From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] Sound (HDA Intel): Restore PCI
	configuration space with interrupts off
Date: Thu, 11 Dec 2008 21:38:56 +0100
Message-ID: <200812112138.57145.rjw__12867.6881701269$1229028183$gmane$org@sisk.pl>
References: <200812020320.31876.rjw@sisk.pl> <200812112103.17018.rjw@sisk.pl>
	<s5h7i66v4nb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <s5h7i66v4nb.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 11 of December 2008, Takashi Iwai wrote:
> At Thu, 11 Dec 2008 21:03:16 +0100,
> Rafael J. Wysocki wrote:
> > 
> > On Thursday, 11 of December 2008, Takashi Iwai wrote:
> > > At Sun, 07 Dec 2008 10:47:56 +0100,
> > > I wrote:
> > > > 
> > > > At Sat, 6 Dec 2008 20:45:35 -0800,
> > > > Jesse Barnes wrote:
> > > > > 
> > > > > On Saturday, December 6, 2008 6:09 am Rafael J. Wysocki wrote:
> > > > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > > > Subject: Sound (HDA Intel): Restore PCI configuration space with interrupts
> > > > > > off
> > > > > >
> > > > > > Move the restoration of the standard PCI configuration registers
> > > > > > in the snd_hda_intel driver to a ->resume_early() callback executed
> > > > > > with interrupts disabled, since doing that with interrupts enabled
> > > > > > may lead to problems in some cases.
> > > > > >
> > > > > > This patch addresses the regression from 2.6.26 tracked as
> > > > > > http://bugzilla.kernel.org/show_bug.cgi?id=12121 .
> > > > > 
> > > > > Since I only applied 1 and 2 you'll need to send this one through Takashi.
> > > > 
> > > > OK, I merged it to for-next branch now.
> > > > It should appear in the linux-next tree of tomorrow.
> > > 
> > > There is no build errors at least on linux-next, but I guess the
> > > testing about PM has been rarely done on linux-next kernel...
> > > 
> > > BTW, Rafael, is this particular patch (against hda_intel.c) works in
> > > general or dependent on other two patches?
> > 
> > It should be safe without the other patches too.
> 
> OK, but this alone doesn't make much sense without others, right?
> 
> I'm asking this because I'm not pretty sure how this should be handled.
> Certainly it must be in 2.6.29, but about for 2.6.28...

Well, I think 2.6.29 would be fine.

Thanks,
Rafael
