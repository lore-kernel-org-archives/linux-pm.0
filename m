From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/8] clk: samsung: add needed IDs for DMC clocks in
  Exynos5420
Date: Mon, 11 Mar 2019 17:06:50 -0500
Message-ID: <20190311220650.GB4082@bogus>
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190305101924eucas1p1147e3895a89a72c9db7d128d90dd3daa@eucas1p1.samsung.com>
 <1551781151-5562-2-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551781151-5562-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue,  5 Mar 2019 11:19:04 +0100, Lukasz Luba wrote:
> Define new IDs for clocks used by Dynamic Memory Controller in
> Exynos5422 SoC.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
