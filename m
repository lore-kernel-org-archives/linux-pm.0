From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] thermal: exynos: Document number of supported
 trip-points
Date: Sun, 21 Feb 2016 20:55:04 -0600
Message-ID: <20160222025504.GQ15973@rob-hp-laptop>
References: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
 <1455772460-20684-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455772460-20684-2-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 18, 2016 at 02:14:19PM +0900, Krzysztof Kozlowski wrote:
> Document the number of configurable temperature thresholds (for
> trip-points in interrupt-driven mode).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
