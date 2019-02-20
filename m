From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v7 0/3] Fixes for Tegra soctherm
Date: Wed, 20 Feb 2019 10:14:01 +0800
Message-ID: <1550628841.3372.1.camel@intel.com>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
         <28d197f9-9b72-78ad-0769-7514d329b3c4@nvidia.com>
         <1c0af72c-b8d5-9b2d-7bc1-86a2ae85c819@nvidia.com>
         <df2493f3-4bbd-65d1-1205-073a30729a89@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <df2493f3-4bbd-65d1-1205-073a30729a89@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Ni <wni@nvidia.com>, daniel.lezcano@linaro.org, edubezval@gmail.com
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 一, 2019-02-18 at 15:59 +0800, Wei Ni wrote:
> Rui,
> Will you take this serial?
> 
it is already in my tree.
I missed -rc6, thus I will queue them for 5.1-rc1.

thanks,
rui

> Thanks.
> Wei.
> 
> On 21/1/2019 5:17 PM, Wei Ni wrote:
> > 
> > Does there have any comments?
> > 
> > Thanks.
> > Wei.
> > 
> > On 11/1/2019 10:20 AM, Wei Ni wrote:
> > > 
> > > Hi Eduardo,
> > > Do you have any more comments, will you take this serial?
> > > 
> > > Thanks.
> > > Wei.
> > > 
> > > On 3/1/2019 6:12 PM, Wei Ni wrote:
> > > > 
> > > > This series fixed some issues for Tegra soctherm,
> > > > and add get_trend().
> > > > 
> > > > Main changes from v6:
> > > > 1. Per Eduardo's comment, we can remove the change:
> > > > "thermal: tegra: parse sensor id before sensor register"
> > > > 
> > > > Main changes from v5:
> > > > 1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/
> > > > 643
> > > > into this serial.
> > > > 
> > > > Main changes from v4:
> > > > 1. fixed for the parsing sensor id.
> > > > 2. keep warning for missing critical trips.
> > > > 
> > > > Main changes from v3:
> > > > 1. updated codes for parsing sensor id, per Thierry's comments
> > > > 
> > > > Main changes from v2:
> > > > 1. add codes to parse sensor id to avoid registration
> > > > failure.
> > > > 
> > > > Main changes from v1:
> > > > 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
> > > > "thermal: tegra: fix memory allocation".
> > > > 2. Print out the sensor name when register failed.
> > > > 2. Remove patch "thermal: tegra: fix coverity defect"
> > > > 
> > > > Wei Ni (3):
> > > >   thermal: tegra: remove unnecessary warnings
> > > >   thermal: tegra: fix memory allocation
> > > >   thermal: tegra: add get_trend ops
> > > > 
> > > >  drivers/thermal/tegra/soctherm.c | 40
> > > > +++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 37 insertions(+), 3 deletions(-)
> > > > 
