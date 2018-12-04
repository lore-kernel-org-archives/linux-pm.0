From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: power: supply: Add nvmem properties to
 calibrate FGU
Date: Tue, 4 Dec 2018 15:09:32 -0600
Message-ID: <20181204210932.GA26066@bogus>
References: <cover.1542185618.git.baolin.wang@linaro.org>
 <09143dca85a260cb6c3abc5efcf09075a8050265.1542185618.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <09143dca85a260cb6c3abc5efcf09075a8050265.1542185618.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 14 Nov 2018 17:07:04 +0800, Baolin Wang wrote:
> Add nvmem properties to calibrate FGU from eFuse controller.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
