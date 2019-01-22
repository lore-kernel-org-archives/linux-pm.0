From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: power: sc27xx: Add one IIO channel to
 read charge voltage
Date: Mon, 21 Jan 2019 18:50:09 -0600
Message-ID: <20190122005009.GA28344@bogus>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, zhang.lyra@gmail.com, orsonzhai@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, 15 Jan 2019 18:32:34 +0800, Baolin Wang wrote:
> Add one IIO channel named "charge_vol" to read the charge voltage for
> the SC27XX fuel gauge controller.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
