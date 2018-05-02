From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 06/18] thermal: exynos: fix trips limit checking in
 get_th_reg()
Date: Wed, 02 May 2018 11:19:06 +0200
Message-ID: <2166794.yRDuDm3vze@amdc3058>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <26762578.lZtk787caq@amdc3058> <20180501093914.GG27619@mai>
        <CGME20180502091907eucas1p17017c6793fb49f0c90660b3042b803bb@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180501093914.GG27619@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 01, 2018 11:39:14 AM Daniel Lezcano wrote:
> On Mon, Apr 30, 2018 at 05:48:29PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Monday, April 30, 2018 05:34:31 PM Daniel Lezcano wrote:
> > > On Thu, Apr 26, 2018 at 01:51:21PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > of_thermal_get_ntrips() may return value bigger than supported
> > > > by a given SoC (i.e. on Exynos5422/5800) 
> > > 
> > > Can you elaborate a bit ?
> > 
> > Odroid-XU3 DTS file [1] define 6 thermal trip points (2 passive ones)
> > while data->ntrip is 4, the current code works fine by accident as
> > the threshold values for trip points 5 & 6 don't fit into 32-bits
> > threshold value (however since they are passive ones this is okay).
> 
> Ah, I see. data->ntrip is the SoC specific tmu max value capping what is
> defined in the DT, right ?

It is SoC specific max value for active + critical trips points.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
