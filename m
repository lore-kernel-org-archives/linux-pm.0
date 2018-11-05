From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: power: supply: bq24190_charger: add
 bq24192 and usb-otg-vbus
Date: Mon, 5 Nov 2018 15:59:16 -0600
Message-ID: <20181105215916.GA9820@bogus>
References: <20181101001149.13453-1-masneyb@onstation.org>
 <20181101001149.13453-2-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101001149.13453-2-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org, linus.walleij@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org, jonathan@marek.ca, masneyb@onstation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 31 Oct 2018 20:11:43 -0400, Brian Masney wrote:
> Add support for the ti,bq24192 variant and a child node for the
> usb-otg-vbus regulator.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../devicetree/bindings/power/supply/bq24190.txt         | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
