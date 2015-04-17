From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
Date: Fri, 17 Apr 2015 15:08:19 +0100
Message-ID: <20150417140819.GB2347@red-moon>
References: <1428490480-10144-1-git-send-email-tomeu.vizoso@collabora.com>
 <20150408115546.GA24271@red-moon>
 <552643E1.3060200@collabora.com>
 <285738930.THBQOWvsah@vostro.rjw.lan>
 <20150410100844.GC23730@red-moon>
 <CAAObsKAihF1k1yzZxQEs_jpPnCdV3HQbLaYHWu1QNsNd5zqiOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKAihF1k1yzZxQEs_jpPnCdV3HQbLaYHWu1QNsNd5zqiOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 16, 2015 at 03:37:19PM +0100, Tomeu Vizoso wrote:

[...]

> >> I don't know what FIQs are. :-)
> >
> > In short, fast IRQs, it is a separate IRQ line handled as a separate
> > exception source with some private (banked) registers that minimize registers
> > saving/restoring. They are not identical to NMI on x86, since
> > their behaviour (handling) may be overriden by platforms and they
> > can be masked.
> >
> >> ->enter_freeze is entered with interrupts disabled on the local CPU.  It is
> >> not supposed to re-enable them.  That is, while in the ->enter_freeze callback
> >> routine, the CPU must not be interrupted aby anything other than NMI.
> >
> > It boils down to what FIQs handlers are allowed to do with tick frozen
> > and what they are (may be) currently used for.
> >
> > Russell has more insights on this than I do, in particular what FIQs are
> > currently used for on ARM and if we can leave them enabled safely with tick
> > frozen.
> 
> But even if it's currently safe to leave them enabled, is there any
> reason for not disabling them?

Ok, the point here is: either it is safe, and you leave them enabled,
or it is not and we must disable them *before* enter_freeze() is entered.

Disabling them in the platform enter_freeze() hook does not make sense,
because this means we run with FIQs enabled with tick frozen, either
it is safe or it is not, it can't be both.

I would ask Russell opinion on this, before making any decision.

Lorenzo
