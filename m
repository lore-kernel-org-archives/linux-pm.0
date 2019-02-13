From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date: Wed, 13 Feb 2019 15:07:46 -0600
Message-ID: <20190213210746.GA2989@bogus>
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47@eucas1p1.samsung.com>
 <1549039612-28905-2-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549039612-28905-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 01, 2019 at 05:46:45PM +0100, Lukasz Luba wrote:
> Define new IDs for clocks used by Dynamic Memory Controller in
> Exynos5422 SoC.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
