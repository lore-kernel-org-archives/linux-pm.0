From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 03/18] thermal: exynos: always check for critical trip
 points existence
Date: Wed, 02 May 2018 11:16:30 +0200
Message-ID: <10453315.SITKVXMJzS@amdc3058>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <5229331.iYYXeBBCxK@amdc3058> <20180501090018.GF27619@mai>
        <CGME20180502091631eucas1p1e310f34a39383e01cfbf9eef992db260@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180501090018.GF27619@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 01, 2018 11:00:18 AM Daniel Lezcano wrote:
> On Mon, Apr 30, 2018 at 05:24:15PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Monday, April 30, 2018 04:44:50 PM Daniel Lezcano wrote:
> > > On Thu, Apr 26, 2018 at 01:51:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > * Check for critical trip point existence in exynos_tmu_initialize()
> > > >   so it is checked on all SoCs (except Exynos5433 for now).
> > > 
> > > Why "except Exynos5433" ?
> > 
> > I was a bit vague here - Exynos5433 DTS needs to be fixed first to define
> > critical trip points.
> 
> Is it possible to fix the DT in the series, so we get rid of the "FIXME" ?

This DT change needs more effort so it is planned for some later time
(also doing it in this series would create dependency on arm-soc tree).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
