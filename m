From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] DRM / i915: Fix resume regression on MSI
	Wind U100 w/o KMS
Date: Mon, 11 Jan 2010 22:04:36 +0100
Message-ID: <201001112204.36724.rjw__48444.1377725036$1263244007$gmane$org@sisk.pl>
References: <201001090045.33784.rjw@sisk.pl>
	<20100111083825.4c2bb7b3@jbarnes-piketon>
	<21d7e9971001111212h1ded5292l94d514c6f5a47cd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <21d7e9971001111212h1ded5292l94d514c6f5a47cd4@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Jerome Glisse <glisse@freedesktop.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 11 January 2010, Dave Airlie wrote:
> On Tue, Jan 12, 2010 at 2:38 AM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> > On Sun, 10 Jan 2010 07:32:30 +1000
> > Dave Airlie <airlied@gmail.com> wrote:
> >> I'm in the 2-3 years at a minimum, with at least one kernel with no
> >> serious regressions in Intel KMS, which we haven't gotten close to
> >> yet. I'm not even sure the Intel guys are taking stable seriously
> >> enough yet. So far I don't think there is one kernel release (even
> >> stable) that works on all Intel chipsets without
> >> backporting patches. 2.6.32 needs the changes to remove the messed up
> >> render clock hacks which should really have been reverted a lot
> >> earlier since we had a lot of regression reports. The number of users
> >> using powersave=0 to get anything approaching useable is growing etc.
> >
> > But you could apply that argument to the existing DRM code (not just
> > Intel) as well; lots of things are broken or unimplemented and never
> > get fixed.  I'd say the right metric isn't whether regressions are
> > introduced (usually due to new features) but whether the driver is
> > better than the old userspace code.  For Intel at least, I think we're
> > already there.  The quality of the kernel driver is higher and it has
> > many more features than the userspace implementation ever did.  That's
> > just my subjective opinion, but I've done a *lot* of work on our bugs
> > both in userspace and in the kernel, so I think it's an accurate
> > statement.
> 
> The problem is at any single point in time I'm not sure a kms kernel
> exists that works across all the Intel hw, which from a distro POV is a real
> pain in the ass, a regression gets fixed on one piece of hw just as
> another on a different piece gets introduced.
> 
> I'd really like if Intel devs could either slow it down and do more testing
> before pushing to Linus, or be a lot quicker with the reverts when stuff
> is identified. The main thing is the render reclocking lately, thats been a
> nightmare and as far as I can see 2.6.32.3 still has all the issues,

Hmm, are you trying to say radeon is better at that?

My experience is quite the opposite to be honest.

Rafael
