From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 14:56:22 +0100
Message-ID: <20100505135621.GB7139__18159.0921165936$1273067838$gmane$org@rakim.wolfsonmicro.main>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<201005042223.41370.rjw@sisk.pl>
	<20100504235644.GA5231@opensource.wolfsonmicro.com>
	<201005050222.31038.rjw@sisk.pl>
	<20100505110630.GA5754@opensource.wolfsonmicro.com>
	<j2xa55d774e1005050500ocaa77b0di8e9eb58ce9c82d58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <j2xa55d774e1005050500ocaa77b0di8e9eb58ce9c82d58@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 05:00:33AM -0700, Brian Swetland wrote:

> I haven't spent much time looking at alsa/asoc yet, but it's on my
> list for 2010 -- I'm hoping to migrate the very simple audio drivers I
> wrote for the msm platform originally to actually be alsa drivers as
> part of the general "try to use existing interfaces if they fit" plan
> we've been working toward.

Yup, that'd be good - even with the AP/CP/CODEC SoCs like the MSM
devices we really need to get ASoC integration since systems are being
built hanging external components such as speaker drivers off the line
outputs, and some of those have registers so really do benefit from the
sequencing, automated PM and so on that ASoC offers.

There was some work on MSM ASoC support posted last year back but there
were a number of review issues with it.  Daniel Walker also talked about
submitting stuff just before Christmas, quite possibly independently of
the other work which looked like a community effort, but I've not seen
anything through from that yet.

> The suspend_block system gets us what we need today (well what we
> needed three years ago too!) to ship and hit reasonable power targets
> on a number of platforms.  There's been a lot of various handwaving
> about "android kernel forks" and what have you, but here we are again,
> trying to work out perhaps the only "new subsystem" type change that
> our driver code depends on (almost all other contentious stuff is self
> contained and you can take or leave it).

> Our hope here is to get something out there in the near term so that
> the various drivers we maintain would "just work" in mainline (your
> choice of if you use suspend_block or not -- it's designed to be an
> option) and we can move forward.  If in the future runtime power
> management or other systems completely obsolete suspend_blockers,
> awesome, we remove 'em.

Like I've said a few times here I broadly agree with your goals - they
seem to be a reasonable solution to the engineering problems we face
presently, even though they're not where we actually want to be.  What
I do miss from the current proposal is more consideration of how things
that do need to ignore the suspend should integrate.

If the conclusion is that we don't have anything generic within the
kernel then it'd be good to at least have this explicitly spelled out so
that we're clear what everyone thinks is going on here and how things
are supposed to work.  At the minute it doesn't feel like we've had the
discussion so we could end up working at cross purposes.  I don't want
to end up in the situation where I have to work around the APIs I'm
using without the relevant maintainers having sight of that since that
not only am I likely to be missing some existing solution to the problem
but is also prone to causing problems maintaining the underlying API.

This hasn't been a pressing issue while the Android code is out of tree
since we can just say it's an out of tree patch that has a different
design approach to current mainline and it's fairly straightforward for
users to introduce suitable system-specific changes.  Once it's mainline
and part of the standard Linux PM toolkit then obviously subsystems and
drivers need to support opportunistic suspend properly in mainline.
