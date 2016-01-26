From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] PM / Domains: Fix potential deadlock while adding/removing subdomains
Date: Tue, 26 Jan 2016 17:29:02 +0100
Message-ID: <1836647.hSb4NIz598@vostro.rjw.lan>
References: <1453288059-1988-1-git-send-email-ulf.hansson@linaro.org> <CAMuHMdUfSCRh6Nxrfm9pSY2HvC3WKJ6_ZtFgzscv=9GoYR+puQ@mail.gmail.com> <CAPDyKFqb5q0fokUo2mU=9SrEEA7aq6ZVQfz9UvuEMKhj+edrUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50936 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S966230AbcAZQ2L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2016 11:28:11 -0500
In-Reply-To: <CAPDyKFqb5q0fokUo2mU=9SrEEA7aq6ZVQfz9UvuEMKhj+edrUw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Tuesday, January 26, 2016 03:59:19 PM Ulf Hansson wrote:
> On 26 January 2016 at 14:13, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Hi Rafael,
> >
> > On Sun, Jan 24, 2016 at 2:20 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> On Wednesday, January 20, 2016 12:07:39 PM Ulf Hansson wrote:
> >>> We must preserve the same order of how we acquire and release the lock for
> >>> genpd, as otherwise we may encounter deadlocks.
> >>>
> >>> The power on phase of a genpd starts by acquiring its lock. Then it walks
> >>> the hierarchy of its parent domains to be able to power on these first, as
> >>> per design of genpd.
> >>>
> >>> From a locking perspective this means the locks of the parents becomes
> >>> acquired after the lock of the subdomain.
> >>>
> >>> Let's fix pm_genpd_add|remove_subdomain() to maintain the same order of
> >>> acquiring/releasing the genpd lock as being applied in the power on/off
> >>> sequence.
> >>>
> >>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>
> >> Applied, thanks!
> >
> > It looks like you accidentally applied v1, introducing the lockdep warnings
> > fixed in v2?
> >
> 
> Correct, it's the v1.
> 
> Rafael, if you can't replace the patch I can send an incremental fix
> on top. Just tell me what way you prefer.

Can you please send the whole patch again?

Thanks,
Rafael

