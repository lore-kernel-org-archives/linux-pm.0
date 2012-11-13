From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v3 0/4] ARM: EXYNOS: Power domain DT support extension
Date: Tue, 13 Nov 2012 14:00:11 +0100
Message-ID: <1552856.8ocEO5iISn@amdc1227>
References: <1352811115-1198-1-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18919 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab2KMNAP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Nov 2012 08:00:15 -0500
In-reply-to: <1352811115-1198-1-git-send-email-t.figa@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, rjw@sisk.pl, m.szyprowski@samsung.com, tomasz.figa@gmail.com

Hi,

On Tuesday 13 of November 2012 13:51:51 Tomasz Figa wrote:
> This patch series fixes two issues with existing DT support for Exynos
> power domains and extends it with the ability of binding devices to
> domains, basically making it possible to use power domains with DT.
> 
> Based on for-next branch of Kgene's tree.
> 
> Changes since v2:
>  - Rebased to for-next of Kgene's tree.
> Changes since v1:
>  - Added "samsung," prefix to "power-domain" property.
>  - Added power domain nodes to Exynos4 device tree sources.
> 
> Tomasz Figa (4):
>   ARM: EXYNOS: pm_domain: Detect domain state on registration from DT
>   ARM: EXYNOS: pm_domain: Fix power domain name initialization
>   ARM: EXYNOS: pm_domain: Bind devices to power domains using DT
>   ARM: dts: exynos4: Set up power domains
> 
>  .../bindings/arm/exynos/power_domain.txt           | 15 +++-
>  arch/arm/boot/dts/exynos4.dtsi                     | 30 +++++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |  5 ++
>  arch/arm/mach-exynos/pm_domains.c                  | 93
> +++++++++++++++++++++- 4 files changed, 135 insertions(+), 8
> deletions(-)

Sorry, please disregard this series, as I have sent wrong version by 
mistake.

I will send correct one later.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform

