From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v3 0/4] ARM: EXYNOS: Power domain DT support extension
Date: Tue, 20 Nov 2012 13:53:20 +0900
Message-ID: <0b6e01cdc6da$f6b723e0$e4256ba0$%kim@samsung.com>
References: <1352811115-1198-1-git-send-email-t.figa@samsung.com>
 <1552856.8ocEO5iISn@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49030 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab2KTExX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Nov 2012 23:53:23 -0500
In-reply-to: <1552856.8ocEO5iISn@amdc1227>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Tomasz Figa' <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, thomas.abraham@linaro.org, rjw@sisk.pl, m.szyprowski@samsung.com, tomasz.figa@gmail.com

Tomasz Figa wrote:
> 
> Hi,
> 
> On Tuesday 13 of November 2012 13:51:51 Tomasz Figa wrote:
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
> Sorry, please disregard this series, as I have sent wrong version by
> mistake.
> 
> I will send correct one later.
> 
OK.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

