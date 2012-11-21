From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v3 RESEND 0/4] ARM: EXYNOS: Power domain DT support
 extension
Date: Wed, 21 Nov 2012 21:15:43 +0900
Message-ID: <0e7b01cdc7e1$edbb5a60$c9320f20$%kim@samsung.com>
References: <1352812107-8777-1-git-send-email-t.figa@samsung.com>
 <3937720.DSR9HIu3D4@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <3937720.DSR9HIu3D4@amdc1227>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Tomasz Figa' <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, thomas.abraham@linaro.org, rjw@sisk.pl, m.szyprowski@samsung.com, tomasz.figa@gmail.com
List-Id: linux-pm@vger.kernel.org

Tomasz Figa wrote:
> 
> Hi Kgene,
> 
> On Tuesday 13 of November 2012 14:08:23 Tomasz Figa wrote:
> > This patch series fixes two issues with existing DT support for Exynos
> > power domains and extends it with the ability of binding devices to
> > domains, basically making it possible to use power domains with DT.
> >
> > Based on for-next branch of Kgene's tree.
> >
> > Changes since v2:
> >  - Rebased to for-next of Kgene's tree.
> > Changes since v1:
> >  - Added "samsung," prefix to "power-domain" property.
> >  - Added power domain nodes to Exynos4 device tree sources.
> >
> > Tomasz Figa (4):
> >   ARM: EXYNOS: pm_domain: Detect domain state on registration from DT
> >   ARM: EXYNOS: pm_domain: Fix power domain name initialization
> >   ARM: EXYNOS: pm_domain: Bind devices to power domains using DT
> >   ARM: dts: exynos4: Set up power domains
> >
> >  .../bindings/arm/exynos/power_domain.txt           | 15 +++-
> >  arch/arm/boot/dts/exynos4.dtsi                     | 30 +++++++
> >  arch/arm/boot/dts/exynos4210.dtsi                  |  5 ++
> >  arch/arm/mach-exynos/pm_domains.c                  | 93
> > +++++++++++++++++++++- 4 files changed, 135 insertions(+), 8
> > deletions(-)
> 
> Since this version is just a rebase to your for-next and there are no
> remaining comments, could you still take it for 3.8?
> 
Well, I'm not sure 'S5P_INT_LOCAL_PWR_EN' in [1/4] patch is available on all
of exynos and it can support multiple platform. But at this moment, looks OK
to me. If any modification is required, we can do it later.

Will apply, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
