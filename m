From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH v4 00/16] ARM: shmobile: Add CPG/MSTP Clock Domain
Date: Thu, 6 Aug 2015 09:50:30 +0900
Message-ID: <20150806005029.GE17231@verge.net.au>
References: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
 <20150804134824.GA10194@verge.net.au>
 <20150805005543.GC20726@verge.net.au>
 <CAMuHMdUFjgVWBc0hdm_L0Z0Os1OT8H4NzwQyQTGZQt8Bu7-9PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUFjgVWBc0hdm_L0Z0Os1OT8H4NzwQyQTGZQt8Bu7-9PQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 05, 2015 at 08:58:29AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Aug 5, 2015 at 2:55 AM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> > On Tue, Aug 04, 2015 at 10:48:28PM +0900, Simon Horman wrote:
> >> I have tentatively queued this up in its own branch,
> >> cpg-mstp-clock-domain-for-v4.3.
> >
> > Where possible I prefer not to apply non-DTS/DTSI patches on top of
> > DTS/DTSI patches, I believe this is in keeping with how the ARM SoC
> > maintainers like things handled.  With this in mind I have shuffled things
> > around a little, the result is:
> >
> > 1. The following are (still) queued up for v4.3 in their own
> >    cpg-mstp-clock-domain-for-v4.3 branch:
> >
> >    clk: shmobile: Add CPG/MSTP Clock Domain support
> >    clk: shmobile: r8a7778: Add CPG/MSTP Clock Domain support
> >    clk: shmobile: r8a7779: Add CPG/MSTP Clock Domain support
> >    clk: shmobile: rcar-gen2: Add CPG/MSTP Clock Domain support
> >    clk: shmobile: rz: Add CPG/MSTP Clock Domain support
> >    ARM: shmobile: r7s72100 dtsi: Add CPG/MSTP Clock Domain
> >    ARM: shmobile: r8a7778 dtsi: Add CPG/MSTP Clock Domain
> >    ARM: shmobile: r8a7779 dtsi: Add CPG/MSTP Clock Domain
> >    ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain
> >    ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain
> >    ARM: shmobile: r8a7793 dtsi: Add CPG/MSTP Clock Domain
> >    ARM: shmobile: r8a7794 dtsi: Add CPG/MSTP Clock Domain
> 
> OK.
> 
> > 2. The following are now queued up for v4.3 in a separate
> >    sh-drivers-for-v4.3 branch. That branch is on top of the
> >    cpg-mstp-clock-domain-for-v4.3 branch and I intend to send it directly
> >    to Linus if/when a v4.3-rc has been released with the patches
> >    listed in 1. present.
> >
> >    drivers: sh: Disable legacy default PM Domain on emev2
> >    drivers: sh: Disable PM runtime for multi-platform ARM with genpd
> 
> OK
> 
> > 3. I have deferred the remaining two patches, listed below, for v4.4.
> >    they currently reside in cpg-mstp-clock-domain-for-v4.4. That
> >    branch is based on the sh-drivers-for-v4.3 branch.
> >
> >    clk: shmobile: mstp: Consider "zb_clk" suitable for power management
> >    ARM: shmobile: R-Mobile: Use CPG/MSTP Clock Domain attach/detach helpers
> >
> > This means that the last two patches will disappear from next until
> > after v4.3-rc1 is released but they, along with all the other patches,
> > will be present in the renesas devel branch.
> 
> OK.
> 
> Note that as the last two depend on patch 1 only, you could e.g. queue
> them up in group 1, between the clk and dtsi patches.
> But it's up to you to reconsider.
> I'm happy as-is, as the last two patches are just a code duplication clean up.

Thanks, and sorry for not realising that.

For now I will keep things as-is because I would like to stabilise my
branches.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
