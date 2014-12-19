From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RFC v3 1/2] PM / Domains: Extend API pm_genpd_dev_need_restore to use restore types
Date: Fri, 19 Dec 2014 03:17:32 +0100
Message-ID: <4455852.nsjCIYrEMg@vostro.rjw.lan>
References: <1418489518-7252-1-git-send-email-amit.daniel@samsung.com> <5418986.E58ik2Q1Hm@vostro.rjw.lan> <5492A6DE.5020704@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5492A6DE.5020704@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Kevin Hilman <khilman@kernel.org>, amit daniel kachhap <amit.daniel@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, LAK <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Len Brown <len.brown@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 18, 2014 11:05:18 AM Sylwester Nawrocki wrote:
> On 18/12/14 01:58, Rafael J. Wysocki wrote:
> >>>> What's needed to solve this problem is a generalized way to have runtime
> >>>> > >> PM dependencies between devices.  Runtime PM already automatically
> >>>> > >> handles parent devices as one type of dependent device (e.g. a parent
> >>>> > >> device needs to be runtime PM resumed before its child.)  So what's
> >>>> > >> needed is a generic way to other PM dependencies with the runtime PM
> >>>> > >> core (not the genpd core.)
> >>> > >
> >>> > > Considering the example above with three devices, device D1 and D2 are
> >>> > > passive components in this power domain. These devices only need to
> >>> > > know the state changes of the power domains but would not control the
> >>> > > power domain themselves nor put forth constraints in the power domain
> >>> > > state changes. So I did not clearly understand as to how this example
> >>> > > could be solved by introducing changes in runtime PM core.
> >> > 
> >> > Your solution only solves the problems for devices managed by genpd.
> >> > 
> >> > If I understood your example correctly, what you really want to solve
> >> > this problem more generically is to be able to tell the runtime PM core
> >> > that D3 has a dependency on D1 and D2.  Then, whenver the runtime PM
> >> > core is doing get/put operations for D3, it needs to also do them for D1
> >> > and D2.
> 
> Indeed, I think it would solve most of the problems if we were able to
> model the PM dependencies between devices which would then be handled
> in the PM core.  I recall something like this has been proposed a while
> ago [1].

Exactly.

And I'm going to revive it in a slightly simplified form.

> >> > This will accomplish the same as your proposed approach, but work for
> >> > any devices in any PM domains.
> >
> > Plus, it is not limited to runtime PM, really.  It affects system suspend
> > too.
> 
> [1] https://lkml.org/lkml/2009/8/26/485
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
