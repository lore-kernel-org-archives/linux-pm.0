From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 03/18] thermal: exynos: always check for critical trip
 points existence
Date: Tue, 1 May 2018 11:00:18 +0200
Message-ID: <20180501090018.GF27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <1524743493-28113-4-git-send-email-b.zolnierkie@samsung.com>
 <20180430144450.GI11457@mai>
 <CGME20180430152416eucas1p10bde2c1501e7f5f4b284caca3b630ea3@eucas1p1.samsung.com>
 <5229331.iYYXeBBCxK@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5229331.iYYXeBBCxK@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 30, 2018 at 05:24:15PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Monday, April 30, 2018 04:44:50 PM Daniel Lezcano wrote:
> > On Thu, Apr 26, 2018 at 01:51:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > * Check for critical trip point existence in exynos_tmu_initialize()
> > >   so it is checked on all SoCs (except Exynos5433 for now).
> > 
> > Why "except Exynos5433" ?
> 
> I was a bit vague here - Exynos5433 DTS needs to be fixed first to define
> critical trip points.

Is it possible to fix the DT in the series, so we get rid of the "FIXME" ?

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
