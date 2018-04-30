From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 03/18] thermal: exynos: always check for critical trip
 points existence
Date: Mon, 30 Apr 2018 17:24:15 +0200
Message-ID: <5229331.iYYXeBBCxK@amdc3058>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-4-git-send-email-b.zolnierkie@samsung.com>
        <20180430144450.GI11457@mai>
        <CGME20180430152416eucas1p10bde2c1501e7f5f4b284caca3b630ea3@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180430144450.GI11457@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 30, 2018 04:44:50 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > * Check for critical trip point existence in exynos_tmu_initialize()
> >   so it is checked on all SoCs (except Exynos5433 for now).
> 
> Why "except Exynos5433" ?

I was a bit vague here - Exynos5433 DTS needs to be fixed first to define
critical trip points.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
