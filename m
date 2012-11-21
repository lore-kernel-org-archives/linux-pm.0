From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v3 RESEND 0/4] ARM: EXYNOS: Power domain DT support
 extension
Date: Wed, 21 Nov 2012 11:38:07 +0100
Message-ID: <3937720.DSR9HIu3D4@amdc1227>
References: <1352812107-8777-1-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1352812107-8777-1-git-send-email-t.figa@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, rjw@sisk.pl, m.szyprowski@samsung.com, tomasz.figa@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Kgene,

On Tuesday 13 of November 2012 14:08:23 Tomasz Figa wrote:
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

Since this version is just a rebase to your for-next and there are no 
remaining comments, could you still take it for 3.8?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
